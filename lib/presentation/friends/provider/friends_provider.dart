import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:kwon_tiktoc_clone/core/di/providers.dart';
import 'package:kwon_tiktoc_clone/domain/entity/user.dart';
import 'package:kwon_tiktoc_clone/presentation/friends/provider/friends_state.dart';

part 'friends_provider.g.dart';

@riverpod
class FriendsNotifier extends _$FriendsNotifier {
  List<User> _allUsers = [];
  final Set<String> _removedUserIds = {};

  @override
  Future<FriendsState> build() async {
    final repository = ref.watch(userRepositoryProvider);
    _allUsers = await repository.getRecommendedUsers();

    return FriendsState(users: _allUsers);
  }

  void search(String query) {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    final filtered = query.isEmpty
        ? _allUsers
        : _allUsers.where((user) {
            final lowerQuery = query.toLowerCase();
            return user.nickname.toLowerCase().contains(lowerQuery) ||
                user.id.toLowerCase().contains(lowerQuery);
          }).toList();

    final visible = filtered
        .where((u) => !_removedUserIds.contains(u.id))
        .toList();

    state = AsyncData(FriendsState(users: visible, searchQuery: query));
  }

  void removeUser(String userId) {
    final currentState = state.valueOrNull;
    if (currentState == null) return;

    _removedUserIds.add(userId);
    final updatedUsers = currentState.users
        .where((u) => u.id != userId)
        .toList();
    state = AsyncData(currentState.copyWith(users: updatedUsers));
  }
}
