import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../domain/entity/video.dart';

class ProfileVideoGrid extends StatelessWidget {
  const ProfileVideoGrid({required this.videos, super.key});

  final List<Video> videos;

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
        return _VideoThumbnail(video: video);
      },
    );
  }
}

class _VideoThumbnail extends StatelessWidget {
  const _VideoThumbnail({required this.video});

  final Video video;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // 썸네일 또는 플레이스홀더
        video.thumbnailUrl.isNotEmpty
            ? Image.network(
                video.thumbnailUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => _buildPlaceholder(),
              )
            : _buildPlaceholder(),
        // 하단 조회수/좋아요 표시
        Positioned(
          left: 4,
          bottom: 4,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.play_arrow, color: AppColors.white, size: 14),
              const SizedBox(width: 2),
              Text(
                _formatCount(video.likeCount),
                style: AppTextStyles.profileLabel.copyWith(
                  color: AppColors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppColors.gray,
      child: const Center(
        child: Icon(
          Icons.videocam_outlined,
          color: AppColors.whiteSecondary,
          size: 28,
        ),
      ),
    );
  }

  String _formatCount(int count) {
    if (count >= 10000) {
      return '${(count / 10000).toStringAsFixed(1)}만';
    }
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}천';
    }
    return '$count';
  }
}
