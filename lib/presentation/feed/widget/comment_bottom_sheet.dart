import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kwon_tiktoc_clone/app/theme/app_colors.dart';
import 'package:kwon_tiktoc_clone/core/constants/app_strings.dart';
import 'package:kwon_tiktoc_clone/core/utils/format_utils.dart';
import 'package:kwon_tiktoc_clone/presentation/feed/provider/comment_provider.dart';
import 'package:kwon_tiktoc_clone/presentation/feed/widget/comment_item.dart';

/// 댓글창 열기 (provider 기반 - 영상 축소 + 인라인 댓글)
Future<void> openCommentView(WidgetRef ref, String videoId) async {
  await ref.read(commentNotifierProvider.notifier).open(videoId);
}

/// 인라인 댓글 뷰 (영상 카드 내에서 사용)
class CommentInlineView extends ConsumerStatefulWidget {
  const CommentInlineView({required this.videoId, super.key});

  final String videoId;

  @override
  ConsumerState<CommentInlineView> createState() => _CommentInlineViewState();
}

class _CommentInlineViewState extends ConsumerState<CommentInlineView> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final commentState = ref.watch(commentNotifierProvider);

    final topLevelComments = commentState.comments
        .where((c) => c.parentCommentId == null)
        .toList();

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.commentBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Column(
        children: [
          // 헤더
          _buildHeader(topLevelComments.length),
          const Divider(color: AppColors.divider, height: 1),

          // 댓글 목록
          Expanded(
            child: commentState.isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: AppColors.white),
                  )
                : topLevelComments.isEmpty
                ? const Center(
                    child: Text(
                      AppStrings.commentEmpty,
                      style: TextStyle(
                        color: AppColors.whiteSecondary,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 8),
                    itemCount: topLevelComments.length,
                    itemBuilder: (context, index) {
                      final comment = topLevelComments[index];
                      final notifier = ref.read(
                        commentNotifierProvider.notifier,
                      );
                      final replies = notifier.getReplies(comment.id);

                      return CommentItem(
                        comment: comment,
                        isLiked: commentState.likedCommentIds.contains(
                          comment.id,
                        ),
                        isDisliked: commentState.dislikedCommentIds.contains(
                          comment.id,
                        ),
                        onLikeTap: () => notifier.toggleCommentLike(comment.id),
                        onDislikeTap: () =>
                            notifier.toggleCommentDislike(comment.id),
                        onReplyTap: () {
                          notifier.startReply(comment.id, comment.userName);
                          _focusNode.requestFocus();
                        },
                        replies: replies,
                        isExpanded: commentState.expandedReplyIds.contains(
                          comment.id,
                        ),
                        onToggleReplies: () =>
                            notifier.toggleReplies(comment.id),
                        likedCommentIds: commentState.likedCommentIds,
                        dislikedCommentIds: commentState.dislikedCommentIds,
                        onReplyLikeTap: notifier.toggleCommentLike,
                        onReplyDislikeTap: notifier.toggleCommentDislike,
                        onReplyReplyTap: (parentId, userName) {
                          notifier.startReply(parentId, userName);
                          _focusNode.requestFocus();
                        },
                      );
                    },
                  ),
          ),

          const Divider(color: AppColors.divider, height: 1),

          // 답글 모드 표시
          if (commentState.replyingToCommentId != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              color: AppColors.commentInputBackground,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      AppStrings.commentReplyingTo.replaceAll(
                        '{name}',
                        commentState.replyingToUserName ?? '',
                      ),
                      style: const TextStyle(
                        color: AppColors.whiteSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => ref
                        .read(commentNotifierProvider.notifier)
                        .cancelReply(),
                    child: const Icon(
                      Icons.close,
                      color: AppColors.whiteSecondary,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),

          // 입력 필드
          Container(
            color: AppColors.commentBackground,
            padding: const EdgeInsets.only(
              left: 16,
              right: 8,
              top: 8,
              bottom: 8,
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 14,
                  backgroundColor: AppColors.gray,
                  child: Icon(Icons.person, color: AppColors.white, size: 16),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _textController,
                    focusNode: _focusNode,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      hintText: commentState.replyingToCommentId != null
                          ? AppStrings.commentReply
                          : AppStrings.commentInputHint,
                      hintStyle: const TextStyle(
                        color: AppColors.whiteDisabled,
                        fontSize: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: AppColors.commentInputBackground,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.alternate_email,
                              color: AppColors.whiteSecondary,
                              size: 20,
                            ),
                            onPressed: () {},
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minWidth: 32,
                              minHeight: 32,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.emoji_emotions_outlined,
                              color: AppColors.whiteSecondary,
                              size: 20,
                            ),
                            onPressed: () {},
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minWidth: 32,
                              minHeight: 32,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onSubmitted: _submitComment,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: AppColors.primary,
                    size: 22,
                  ),
                  onPressed: () => _submitComment(_textController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(int count) {
    final titleText = count > 0
        ? AppStrings.commentTitleWithCount.replaceAll(
            '{count}',
            FormatUtils.compactNumber(count),
          )
        : AppStrings.commentTitle;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(
                titleText,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => ref.read(commentNotifierProvider.notifier).close(),
            child: const Icon(Icons.close, color: AppColors.white, size: 22),
          ),
        ],
      ),
    );
  }

  void _submitComment(String text) {
    if (text.trim().isEmpty) return;

    ref.read(commentNotifierProvider.notifier).addComment(text);
    _textController.clear();
    _focusNode.unfocus();
  }
}
