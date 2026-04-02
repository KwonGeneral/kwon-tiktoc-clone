import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/app_strings.dart';
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
  final savedProfileImage = storage.getProfileImageUrl();

  return user.copyWith(
    nickname: savedNickname.isNotEmpty ? savedNickname : user.nickname,
    bio: savedBio,
    avatarUrl: savedProfileImage.isNotEmpty ? savedProfileImage : user.avatarUrl,
  );
}

@riverpod
Future<String?> profileImage(Ref ref, String userId) async {
  final repository = ref.watch(userRepositoryProvider);
  return repository.getProfileImageUrl(userId);
}

@riverpod
class ProfileImageNotifier extends _$ProfileImageNotifier {
  @override
  FutureOr<String?> build() {
    final storage = ref.read(localStorageRepositoryProvider);
    final cachedUrl = storage.getProfileImageUrl();
    return cachedUrl.isNotEmpty ? cachedUrl : null;
  }

  Future<void> upload(String imagePath) async {
    state = const AsyncLoading();
    try {
      final repository = ref.read(userRepositoryProvider);
      final storage = ref.read(localStorageRepositoryProvider);
      final url = await repository.uploadProfileImage(
        imagePath: imagePath,
        userId: AppStrings.commentCurrentUserId,
      );
      await storage.saveProfileImageUrl(url);
      state = AsyncData(url);
      ref.invalidate(currentUserProvider);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
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
        state.videos
            .where((v) => v.userId == AppStrings.commentCurrentUserId)
            .toList(),
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
