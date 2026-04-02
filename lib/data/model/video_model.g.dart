// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VideoModel _$VideoModelFromJson(Map<String, dynamic> json) => _VideoModel(
  id: json['id'] as String,
  userId: json['userId'] as String,
  videoUrl: json['videoUrl'] as String,
  thumbnailUrl: json['thumbnailUrl'] as String? ?? '',
  description: json['description'] as String? ?? '',
  musicName: json['musicName'] as String? ?? '',
  username: json['username'] as String? ?? '',
  nickname: json['nickname'] as String? ?? '',
  avatarUrl: json['avatarUrl'] as String? ?? '',
  likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
  commentCount: (json['commentCount'] as num?)?.toInt() ?? 0,
  bookmarkCount: (json['bookmarkCount'] as num?)?.toInt() ?? 0,
  shareCount: (json['shareCount'] as num?)?.toInt() ?? 0,
  isLiked: json['isLiked'] as bool? ?? false,
  isBookmarked: json['isBookmarked'] as bool? ?? false,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$VideoModelToJson(_VideoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'videoUrl': instance.videoUrl,
      'thumbnailUrl': instance.thumbnailUrl,
      'description': instance.description,
      'musicName': instance.musicName,
      'username': instance.username,
      'nickname': instance.nickname,
      'avatarUrl': instance.avatarUrl,
      'likeCount': instance.likeCount,
      'commentCount': instance.commentCount,
      'bookmarkCount': instance.bookmarkCount,
      'shareCount': instance.shareCount,
      'isLiked': instance.isLiked,
      'isBookmarked': instance.isBookmarked,
      'createdAt': instance.createdAt.toIso8601String(),
    };
