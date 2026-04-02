import 'package:flutter/material.dart';

import 'package:kwon_tiktoc_clone/app/theme/app_colors.dart';
import 'package:kwon_tiktoc_clone/core/constants/app_strings.dart';
import 'package:kwon_tiktoc_clone/domain/entity/comment.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({
    required this.comment,
    required this.isLiked,
    required this.isDisliked,
    required this.onLikeTap,
    required this.onDislikeTap,
    super.key,
  });

  final Comment comment;
  final bool isLiked;
  final bool isDisliked;
  final VoidCallback onLikeTap;
  final VoidCallback onDislikeTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 아바타
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.gray,
            backgroundImage: comment.userAvatarUrl.isNotEmpty
                ? NetworkImage(comment.userAvatarUrl)
                : null,
            child: comment.userAvatarUrl.isEmpty
                ? const Icon(Icons.person, color: AppColors.white, size: 18)
                : null,
          ),
          const SizedBox(width: 12),

          // 이름 + 내용 + 시간
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.userName,
                  style: const TextStyle(
                    color: AppColors.whiteSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  comment.text,
                  style: const TextStyle(color: AppColors.white, fontSize: 14),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      _formatTimeAgo(comment.createdAt),
                      style: const TextStyle(
                        color: AppColors.whiteSecondary,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      AppStrings.commentReply,
                      style: TextStyle(
                        color: AppColors.whiteSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 좋아요 / 싫어요
          Column(
            children: [
              // 좋아요
              GestureDetector(
                onTap: onLikeTap,
                child: Column(
                  children: [
                    Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      size: 18,
                      color: isLiked
                          ? AppColors.like
                          : AppColors.whiteSecondary,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _likeCountText(),
                      style: const TextStyle(
                        color: AppColors.whiteSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // 싫어요
              GestureDetector(
                onTap: onDislikeTap,
                child: Icon(
                  isDisliked ? Icons.heart_broken : Icons.heart_broken_outlined,
                  size: 18,
                  color: isDisliked
                      ? AppColors.whiteSecondary
                      : AppColors.whiteDisabled,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _likeCountText() {
    var count = comment.likeCount;
    if (isLiked) count += 1;
    if (count == 0) return '';
    return count.toString();
  }

  static String _formatTimeAgo(DateTime dateTime) {
    final diff = DateTime.now().difference(dateTime);

    if (diff.inMinutes < 1) {
      return AppStrings.commentJustNow;
    }
    if (diff.inHours < 1) {
      return AppStrings.commentMinutesAgo.replaceAll(
        '{m}',
        diff.inMinutes.toString(),
      );
    }
    if (diff.inDays < 1) {
      return AppStrings.commentHoursAgo.replaceAll(
        '{h}',
        diff.inHours.toString(),
      );
    }
    return AppStrings.commentDaysAgo.replaceAll('{d}', diff.inDays.toString());
  }
}
