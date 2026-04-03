import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:video_player/video_player.dart';

import 'package:kwon_tiktoc_clone/domain/entity/video.dart';
import 'package:kwon_tiktoc_clone/presentation/feed/provider/feed_provider.dart';

part 'video_player_manager.g.dart';

/// 비디오 플레이어 컨트롤러를 중앙 관리하는 Manager.
/// 현재 페이지 ± 1 범위의 컨트롤러만 유지하여 메모리를 관리한다.
@Riverpod(keepAlive: true)
class VideoPlayerManager extends _$VideoPlayerManager {
  final Map<int, VideoPlayerController> _controllers = {};
  final Set<int> _initializing = {};
  final Set<int> _disposed = {};
  bool _isDisposed = false;
  int _generation = 0; // disposeAll 호출 시 증가, 이전 세대 비동기 작업 무효화

  static const _initTimeout = Duration(seconds: 5);

  @override
  Map<int, VideoPlayerController> build() {
    _isDisposed = false;
    ref.onDispose(() {
      _isDisposed = true;
      _disposeAll();
    });

    // feedNotifier 변경 시 자동 반응 (탭 전환 + 페이지 변경)
    ref.listen(feedNotifierProvider, (prev, next) {
      final nextState = next.valueOrNull;
      if (nextState == null) return;

      final prevTab = prev?.valueOrNull?.selectedTab;
      final nextTab = nextState.selectedTab;
      final prevIndex = prev?.valueOrNull?.currentIndex;
      final nextIndex = nextState.currentIndex;
      final prevVideoCount = prev?.valueOrNull?.displayVideos.length;
      final nextVideoCount = nextState.displayVideos.length;

      // 탭 전환 시 모든 컨트롤러 dispose 후 재초기화
      if (prevTab != null && prevTab != nextTab) {
        _disposeAll();
        _onPageChanged(nextIndex, nextState.displayVideos);
        return;
      }

      // 영상 삭제 등으로 목록 크기가 변경된 경우: 기존 컨트롤러만 정리
      // 새 컨트롤러 초기화는 FeedPage에서 PageController 재생성 후 수행
      if (prevVideoCount != null && prevVideoCount != nextVideoCount) {
        _disposeAll();
        state = Map.unmodifiable(_controllers);
        return;
      }

      if (nextIndex != prevIndex) {
        _onPageChanged(nextIndex, nextState.displayVideos);
      }
    });

    return _controllers;
  }

  /// 페이지 변경 시 호출: 재생/정지/dispose 관리
  /// currentIndex는 displayVideos 기준 인덱스(0~length-1)
  void _onPageChanged(int currentIndex, List<Video> videos) {
    if (videos.isEmpty || _isDisposed) return;

    // 1. 유지할 범위 계산 (currentIndex ± 1, 루프 고려)
    final keepRange = <int>{};
    final len = videos.length;
    for (var offset = -1; offset <= 1; offset++) {
      final i = ((currentIndex + offset) % len + len) % len;
      keepRange.add(i);
    }

    // 2. 범위 밖 컨트롤러 dispose
    final toRemove = _controllers.keys
        .where((i) => !keepRange.contains(i))
        .toList();
    for (final index in toRemove) {
      _disposed.add(index);
      _controllers[index]?.dispose();
      _controllers.remove(index);
    }

    // 3. 범위 내 컨트롤러 초기화 (없으면 생성, URL 불일치 시 재생성)
    for (final index in keepRange) {
      final expectedVideo = videos[index];
      final expectedUrl = expectedVideo.hlsUrl.isNotEmpty
          ? expectedVideo.hlsUrl
          : expectedVideo.videoUrl;
      final existing = _controllers[index];

      // 기존 컨트롤러의 URL이 현재 영상과 다르면 재생성
      if (existing != null && existing.dataSource != expectedUrl) {
        _disposed.add(index);
        existing.dispose();
        _controllers.remove(index);
      }

      if (!_controllers.containsKey(index) && !_initializing.contains(index)) {
        _disposed.remove(index);
        _initController(index, expectedVideo);
      }
    }

    // 4. 현재 페이지만 재생, 나머지 정지
    for (final entry in _controllers.entries) {
      final controller = entry.value;
      if (!controller.value.isInitialized) continue;

      if (entry.key == currentIndex) {
        controller.play();
      } else {
        controller.pause();
      }
    }

    state = Map.unmodifiable(_controllers);
  }

  /// 컨트롤러 초기화 (타임아웃 + 레이스 컨디션 보호 + HLS→MP4 fallback + 재시도)
  Future<void> _initController(int index, Video video) async {
    final gen = _generation;
    _initializing.add(index);

    // HLS 우선 시도 (적응형 비트레이트로 빠름), 실패 시 MP4 fallback
    final hasHls = video.hlsUrl.isNotEmpty;
    final hasMp4 = video.videoUrl.isNotEmpty;
    final playUrl = hasHls ? video.hlsUrl : video.videoUrl;

    var success = await _tryInitController(index, playUrl, gen);

    // HLS 실패 시 MP4 fallback
    if (!success && gen == _generation && hasHls && hasMp4) {
      success = await _tryInitController(index, video.videoUrl, gen);
    }

    // 모두 실패 시 2초 후 1회 재시도
    if (!success &&
        gen == _generation &&
        !_isDisposed &&
        !_disposed.contains(index)) {
      await Future<void>.delayed(const Duration(seconds: 2));
      if (gen == _generation && !_isDisposed && !_disposed.contains(index)) {
        success = await _tryInitController(index, playUrl, gen);
      }
    }

    _initializing.remove(index);
    if (!_isDisposed && gen == _generation) {
      state = Map.unmodifiable(_controllers);
    }
  }

  /// 주어진 URL로 컨트롤러 초기화 시도. 성공 시 true 반환.
  Future<bool> _tryInitController(int index, String url, int gen) async {
    // 세대가 바뀌었으면 즉시 중단
    if (gen != _generation) return false;

    final controller = VideoPlayerController.networkUrl(Uri.parse(url));
    _controllers[index] = controller;

    try {
      await controller.initialize().timeout(_initTimeout);

      // 초기화 중에 dispose되었거나 세대가 바뀌었는지 확인
      if (_isDisposed || _disposed.contains(index) || gen != _generation) {
        controller.dispose();
        _controllers.remove(index);
        return false;
      }

      controller.setLooping(true);

      // 초기화 완료 후 현재 페이지면 자동 재생
      final currentIndex = ref
          .read(feedNotifierProvider)
          .valueOrNull
          ?.currentIndex;
      if (currentIndex == index && !_isDisposed) {
        controller.play();
      }
      return true;
    } catch (e) {
      debugPrint(
        'VideoPlayerManager: controller init failed for index $index ($url): $e',
      );
      if (_controllers[index] == controller) {
        _controllers.remove(index);
      }
      try {
        controller.dispose();
      } catch (_) {
        // dispose 실패는 무시 (이미 dispose된 경우)
      }
      return false;
    }
  }

  /// 첫 로드 시 호출 (FeedPage에서 최초 1회)
  void initializeForIndex(int index, List<Video> videos) {
    if (_controllers.isNotEmpty) return;
    _onPageChanged(index, videos);
  }

  /// 영상 삭제 후 강제 재초기화 (PageController 재생성 완료 후 호출)
  void forceReinitialize(int index, List<Video> videos) {
    if (videos.isEmpty || _isDisposed) return;
    _onPageChanged(index, videos);
  }

  /// 탭하여 일시정지/재생 토글
  void togglePlayPause(int index) {
    final controller = _controllers[index];
    if (controller == null || !controller.value.isInitialized) return;

    if (controller.value.isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }
    state = Map.unmodifiable(_controllers);
  }

  /// 특정 인덱스의 컨트롤러 가져오기
  VideoPlayerController? getController(int index) {
    return _controllers[index];
  }

  void _disposeAll() {
    _generation++;
    for (final controller in _controllers.values) {
      try {
        controller.dispose();
      } catch (_) {
        // dispose 실패 무시
      }
    }
    _controllers.clear();
    _initializing.clear();
    _disposed.clear();
  }
}
