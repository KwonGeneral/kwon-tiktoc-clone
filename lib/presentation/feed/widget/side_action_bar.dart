import 'package:flutter/material.dart';

import 'package:supersent_tiktoc_clone/app/theme/app_colors.dart';
import 'package:supersent_tiktoc_clone/app/theme/app_text_styles.dart';
import 'package:supersent_tiktoc_clone/core/utils/format_utils.dart';
import 'package:supersent_tiktoc_clone/domain/entity/video.dart';

class SideActionBar extends StatelessWidget {
  const SideActionBar({required this.video, super.key});

  final Video video;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 프로필 아바타 + 팔로우 뱃지
          _ProfileAvatar(userId: video.userId),
          const SizedBox(height: 20),

          // 좋아요
          _ActionItem(
            icon: Icons.favorite,
            count: video.likeCount,
            color: video.isLiked ? AppColors.like : AppColors.white,
          ),
          const SizedBox(height: 16),

          // 댓글
          _ActionItem(
            icon: Icons.chat_bubble,
            count: video.commentCount,
          ),
          const SizedBox(height: 16),

          // 북마크
          _ActionItem(
            icon: Icons.bookmark,
            count: video.bookmarkCount,
            color: video.isBookmarked ? AppColors.bookmark : AppColors.white,
          ),
          const SizedBox(height: 16),

          // 공유
          _ActionItem(
            icon: Icons.reply,
            count: video.shareCount,
            isMirrored: true,
          ),
        ],
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.white, width: 2),
            color: AppColors.gray,
          ),
          child: const Icon(Icons.person, color: AppColors.white, size: 24),
        ),
        // 팔로우 + 뱃지
        Positioned(
          bottom: -8,
          child: Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary,
            ),
            child: const Icon(Icons.add, color: AppColors.white, size: 14),
          ),
        ),
      ],
    );
  }
}

class _ActionItem extends StatelessWidget {
  const _ActionItem({
    required this.icon,
    required this.count,
    this.color = AppColors.white,
    this.isMirrored = false,
  });

  final IconData icon;
  final int count;
  final Color color;
  final bool isMirrored;

  @override
  Widget build(BuildContext context) {
    final iconWidget = Icon(icon, color: color, size: 32);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isMirrored)
          Transform.flip(flipX: true, child: iconWidget)
        else
          iconWidget,
        const SizedBox(height: 2),
        Text(
          FormatUtils.compactNumber(count),
          style: AppTextStyles.count,
        ),
      ],
    );
  }
}
