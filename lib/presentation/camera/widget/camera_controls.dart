import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_strings.dart';
import '../provider/camera_state.dart';

class CameraControls extends StatelessWidget {
  const CameraControls({
    super.key,
    required this.status,
    required this.elapsed,
    required this.onStartRecording,
    required this.onPauseRecording,
    required this.onResumeRecording,
    required this.onStopRecording,
    required this.onCancel,
  });

  final RecordingStatus status;
  final Duration elapsed;
  final VoidCallback onStartRecording;
  final VoidCallback onPauseRecording;
  final VoidCallback onResumeRecording;
  final VoidCallback onStopRecording;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // 취소 버튼 (녹화 중/일시정지일 때만 표시)
        SizedBox(
          width: 60,
          child: status != RecordingStatus.idle
              ? _CancelButton(onTap: onCancel)
              : const SizedBox.shrink(),
        ),
        // 중앙: 녹화/일시정지 버튼
        _RecordButton(
          status: status,
          elapsed: elapsed,
          onStartRecording: onStartRecording,
          onPauseRecording: onPauseRecording,
          onResumeRecording: onResumeRecording,
        ),
        // 완료 버튼 (녹화 중/일시정지일 때만 표시)
        SizedBox(
          width: 60,
          child: status != RecordingStatus.idle
              ? _CompleteButton(onTap: onStopRecording)
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _RecordButton extends StatelessWidget {
  const _RecordButton({
    required this.status,
    required this.elapsed,
    required this.onStartRecording,
    required this.onPauseRecording,
    required this.onResumeRecording,
  });

  final RecordingStatus status;
  final Duration elapsed;
  final VoidCallback onStartRecording;
  final VoidCallback onPauseRecording;
  final VoidCallback onResumeRecording;

  @override
  Widget build(BuildContext context) {
    final progress = elapsed.inMilliseconds /
        AppConstants.maxRecordingDuration.inMilliseconds;

    return GestureDetector(
      onTap: () {
        switch (status) {
          case RecordingStatus.idle:
            onStartRecording();
          case RecordingStatus.recording:
            onPauseRecording();
          case RecordingStatus.paused:
            onResumeRecording();
        }
      },
      child: SizedBox(
        width: 80,
        height: 80,
        child: CustomPaint(
          painter: _RecordButtonPainter(
            progress: progress,
            isRecording: status == RecordingStatus.recording,
          ),
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: status == RecordingStatus.idle ? 56 : 32,
              height: status == RecordingStatus.idle ? 56 : 32,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(
                  status == RecordingStatus.idle ? 28 : 8,
                ),
              ),
              child: status == RecordingStatus.paused
                  ? const Icon(Icons.play_arrow,
                      color: AppColors.white, size: 20)
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}

class _RecordButtonPainter extends CustomPainter {
  _RecordButtonPainter({
    required this.progress,
    required this.isRecording,
  });

  final double progress;
  final bool isRecording;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // 외곽 원 (배경)
    final bgPaint = Paint()
      ..color = AppColors.whiteDisabled
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawCircle(center, radius - 2, bgPaint);

    // 프로그레스 아크
    if (progress > 0) {
      final progressPaint = Paint()
        ..color = AppColors.primary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - 2),
        -math.pi / 2,
        2 * math.pi * progress,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RecordButtonPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.isRecording != isRecording;
}

class _CancelButton extends StatelessWidget {
  const _CancelButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.close, color: AppColors.white, size: 28),
          SizedBox(height: 4),
          Text(
            AppStrings.cameraCancel,
            style: TextStyle(color: AppColors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _CompleteButton extends StatelessWidget {
  const _CompleteButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.check, color: AppColors.white, size: 24),
      ),
    );
  }
}
