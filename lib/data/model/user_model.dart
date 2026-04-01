import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:supersent_tiktoc_clone/domain/entity/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
sealed class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String nickname,
    @Default('') String avatarUrl,
    @Default(false) bool isVerified,
    @Default(0) int followingCount,
    @Default(0) int followerCount,
    @Default(0) int likeCount,
  }) = _UserModel;

  const UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromEntity(User entity) => UserModel(
        id: entity.id,
        nickname: entity.nickname,
        avatarUrl: entity.avatarUrl,
        isVerified: entity.isVerified,
        followingCount: entity.followingCount,
        followerCount: entity.followerCount,
        likeCount: entity.likeCount,
      );

  User toEntity() => User(
        id: id,
        nickname: nickname,
        avatarUrl: avatarUrl,
        isVerified: isVerified,
        followingCount: followingCount,
        followerCount: followerCount,
        likeCount: likeCount,
      );
}
