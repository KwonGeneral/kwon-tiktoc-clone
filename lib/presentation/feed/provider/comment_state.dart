import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:kwon_tiktoc_clone/domain/entity/comment.dart';

part 'comment_state.freezed.dart';

@freezed
sealed class CommentState with _$CommentState {
  const factory CommentState({
    @Default('') String videoId,
    @Default([]) List<Comment> comments,
    @Default({}) Set<String> likedCommentIds,
    @Default({}) Set<String> dislikedCommentIds,
    @Default(false) bool isLoading,

    /// 답글이 펼쳐진 댓글 ID 목록
    @Default({}) Set<String> expandedReplyIds,

    /// 답글 입력 대상 댓글 ID (null이면 일반 댓글 입력)
    String? replyingToCommentId,

    /// 답글 입력 대상 유저 이름
    String? replyingToUserName,
  }) = _CommentState;
}
