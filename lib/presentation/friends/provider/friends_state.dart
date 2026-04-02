import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:kwon_tiktoc_clone/domain/entity/user.dart';

part 'friends_state.freezed.dart';

@freezed
sealed class FriendsState with _$FriendsState {
  const factory FriendsState({
    @Default([]) List<User> users,
    @Default('') String searchQuery,
  }) = _FriendsState;
}
