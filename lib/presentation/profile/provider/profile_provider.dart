import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/entity/user.dart';

part 'profile_provider.g.dart';

@riverpod
class CurrentUser extends _$CurrentUser {
  @override
  User build() {
    return const User(
      id: 'user96170612283663',
      nickname: '권태완',
      avatarUrl: '',
      isVerified: false,
      followingCount: 0,
      followerCount: 0,
      likeCount: 0,
    );
  }
}
