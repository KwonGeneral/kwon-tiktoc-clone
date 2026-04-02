import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:kwon_tiktoc_clone/domain/entity/video.dart';

part 'video_model.freezed.dart';
part 'video_model.g.dart';

@freezed
sealed class VideoModel with _$VideoModel {
  const factory VideoModel({
    required String id,
    required String userId,
    required String videoUrl,
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
  }) = _VideoModel;

  const VideoModel._();

  factory VideoModel.fromJson(Map<String, dynamic> json) =>
      _$VideoModelFromJson(json);

  factory VideoModel.fromEntity(Video entity) => VideoModel(
    id: entity.id,
    userId: entity.userId,
    videoUrl: entity.videoUrl,
    thumbnailUrl: entity.thumbnailUrl,
    description: entity.description,
    musicName: entity.musicName,
    username: entity.username,
    nickname: entity.nickname,
    avatarUrl: entity.avatarUrl,
    likeCount: entity.likeCount,
    commentCount: entity.commentCount,
    bookmarkCount: entity.bookmarkCount,
    shareCount: entity.shareCount,
    isLiked: entity.isLiked,
    isBookmarked: entity.isBookmarked,
    createdAt: entity.createdAt,
  );

  Video toEntity() => Video(
    id: id,
    userId: userId,
    videoUrl: videoUrl,
    thumbnailUrl: thumbnailUrl,
    description: description,
    musicName: musicName,
    username: username,
    nickname: nickname,
    avatarUrl: avatarUrl,
    likeCount: likeCount,
    commentCount: commentCount,
    bookmarkCount: bookmarkCount,
    shareCount: shareCount,
    isLiked: isLiked,
    isBookmarked: isBookmarked,
    createdAt: createdAt,
  );
}
