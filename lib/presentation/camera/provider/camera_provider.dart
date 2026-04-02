import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:kwon_tiktoc_clone/core/constants/app_constants.dart';
import 'camera_state.dart';

part 'camera_provider.g.dart';

@riverpod
class CameraNotifier extends _$CameraNotifier {
  Timer? _timer;

  @override
  CameraState build() {
    ref.onDispose(_stopTimer);
    return const CameraState();
  }

  void startRecording() {
    state = state.copyWith(
      status: RecordingStatus.recording,
      elapsed: Duration.zero,
    );
    _startTimer();
  }

  void pauseRecording() {
    _stopTimer();
    state = state.copyWith(status: RecordingStatus.paused);
  }

  void resumeRecording() {
    state = state.copyWith(status: RecordingStatus.recording);
    _startTimer();
  }

  void stopRecording(String filePath) {
    _stopTimer();
    state = state.copyWith(
      status: RecordingStatus.idle,
      recordedFilePath: filePath,
    );
  }

  void resetRecording() {
    _stopTimer();
    state = const CameraState();
  }

  void toggleCamera() {
    state = state.copyWith(isFrontCamera: !state.isFrontCamera);
  }

  void _startTimer() {
    _stopTimer();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      final newElapsed = state.elapsed + const Duration(milliseconds: 100);
      if (newElapsed >= AppConstants.maxRecordingDuration) {
        _stopTimer();
        state = state.copyWith(elapsed: AppConstants.maxRecordingDuration);
        // 자동 정지는 UI에서 ref.listen으로 처리 (CameraController 접근 필요)
      } else {
        state = state.copyWith(elapsed: newElapsed);
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }
}
