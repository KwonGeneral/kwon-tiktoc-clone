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
  }) = _CommentState;
}
