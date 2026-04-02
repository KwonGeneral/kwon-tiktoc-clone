import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:kwon_tiktoc_clone/domain/entity/comment.dart';

part 'comment_model.freezed.dart';
part 'comment_model.g.dart';

@freezed
sealed class CommentModel with _$CommentModel {
  const factory CommentModel({
    required String id,
    required String videoId,
    required String userId,
    @Default('') String userName,
    @Default('') String userAvatarUrl,
    required String text,
    @Default(0) int likeCount,
    required DateTime createdAt,
  }) = _CommentModel;

  const CommentModel._();

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  factory CommentModel.fromEntity(Comment entity) => CommentModel(
        id: entity.id,
        videoId: entity.videoId,
        userId: entity.userId,
        userName: entity.userName,
        userAvatarUrl: entity.userAvatarUrl,
        text: entity.text,
        likeCount: entity.likeCount,
        createdAt: entity.createdAt,
      );

  Comment toEntity() => Comment(
        id: id,
        videoId: videoId,
        userId: userId,
        userName: userName,
        userAvatarUrl: userAvatarUrl,
        text: text,
        likeCount: likeCount,
        createdAt: createdAt,
      );
}
