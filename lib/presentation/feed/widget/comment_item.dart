import 'package:flutter/material.dart';

import 'package:kwon_tiktoc_clone/app/theme/app_colors.dart';
import 'package:kwon_tiktoc_clone/core/constants/app_strings.dart';
import 'package:kwon_tiktoc_clone/core/utils/format_utils.dart';
import 'package:kwon_tiktoc_clone/domain/entity/comment.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({
    required this.comment,
    required this.isLiked,
    required this.isDisliked,
    required this.onLikeTap,
    required this.onDislikeTap,
    required this.onReplyTap,
    this.replies = const [],
    this.isExpanded = false,
    this.onToggleReplies,
    this.likedCommentIds = const {},
    this.dislikedCommentIds = const {},
    this.onReplyLikeTap,
    this.onReplyDislikeTap,
    this.onReplyReplyTap,
    this.isReply = false,
    super.key,
  });

  final Comment comment;
  final bool isLiked;
  final bool isDisliked;
  final VoidCallback onLikeTap;
  final VoidCallback onDislikeTap;
  final VoidCallback onReplyTap;
  final List<Comment> replies;
  final bool isExpanded;
  final VoidCallback? onToggleReplies;
  final Set<String> likedCommentIds;
  final Set<String> dislikedCommentIds;
  final void Function(String commentId)? onReplyLikeTap;
  final void Function(String commentId)? onReplyDislikeTap;
  final void Function(String commentId, String userName)? onReplyReplyTap;
  final bool isReply;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCommentRow(),
        // 답글 더보기/숨기기 + 답글 목록 (최상위 댓글만)
        if (!isReply && (comment.replyCount > 0 || replies.isNotEmpty))
          _buildRepliesSection(),
      ],
    );
  }

  Widget _buildCommentRow() {
    return Padding(
      padding: EdgeInsets.only(
        left: isReply ? 44 : 16,
        right: 16,
        top: isReply ? 6 : 10,
        bottom: isReply ? 6 : 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 아바타
          CircleAvatar(
            radius: isReply ? 12 : 16,
            backgroundColor: AppColors.gray,
            backgroundImage: comment.userAvatarUrl.isNotEmpty
                ? NetworkImage(comment.userAvatarUrl)
                : null,
            child: comment.userAvatarUrl.isEmpty
                ? Icon(
                    Icons.person,
                    color: AppColors.white,
                    size: isReply ? 14 : 18,
                  )
                : null,
          ),
          const SizedBox(width: 12),

          // 이름 + 내용 + 시간 + 답글
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
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      FormatUtils.timeAgo(comment.createdAt),
                      style: const TextStyle(
                        color: AppColors.whiteSecondary,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: onReplyTap,
                      child: const Text(
                        AppStrings.commentReply,
                        style: TextStyle(
                          color: AppColors.whiteSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
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
              GestureDetector(
                onTap: onLikeTap,
                child: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  size: 18,
                  color: isLiked
                      ? AppColors.like
                      : AppColors.whiteSecondary,
                ),
              ),
              if (_likeCountText().isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    _likeCountText(),
                    style: const TextStyle(
                      color: AppColors.whiteSecondary,
                      fontSize: 11,
                    ),
                  ),
                ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: onDislikeTap,
                child: Icon(
                  isDisliked
                      ? Icons.thumb_down_alt
                      : Icons.thumb_down_alt_outlined,
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

  Widget _buildRepliesSection() {
    final totalReplies = replies.length > comment.replyCount
        ? replies.length
        : comment.replyCount;

    return Padding(
      padding: const EdgeInsets.only(left: 44),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 답글 더보기/숨기기 토글
          GestureDetector(
            onTap: onToggleReplies,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 24,
                    height: 1,
                    color: AppColors.whiteSecondary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isExpanded
                        ? AppStrings.commentHideReplies
                        : AppStrings.commentShowReplies
                            .replaceAll('{count}', totalReplies.toString()),
                    style: const TextStyle(
                      color: AppColors.whiteSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 답글 목록
          if (isExpanded)
            ...replies.map(
              (reply) => CommentItem(
                comment: reply,
                isLiked: likedCommentIds.contains(reply.id),
                isDisliked: dislikedCommentIds.contains(reply.id),
                onLikeTap: () => onReplyLikeTap?.call(reply.id),
                onDislikeTap: () => onReplyDislikeTap?.call(reply.id),
                onReplyTap: () =>
                    onReplyReplyTap?.call(comment.id, reply.userName),
                isReply: true,
              ),
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
}
