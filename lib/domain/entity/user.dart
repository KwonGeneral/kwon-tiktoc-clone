import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
sealed class User with _$User {
  const factory User({
    required String id,
    required String nickname,
    @Default('') String username,
    @Default('') String avatarUrl,
    @Default('') String bio,
    @Default(false) bool isVerified,
    @Default(0) int followingCount,
    @Default(0) int followerCount,
    @Default(0) int likeCount,
  }) = _User;
}
