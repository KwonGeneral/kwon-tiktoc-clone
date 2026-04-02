import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_image.freezed.dart';

@freezed
sealed class PostImage with _$PostImage {
  const factory PostImage({
    required String id,
    required String thumbUrl,
    required String fullUrl,
    @Default('') String caption,
    @Default('') String userId,
    @Default('') String username,
    @Default('') String nickname,
    @Default('') String avatarUrl,
    required DateTime createdAt,
  }) = _PostImage;
}
