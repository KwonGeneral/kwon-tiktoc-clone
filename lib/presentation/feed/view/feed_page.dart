import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kwon_tiktoc_clone/app/theme/app_colors.dart';
import 'package:kwon_tiktoc_clone/app/theme/app_font_sizes.dart';
import 'package:kwon_tiktoc_clone/core/constants/app_strings.dart';
import 'package:kwon_tiktoc_clone/core/di/providers.dart';
import 'package:kwon_tiktoc_clone/presentation/feed/provider/comment_provider.dart';
import 'package:kwon_tiktoc_clone/presentation/feed/provider/feed_provider.dart';
import 'package:kwon_tiktoc_clone/presentation/feed/provider/video_player_manager.dart';
import 'package:kwon_tiktoc_clone/presentation/feed/widget/top_tab_bar.dart';
import 'package:kwon_tiktoc_clone/presentation/feed/widget/video_card.dart';

class FeedPage extends ConsumerStatefulWidget {
  const FeedPage({super.key});

  @override
  ConsumerState<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends ConsumerState<FeedPage> {
  bool _initialized = false;
  PageController? _pageController;
  int _pageViewGeneration = 0; // PageView 강제 재생성용

  /// 무한 루프를 위한 큰 가상 페이지 수
  static const _virtualPageCount = 100000;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tryInitialize();
    });
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  void _tryInitialize() {
    if (_initialized) return;
    final feedState = ref.read(feedNotifierProvider).valueOrNull;
    if (feedState != null && feedState.videos.isNotEmpty) {
      _initialized = true;
      final startIndex = feedState.currentIndex;
      ref
          .read(videoPlayerManagerProvider.notifier)
          .initializeForIndex(startIndex, feedState.videos);
    }
  }

  int _midStartForCount(int videoCount) {
    if (videoCount <= 0) return 0;
    return (_virtualPageCount ~/ 2) - ((_virtualPageCount ~/ 2) % videoCount);
  }

  PageController _getPageController(int videoCount, {int initialIndex = 0}) {
    if (_pageController == null) {
      final midStart = _midStartForCount(videoCount) + initialIndex;
      _pageController = PageController(initialPage: midStart);
    }
    return _pageController!;
  }

  void _jumpToIndex(int realIndex, int videoCount) {
    if (_pageController == null || !_pageController!.hasClients) return;
    if (videoCount <= 0) return;
    final midStart = _midStartForCount(videoCount);
    _pageController!.jumpToPage(midStart + realIndex);
  }

  void _onPageChanged(int loopIndex, int totalVideos) {
    final realIndex = loopIndex % totalVideos;
    ref.read(feedNotifierProvider.notifier).updateCurrentIndex(realIndex);
    // 페이지 스크롤 시 댓글창 자동 닫기
    final commentState = ref.read(commentNotifierProvider);
    if (commentState.isOpen) {
      ref.read(commentNotifierProvider.notifier).close();
    }
  }

  @override
  Widget build(BuildContext context) {
    // 외부에서 currentIndex 또는 영상 목록이 변경되면 PageController 갱신
    ref.listen(feedNotifierProvider, (prev, next) {
      final prevState = prev?.valueOrNull;
      final nextState = next.valueOrNull;
      if (prevState == null || nextState == null) return;

      final prevCount = prevState.videos.length;
      final nextCount = nextState.videos.length;
      final nextIndex = nextState.currentIndex;

      // 영상 삭제 등으로 목록 크기가 변경된 경우 PageController 재생성
      if (prevCount != nextCount && nextCount > 0) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          _pageController?.dispose();
          _pageController = null;
          _pageViewGeneration++;
          setState(() {});
          // PageController 재생성 후 VideoPlayerManager 초기화
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            final currentState = ref.read(feedNotifierProvider).valueOrNull;
            if (currentState != null && currentState.videos.isNotEmpty) {
              ref
                  .read(videoPlayerManagerProvider.notifier)
                  .forceReinitialize(
                    currentState.currentIndex,
                    currentState.videos,
                  );
            }
          });
        });
        return;
      }

      final prevIndex = prevState.currentIndex;
      if (prevIndex != nextIndex && nextCount > 0) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _jumpToIndex(nextIndex, nextCount);
        });
      }
    });

    final feedAsync = ref.watch(feedNotifierProvider);

    return Scaffold(
      backgroundColor: AppColors.black,
      body: feedAsync.when(
        data: (feedState) {
          if (feedState.videos.isEmpty) {
            return const Center(
              child: Text(
                AppStrings.feedEmpty,
                style: TextStyle(color: AppColors.white),
              ),
            );
          }

          // 데이터 도착 후 초기화 (initState 시점에 아직 로딩 중이었을 경우)
          if (!_initialized) {
            _initialized = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ref
                  .read(videoPlayerManagerProvider.notifier)
                  .initializeForIndex(feedState.currentIndex, feedState.videos);
            });
          }

          final displayVideos = feedState.videos;

          return Stack(
            children: [
              PageView.builder(
                key: ValueKey(_pageViewGeneration),
                controller: _getPageController(
                  displayVideos.length,
                  initialIndex: feedState.currentIndex,
                ),
                scrollDirection: Axis.vertical,
                itemCount: _virtualPageCount,
                onPageChanged: (index) =>
                    _onPageChanged(index, displayVideos.length),
                itemBuilder: (context, index) {
                  final realIndex = index % displayVideos.length;
                  return VideoCard(
                    video: displayVideos[realIndex],
                    index: realIndex,
                  );
                },
              ),

              // 상단 탭바 (팔로잉 | 추천) — 고정
              const Positioned(top: 0, left: 0, right: 0, child: TopTabBar()),

              // 추가 로딩 인디케이터
              if (feedState.isLoadingMore)
                const Positioned(
                  bottom: 16,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: AppColors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                ),

              // 로드 에러 표시
              if (feedState.loadMoreError != null)
                Positioned(
                  bottom: 16,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        ref.read(feedNotifierProvider.notifier).loadMore();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.black.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          AppStrings.feedLoadMoreError,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: AppFontSizes.body,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
        loading: () {
          // 저장된 썸네일로 즉시 표시 (검정 → 썸네일 → 영상)
          final savedThumbnail = ref
              .read(localStorageRepositoryProvider)
              .getLastVideoThumbnailUrl();
          return Stack(
            fit: StackFit.expand,
            children: [
              if (savedThumbnail.isNotEmpty)
                Image.network(
                  savedThumbnail,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const SizedBox.shrink(),
                ),
              const Center(
                child: CircularProgressIndicator(
                  color: AppColors.white,
                  strokeWidth: 2,
                ),
              ),
            ],
          );
        },
        error: (_, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                AppStrings.feedError,
                style: TextStyle(color: AppColors.white),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  ref.invalidate(feedNotifierProvider);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.whiteSecondary),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    AppStrings.feedRetry,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: AppFontSizes.bodyMd,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
