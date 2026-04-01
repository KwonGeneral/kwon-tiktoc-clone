import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:supersent_tiktoc_clone/app/theme/app_colors.dart';
import 'package:supersent_tiktoc_clone/presentation/feed/provider/feed_provider.dart';
import 'package:supersent_tiktoc_clone/presentation/feed/widget/video_card.dart';

class FeedPage extends ConsumerWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

          return PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: feedState.videos.length,
            onPageChanged: (index) {
              ref.read(feedNotifierProvider.notifier).updateCurrentIndex(index);
            },
            itemBuilder: (context, index) {
              return VideoCard(video: feedState.videos[index]);
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(
            color: AppColors.white,
            strokeWidth: 2,
          ),
        ),
        error: (error, _) => Center(
          child: Text(
            '오류가 발생했습니다: $error',
            style: const TextStyle(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
