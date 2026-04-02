import 'package:flutter/material.dart';

import 'package:kwon_tiktoc_clone/app/theme/app_colors.dart';
import 'package:kwon_tiktoc_clone/app/theme/app_text_styles.dart';
import 'package:kwon_tiktoc_clone/core/utils/format_utils.dart';
import 'package:kwon_tiktoc_clone/domain/entity/video.dart';

class SideActionBar extends StatelessWidget {
  const SideActionBar({
    required this.video,
    this.isFollowing = false,
    this.onLikeTap,
    this.onBookmarkTap,
    this.onFollowTap,
    super.key,
  });

  final Video video;
  final bool isFollowing;
  final VoidCallback? onLikeTap;
  final VoidCallback? onBookmarkTap;
  final VoidCallback? onFollowTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 프로필 아바타 + 팔로우 뱃지
          _ProfileAvatar(
            userId: video.userId,
            isFollowing: isFollowing,
            onTap: onFollowTap,
          ),
          const SizedBox(height: 20),

          // 좋아요
          _ActionItem(
            icon: Icons.favorite,
            count: video.likeCount,
            color: video.isLiked ? AppColors.like : AppColors.white,
            onTap: onLikeTap,
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
            onTap: onBookmarkTap,
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
  const _ProfileAvatar({
    required this.userId,
    this.isFollowing = false,
    this.onTap,
  });

  final String userId;
  final bool isFollowing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isFollowing ? AppColors.primary : AppColors.white,
                width: 2,
              ),
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
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isFollowing ? AppColors.gray : AppColors.primary,
              ),
              child: Icon(
                isFollowing ? Icons.check : Icons.add,
                color: AppColors.white,
                size: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  const _ActionItem({
    required this.icon,
    required this.count,
    this.color = AppColors.white,
    this.isMirrored = false,
    this.onTap,
  });

  final IconData icon;
  final int count;
  final Color color;
  final bool isMirrored;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final iconWidget = Icon(icon, color: color, size: 32);

    return GestureDetector(
      onTap: onTap,
      child: Column(
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
      ),
    );
  }
}
