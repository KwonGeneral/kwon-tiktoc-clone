import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kwon_tiktoc_clone/app/theme/app_colors.dart';
import 'package:kwon_tiktoc_clone/core/constants/app_strings.dart';
import 'package:kwon_tiktoc_clone/core/utils/format_utils.dart';
import 'package:kwon_tiktoc_clone/presentation/feed/provider/comment_provider.dart';
import 'package:kwon_tiktoc_clone/presentation/feed/widget/comment_item.dart';

class CommentBottomSheet extends ConsumerStatefulWidget {
  const CommentBottomSheet({required this.videoId, super.key});

  final String videoId;

  static Future<void> show(BuildContext context, String videoId) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CommentBottomSheet(videoId: videoId),
    );
  }

  @override
  ConsumerState<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends ConsumerState<CommentBottomSheet> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(commentNotifierProvider.notifier).loadComments(widget.videoId);
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final commentState = ref.watch(commentNotifierProvider);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      decoration: const BoxDecoration(
        color: AppColors.darkGray,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Column(
        children: [
          // 헤더
          _buildHeader(commentState.comments.length),

          const Divider(color: AppColors.divider, height: 1),

          // 댓글 목록
          Expanded(
            child: commentState.isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: AppColors.white),
                  )
                : commentState.comments.isEmpty
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
                    itemCount: commentState.comments.length,
                    itemBuilder: (context, index) {
                      final comment = commentState.comments[index];
                      return CommentItem(
                        comment: comment,
                        isLiked: commentState.likedCommentIds.contains(
                          comment.id,
                        ),
                        isDisliked: commentState.dislikedCommentIds.contains(
                          comment.id,
                        ),
                        onLikeTap: () {
                          ref
                              .read(commentNotifierProvider.notifier)
                              .toggleCommentLike(comment.id);
                        },
                        onDislikeTap: () {
                          ref
                              .read(commentNotifierProvider.notifier)
                              .toggleCommentDislike(comment.id);
                        },
                      );
                    },
                  ),
          ),

          const Divider(color: AppColors.divider, height: 1),

          // 입력 필드
          Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 8,
              top: 8,
              bottom: 8 + bottomInset,
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
                      hintText: AppStrings.commentInputHint,
                      hintStyle: const TextStyle(
                        color: AppColors.whiteDisabled,
                        fontSize: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: AppColors.gray,
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
            onTap: () => Navigator.of(context).pop(),
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
