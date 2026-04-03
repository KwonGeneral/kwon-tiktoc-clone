import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:kwon_tiktoc_clone/domain/entity/post_image.dart';

part 'post_image_model.freezed.dart';
part 'post_image_model.g.dart';

@freezed
sealed class PostImageModel with _$PostImageModel {
  const factory PostImageModel({
    required String id,
    required String thumbUrl,
    required String fullUrl,
    @Default('') String caption,
    @Default('') String userId,
    @Default('') String username,
    @Default('') String nickname,
    @Default('') String avatarUrl,
    required DateTime createdAt,
  }) = _PostImageModel;

  const PostImageModel._();

  factory PostImageModel.fromJson(Map<String, dynamic> json) =>
      _$PostImageModelFromJson(json);

  PostImage toEntity() => PostImage(
    id: id,
    thumbUrl: thumbUrl,
    fullUrl: fullUrl,
    caption: caption,
    userId: userId,
    username: username,
    nickname: nickname,
    avatarUrl: avatarUrl,
    createdAt: createdAt,
  );
}
