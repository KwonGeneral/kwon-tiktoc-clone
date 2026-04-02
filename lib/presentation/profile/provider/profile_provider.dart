import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/di/providers.dart';
import '../../../domain/entity/user.dart';
import '../../../domain/entity/video.dart';
import '../../../domain/repository/local_storage_repository.dart';
import '../../feed/provider/feed_provider.dart';

part 'profile_provider.g.dart';

@riverpod
Future<User> currentUser(Ref ref) async {
  final repository = ref.watch(userRepositoryProvider);
  final storage = ref.watch(localStorageRepositoryProvider);
  final user = await repository.getCurrentUser();

  final savedNickname = storage.getProfileNickname();
  final savedBio = storage.getProfileBio();

  return user.copyWith(
    nickname: savedNickname.isNotEmpty ? savedNickname : user.nickname,
    bio: savedBio,
  );
}

@riverpod
List<Video> likedVideos(Ref ref) {
  final feedAsync = ref.watch(feedNotifierProvider);
  return feedAsync.maybeWhen(
    data: (state) => state.videos.where((v) => v.isLiked).toList(),
    orElse: () => [],
  );
}

@riverpod
List<Video> bookmarkedVideos(Ref ref) {
  final feedAsync = ref.watch(feedNotifierProvider);
  return feedAsync.maybeWhen(
    data: (state) => state.videos.where((v) => v.isBookmarked).toList(),
    orElse: () => [],
  );
}

@riverpod
List<Video> myVideos(Ref ref) {
  final feedAsync = ref.watch(feedNotifierProvider);
  return feedAsync.maybeWhen(
    data: (state) =>
        state.videos.where((v) => v.userId == 'current_user').toList(),
    orElse: () => [],
  );
}

@riverpod
class ProfileEditNotifier extends _$ProfileEditNotifier {
  late final LocalStorageRepository _storage;

  @override
  ({String nickname, String bio}) build() {
    _storage = ref.read(localStorageRepositoryProvider);
    return (
      nickname: _storage.getProfileNickname(),
      bio: _storage.getProfileBio(),
    );
  }

  Future<void> save({required String nickname, required String bio}) async {
    await _storage.saveProfileNickname(nickname);
    await _storage.saveProfileBio(bio);
    state = (nickname: nickname, bio: bio);
    ref.invalidate(currentUserProvider);
  }
}

@riverpod
class NotificationSettingNotifier extends _$NotificationSettingNotifier {
  late final LocalStorageRepository _storage;

  @override
  bool build() {
    _storage = ref.read(localStorageRepositoryProvider);
    return _storage.getNotificationEnabled();
  }

  Future<void> toggle() async {
    final newValue = !state;
    await _storage.saveNotificationEnabled(enabled: newValue);
    state = newValue;
  }
}
