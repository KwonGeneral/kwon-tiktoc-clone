import 'package:flutter/material.dart';

import 'package:kwon_tiktoc_clone/app/theme/app_colors.dart';
import 'package:kwon_tiktoc_clone/app/theme/app_text_styles.dart';
import 'package:kwon_tiktoc_clone/core/utils/format_utils.dart';
import 'package:kwon_tiktoc_clone/domain/entity/video.dart';

class UserVideoGrid extends StatelessWidget {
  const UserVideoGrid({required this.videos, this.onVideoTap, super.key});

  final List<Video> videos;
  final void Function(Video video)? onVideoTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(1),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 9 / 16,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final video = videos[index];
        return GestureDetector(
          onTap: () => onVideoTap?.call(video),
          child: _VideoThumbnail(video: video),
        );
      },
    );
  }
}

class _VideoThumbnail extends StatelessWidget {
  const _VideoThumbnail({required this.video});

  final Video video;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.gray,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 썸네일 또는 플레이스홀더
          if (video.thumbnailUrl.isNotEmpty)
            Image.network(
              video.thumbnailUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => _buildPlaceholder(),
            )
          else
            _buildPlaceholder(),
          // 하단 좋아요 수
          Positioned(
            left: 4,
            bottom: 4,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.play_arrow, color: AppColors.white, size: 16),
                const SizedBox(width: 2),
                Text(
                  FormatUtils.compactNumber(video.likeCount),
                  style: AppTextStyles.count.copyWith(fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder() {
    return const Center(
      child: Icon(Icons.videocam, color: AppColors.whiteSecondary, size: 32),
    );
  }
}
