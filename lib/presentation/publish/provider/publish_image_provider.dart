import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:kwon_tiktoc_clone/core/di/providers.dart';
import 'package:kwon_tiktoc_clone/domain/entity/post_image.dart';
import 'publish_state.dart';

part 'publish_image_provider.g.dart';

@riverpod
class PublishImageNotifier extends _$PublishImageNotifier {
  @override
  PublishState build() {
    return const PublishState();
  }

  Future<void> publish({
    required String imageFilePath,
    required String caption,
  }) async {
    try {
      state = state.copyWith(
        status: PublishStatus.uploading,
        progress: 0.0,
        errorMessage: null,
      );

      final storage = ref.read(localStorageRepositoryProvider);
      final profileImageUrl = storage.getProfileImageUrl();
      final deviceId = ref.read(deviceIdServiceProvider).getDeviceId();

      final repository = ref.read(postImageRepositoryProvider);
      await repository.uploadPostImage(
        filePath: imageFilePath,
        caption: caption,
        userId: deviceId,
        avatarUrl: profileImageUrl.isNotEmpty ? profileImageUrl : null,
        onProgress: (progress) {
          state = state.copyWith(progress: progress);
        },
      );

      state = state.copyWith(status: PublishStatus.success, progress: 1.0);
    } catch (e) {
      state = state.copyWith(
        status: PublishStatus.failed,
        errorMessage: e.toString(),
      );
    }
  }

  void reset() {
    state = const PublishState();
  }
}

@riverpod
class PostImageListNotifier extends _$PostImageListNotifier {
  @override
  FutureOr<List<PostImage>> build() async {
    final repository = ref.watch(postImageRepositoryProvider);
    return repository.getPostImages();
  }

  Future<void> reload() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(postImageRepositoryProvider);
      return repository.getPostImages();
    });
  }

  Future<void> deleteImage(String imageId) async {
    final currentImages = state.valueOrNull;
    if (currentImages == null) return;

    final deviceId = ref.read(deviceIdServiceProvider).getDeviceId();
    final repository = ref.read(postImageRepositoryProvider);

    // Optimistic: 즉시 UI에서 제거
    state = AsyncData(currentImages.where((img) => img.id != imageId).toList());

    try {
      await repository.deletePostImage(imageId: imageId, userId: deviceId);
    } catch (_) {
      // 실패 시 롤백
      state = AsyncData(currentImages);
    }
  }
}
