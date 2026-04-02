// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostImageModel _$PostImageModelFromJson(Map<String, dynamic> json) =>
    _PostImageModel(
      id: json['id'] as String,
      thumbUrl: json['thumbUrl'] as String,
      fullUrl: json['fullUrl'] as String,
      caption: json['caption'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      username: json['username'] as String? ?? '',
      nickname: json['nickname'] as String? ?? '',
      avatarUrl: json['avatarUrl'] as String? ?? '',
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$PostImageModelToJson(_PostImageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'thumbUrl': instance.thumbUrl,
      'fullUrl': instance.fullUrl,
      'caption': instance.caption,
      'userId': instance.userId,
      'username': instance.username,
      'nickname': instance.nickname,
      'avatarUrl': instance.avatarUrl,
      'createdAt': instance.createdAt.toIso8601String(),
    };
