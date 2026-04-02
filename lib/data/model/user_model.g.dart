// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: json['id'] as String,
  nickname: json['nickname'] as String,
  avatarUrl: json['avatarUrl'] as String? ?? '',
  bio: json['bio'] as String? ?? '',
  isVerified: json['isVerified'] as bool? ?? false,
  followingCount: (json['followingCount'] as num?)?.toInt() ?? 0,
  followerCount: (json['followerCount'] as num?)?.toInt() ?? 0,
  likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'avatarUrl': instance.avatarUrl,
      'bio': instance.bio,
      'isVerified': instance.isVerified,
      'followingCount': instance.followingCount,
      'followerCount': instance.followerCount,
      'likeCount': instance.likeCount,
    };
