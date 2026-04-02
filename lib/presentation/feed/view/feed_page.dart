import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kwon_tiktoc_clone/app/theme/app_colors.dart';
import 'package:kwon_tiktoc_clone/core/constants/app_strings.dart';
import 'package:kwon_tiktoc_clone/presentation/feed/provider/feed_provider.dart';
import 'package:kwon_tiktoc_clone/presentation/feed/provider/video_player_manager.dart';
import 'package:kwon_tiktoc_clone/presentation/feed/widget/video_card.dart';

class FeedPage extends ConsumerStatefulWidget {
  const FeedPage({super.key});

  @override
  ConsumerState<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends ConsumerState<FeedPage> {
  bool _initialized = false;

  /// 무한 스크롤 트리거: 끝에서 이 값만큼 남았을 때 loadMore 호출
  static const _loadMoreThreshold = 3;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tryInitialize();
    });
  }

  void _tryInitialize() {
    if (_initialized) return;
    final feedState = ref.read(feedNotifierProvider).valueOrNull;
    if (feedState != null && feedState.videos.isNotEmpty) {
      _initialized = true;
      ref
          .read(videoPlayerManagerProvider.notifier)
          .initializeForIndex(0, feedState.videos);
    }
  }

  void _onPageChanged(int index, int totalVideos) {
    ref.read(feedNotifierProvider.notifier).updateCurrentIndex(index);

    // 끝에서 threshold 이내면 다음 페이지 로드
    if (index >= totalVideos - _loadMoreThreshold) {
      ref.read(feedNotifierProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  .initializeForIndex(0, feedState.videos);
            });
          }

          return Stack(
            children: [
              PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: feedState.videos.length,
                onPageChanged: (index) =>
                    _onPageChanged(index, feedState.videos.length),
                itemBuilder: (context, index) {
                  return VideoCard(
                    video: feedState.videos[index],
                    index: index,
                  );
                },
              ),

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
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(
            color: AppColors.white,
            strokeWidth: 2,
          ),
        ),
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
                    style: TextStyle(color: AppColors.white, fontSize: 14),
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
