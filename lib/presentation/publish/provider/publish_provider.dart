import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:video_compress/video_compress.dart';

import '../../../core/di/providers.dart';
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
      state = state.copyWith(
        status: PublishStatus.uploading,
        progress: 0.0,
      );

      // 프로필 이미지 URL 가져오기
      final storage = ref.read(localStorageRepositoryProvider);
      final profileImageUrl = storage.getProfileImageUrl();

      final repository = ref.read(videoRepositoryProvider);
      await repository.uploadVideo(
        filePath: compressedPath,
        description: description,
        avatarUrl: profileImageUrl.isNotEmpty ? profileImageUrl : null,
        onProgress: (progress) {
          state = state.copyWith(progress: progress);
        },
      );

      state = state.copyWith(
        status: PublishStatus.success,
        progress: 1.0,
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
