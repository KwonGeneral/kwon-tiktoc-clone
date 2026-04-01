import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';

@freezed
sealed class Comment with _$Comment {
  const factory Comment({
    required String id,
    required String videoId,
    required String userId,
    @Default('') String userName,
    @Default('') String userAvatarUrl,
    required String text,
    @Default(0) int likeCount,
    required DateTime createdAt,
  }) = _Comment;
}
