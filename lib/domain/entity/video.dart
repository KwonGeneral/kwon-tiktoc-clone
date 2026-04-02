import 'package:freezed_annotation/freezed_annotation.dart';

part 'video.freezed.dart';

@freezed
sealed class Video with _$Video {
  const factory Video({
    required String id,
    required String userId,
    required String videoUrl,
    @Default('') String hlsUrl,
    @Default('') String thumbnailUrl,
    @Default('') String description,
    @Default('') String musicName,
    @Default('') String username,
    @Default('') String nickname,
    @Default('') String avatarUrl,
    @Default(0) int likeCount,
    @Default(0) int commentCount,
    @Default(0) int bookmarkCount,
    @Default(0) int shareCount,
    @Default(false) bool isLiked,
    @Default(false) bool isBookmarked,
    required DateTime createdAt,
  }) = _Video;
}
