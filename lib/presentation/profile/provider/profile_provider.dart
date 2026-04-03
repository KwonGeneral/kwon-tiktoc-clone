import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:kwon_tiktoc_clone/core/di/providers.dart';
import 'package:kwon_tiktoc_clone/domain/entity/post_image.dart';
import 'package:kwon_tiktoc_clone/domain/entity/user.dart';
import 'package:kwon_tiktoc_clone/domain/entity/video.dart';
import 'package:kwon_tiktoc_clone/domain/repository/local_storage_repository.dart';
import 'package:kwon_tiktoc_clone/presentation/feed/provider/feed_provider.dart';
import 'package:kwon_tiktoc_clone/presentation/publish/provider/publish_image_provider.dart';

part 'profile_provider.g.dart';

@riverpod
Future<User> currentUser(Ref ref) async {
  final repository = ref.watch(userRepositoryProvider);
  final storage = ref.watch(localStorageRepositoryProvider);
  final user = await repository.getCurrentUser();

  final savedNickname = storage.getProfileNickname();
  final savedBio = storage.getProfileBio();
  final savedProfileImage = storage.getProfileImageUrl();

  // 실제 데이터 기반 숫자 계산
  final feedState =
      ref.watch(feedNotifierProvider).valueOrNull;
  final followingCount = feedState?.followedUserIds.length ?? 0;
  final likeCount =
      feedState?.videos.where((v) => v.isLiked).length ?? 0;
  // 팔로워는 Mock (기본 8명 유저)
  const followerCount = 8;

  return user.copyWith(
    nickname: savedNickname.isNotEmpty ? savedNickname : user.nickname,
    bio: savedBio,
    avatarUrl: savedProfileImage.isNotEmpty
        ? savedProfileImage
        : user.avatarUrl,
    followingCount: followingCount,
    followerCount: followerCount,
    likeCount: likeCount,
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
      final deviceId = ref.read(deviceIdServiceProvider).getDeviceId();
      final url = await repository.uploadProfileImage(
        imagePath: imagePath,
        userId: deviceId,
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
  final deviceId = ref.watch(deviceIdServiceProvider).getDeviceId();
  final feedAsync = ref.watch(feedNotifierProvider);
  return feedAsync.maybeWhen(
    data: (state) => state.videos
        .where((v) => v.userId == deviceId)
        .toList(),
    orElse: () => [],
  );
}

@riverpod
List<PostImage> myPostImages(Ref ref) {
  final deviceId = ref.watch(deviceIdServiceProvider).getDeviceId();
  final imagesAsync = ref.watch(postImageListNotifierProvider);
  return imagesAsync.maybeWhen(
    data: (images) => images
        .where((img) => img.userId == deviceId)
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
  bool _disposed = false;

  @override
  bool build() {
    _disposed = false;
    ref.onDispose(() => _disposed = true);
    _storage = ref.read(localStorageRepositoryProvider);
    // 초기 상태를 시스템 권한과 동기화
    _syncWithSystem();
    return _storage.getNotificationEnabled();
  }

  /// 시스템 알림 권한 상태와 동기화
  Future<void> _syncWithSystem() async {
    final status = await Permission.notification.status;
    if (_disposed) return;
    final systemEnabled = status.isGranted;
    if (!systemEnabled && state) {
      // 시스템에서 알림이 꺼져있으면 앱 내 토글도 OFF
      await _storage.saveNotificationEnabled(enabled: false);
      if (_disposed) return;
      state = false;
    }
  }

  /// 시스템 설정에서 돌아왔을 때 상태 재확인
  Future<void> checkSystemStatus() async {
    final status = await Permission.notification.status;
    final systemEnabled = status.isGranted;
    await _storage.saveNotificationEnabled(enabled: systemEnabled);
    state = systemEnabled;
  }

  Future<void> toggle() async {
    if (!state) {
      // OFF → ON: 시스템 설정 확인 후 이동
      final status = await Permission.notification.status;
      if (!status.isGranted) {
        // 시스템에서 알림이 꺼져있으면 설정으로 이동 (토글은 변경하지 않음)
        await openAppSettings();
        return;
      }
    }
    final newValue = !state;
    await _storage.saveNotificationEnabled(enabled: newValue);
    state = newValue;
  }
}
