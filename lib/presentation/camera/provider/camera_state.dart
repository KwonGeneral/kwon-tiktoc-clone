import 'package:freezed_annotation/freezed_annotation.dart';

part 'camera_state.freezed.dart';

enum RecordingStatus { idle, recording, paused }

@freezed
sealed class CameraState with _$CameraState {
  const factory CameraState({
    @Default(RecordingStatus.idle) RecordingStatus status,
    @Default(Duration.zero) Duration elapsed,
    @Default(false) bool isFrontCamera,
    String? recordedFilePath,
  }) = _CameraState;
}
