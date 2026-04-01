import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:supersent_tiktoc_clone/app/theme/app_colors.dart';
import 'package:supersent_tiktoc_clone/presentation/feed/provider/feed_provider.dart';
import 'package:supersent_tiktoc_clone/presentation/feed/provider/video_player_manager.dart';
import 'package:supersent_tiktoc_clone/presentation/feed/widget/video_card.dart';

class FeedPage extends ConsumerStatefulWidget {
  const FeedPage({super.key});

  @override
  ConsumerState<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends ConsumerState<FeedPage> {
  bool _initialized = false;

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
                '영상이 없습니다',
                style: TextStyle(color: AppColors.white),
              ),
            );
          }

          // 최초 1회 Manager 초기화
          if (!_initialized) {
            _initialized = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ref
                  .read(videoPlayerManagerProvider.notifier)
                  .initializeForIndex(0, feedState.videos);
            });
          }

          return PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: feedState.videos.length,
            onPageChanged: (index) {
              ref.read(feedNotifierProvider.notifier).updateCurrentIndex(index);
            },
            itemBuilder: (context, index) {
              return VideoCard(
                video: feedState.videos[index],
                index: index,
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(
            color: AppColors.white,
            strokeWidth: 2,
          ),
        ),
        error: (_, _) => const Center(
          child: Text(
            '영상을 불러올 수 없습니다',
            style: TextStyle(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
