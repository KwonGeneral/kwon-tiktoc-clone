import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:video_compress/video_compress.dart';

import 'package:kwon_tiktoc_clone/core/di/providers.dart';
import 'publish_state.dart';

part 'publish_provider.g.dart';

@riverpod
class PublishNotifier extends _$PublishNotifier {
  @override
  PublishState build() {
    return const PublishState();
  }

  Future<void> publish({
    required String videoFilePath,
    required String description,
  }) async {
    try {
      // 1) 압축
      state = state.copyWith(
        status: PublishStatus.compressing,
        progress: 0.0,
        errorMessage: null,
      );

      final compressedPath = await _compressVideo(videoFilePath);

      // 2) 업로드
      state = state.copyWith(status: PublishStatus.uploading, progress: 0.0);

      // 프로필 정보 가져오기
      final storage = ref.read(localStorageRepositoryProvider);
      final profileImageUrl = storage.getProfileImageUrl();
      final profileNickname = storage.getProfileNickname();
      final profileUsername = storage.getProfileUsername();
      final deviceId = ref.read(deviceIdServiceProvider).getDeviceId();

      final repository = ref.read(videoRepositoryProvider);
      final uploadedVideo = await repository.uploadVideo(
        filePath: compressedPath,
        description: description,
        title: description,
        userId: deviceId,
        username: profileUsername.isNotEmpty ? profileUsername : profileNickname,
        nickname: profileNickname,
        avatarUrl: profileImageUrl.isNotEmpty ? profileImageUrl : null,
        onProgress: (progress) {
          state = state.copyWith(progress: progress);
        },
      );

      // 썸네일 생성 (업로드 영상용)
      String? thumbnailPath;
      try {
        final thumbnailFile = await VideoCompress.getFileThumbnail(
          videoFilePath,
          quality: 50,
          position: -1,
        );
        thumbnailPath = thumbnailFile.path;
      } catch (e) {
        debugPrint('썸네일 생성 실패: $e');
      }

      state = state.copyWith(
        status: PublishStatus.success,
        progress: 1.0,
        uploadedVideoUrl: uploadedVideo.videoUrl,
        uploadedDescription: description,
        thumbnailPath: thumbnailPath,
      );
    } catch (e) {
      state = state.copyWith(
        status: PublishStatus.failed,
        errorMessage: e.toString(),
      );
    }
  }

  Future<String> _compressVideo(String filePath) async {
    try {
      state = state.copyWith(progress: 0.1);

      final info = await VideoCompress.compressVideo(
        filePath,
        quality: VideoQuality.MediumQuality,
        deleteOrigin: false,
      );

      state = state.copyWith(progress: 1.0);

      if (info?.file != null) {
        debugPrint(
          '압축 완료: ${File(filePath).lengthSync()} → ${info!.file!.lengthSync()} bytes',
        );
        return info.file!.path;
      }

      return filePath;
    } catch (e) {
      debugPrint('압축 실패, 원본 사용: $e');
      return filePath;
    }
  }

  void reset() {
    state = const PublishState();
  }
}
