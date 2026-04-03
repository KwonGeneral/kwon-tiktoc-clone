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

  static const _initTimeout = Duration(seconds: 10);

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

      // 탭 전환 시 모든 컨트롤러 dispose 후 재초기화
      if (prevTab != null && prevTab != nextTab) {
        _disposeAll();
        _onPageChanged(nextIndex, nextState.displayVideos);
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

    // 3. 범위 내 컨트롤러 초기화 (없으면 생성)
    for (final index in keepRange) {
      if (!_controllers.containsKey(index) && !_initializing.contains(index)) {
        _disposed.remove(index);
        _initController(index, videos[index]);
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

  /// 컨트롤러 초기화 (타임아웃 + 레이스 컨디션 보호 + HLS→MP4 fallback)
  Future<void> _initController(int index, Video video) async {
    _initializing.add(index);
    // HLS URL 우선 사용, 없으면 MP4 fallback
    final useHls = video.hlsUrl.isNotEmpty;
    final playUrl = useHls ? video.hlsUrl : video.videoUrl;

    final success = await _tryInitController(index, playUrl);

    // HLS 초기화 실패 시 MP4 URL로 재시도
    if (!success && useHls && video.videoUrl.isNotEmpty) {
      debugPrint(
        'VideoPlayerManager: HLS failed for index $index, falling back to MP4',
      );
      await _tryInitController(index, video.videoUrl);
    }

    _initializing.remove(index);
    if (!_isDisposed) {
      state = Map.unmodifiable(_controllers);
    }
  }

  /// 주어진 URL로 컨트롤러 초기화 시도. 성공 시 true 반환.
  Future<bool> _tryInitController(int index, String url) async {
    final controller = VideoPlayerController.networkUrl(Uri.parse(url));
    _controllers[index] = controller;

    try {
      await controller.initialize().timeout(_initTimeout);

      // 초기화 중에 dispose되었는지 확인
      if (_isDisposed || _disposed.contains(index)) {
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
