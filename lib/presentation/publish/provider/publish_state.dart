import 'package:freezed_annotation/freezed_annotation.dart';

part 'publish_state.freezed.dart';

enum PublishStatus { idle, compressing, uploading, success, failed }

@freezed
sealed class PublishState with _$PublishState {
  const factory PublishState({
    @Default(PublishStatus.idle) PublishStatus status,
    @Default(0.0) double progress,
    String? errorMessage,
    String? uploadedVideoUrl,
    String? uploadedDescription,
    String? thumbnailPath,
  }) = _PublishState;
}
