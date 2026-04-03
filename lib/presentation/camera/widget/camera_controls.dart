import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:kwon_tiktoc_clone/app/theme/app_colors.dart';
import 'package:kwon_tiktoc_clone/core/constants/app_constants.dart';
import 'package:kwon_tiktoc_clone/presentation/camera/provider/camera_state.dart';

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 타이머 (녹화/일시정지 중)
        if (status != RecordingStatus.idle)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              _formatElapsed(elapsed),
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        // 버튼 Row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 왼쪽 빈 영역 (균형 맞춤)
            const SizedBox(width: 100),
            // 중앙: 녹화 버튼
            _RecordButton(
              status: status,
              onStartRecording: onStartRecording,
              onPauseRecording: onPauseRecording,
              onResumeRecording: onResumeRecording,
            ),
            // 우측: 취소 + 완료 버튼
            SizedBox(
              width: 100,
              child: status != RecordingStatus.idle
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 취소 (X)
                        GestureDetector(
                          onTap: onCancel,
                          child: Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: AppColors.white.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: AppColors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // 완료 (✓)
                        GestureDetector(
                          onTap: onStopRecording,
                          child: Container(
                            width: 38,
                            height: 38,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              color: AppColors.white,
                              size: 22,
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ],
    );
  }

  String _formatElapsed(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}

// ---------------------------------------------------------------------------
// Record Button (StatefulWidget with AnimationController for smooth progress)
// ---------------------------------------------------------------------------

class _RecordButton extends StatefulWidget {
  const _RecordButton({
    required this.status,
    required this.onStartRecording,
    required this.onPauseRecording,
    required this.onResumeRecording,
  });

  final RecordingStatus status;
  final VoidCallback onStartRecording;
  final VoidCallback onPauseRecording;
  final VoidCallback onResumeRecording;

  @override
  State<_RecordButton> createState() => _RecordButtonState();
}

class _RecordButtonState extends State<_RecordButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _progressController;

  static const double _buttonSize = 80.0;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: AppConstants.maxRecordingDuration,
    );
  }

  @override
  void didUpdateWidget(covariant _RecordButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.status != widget.status) {
      switch (widget.status) {
        case RecordingStatus.idle:
          _progressController.reset();
        case RecordingStatus.recording:
          _progressController.forward();
        case RecordingStatus.paused:
          _progressController.stop();
      }
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: SizedBox(
        width: _buttonSize,
        height: _buttonSize,
        child: AnimatedBuilder(
          animation: _progressController,
          builder: (context, child) {
            return CustomPaint(
              painter: _RingPainter(
                progress: _progressController.value,
                isActive: widget.status != RecordingStatus.idle,
              ),
              child: child,
            );
          },
          child: Center(child: _buildInner()),
        ),
      ),
    );
  }

  void _handleTap() {
    switch (widget.status) {
      case RecordingStatus.idle:
        widget.onStartRecording();
      case RecordingStatus.recording:
        widget.onPauseRecording();
      case RecordingStatus.paused:
        widget.onResumeRecording();
    }
  }

  Widget _buildInner() {
    // 대기: 큰 빨간 원
    if (widget.status == RecordingStatus.idle) {
      return Container(
        width: 60,
        height: 60,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
      );
    }
    // 녹화 중: 작은 빨간 원 (탭하면 일시정지)
    if (widget.status == RecordingStatus.recording) {
      return Container(
        width: 54,
        height: 54,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
      );
    }
    // 일시정지: 빨간 사각형
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Ring Painter
// ---------------------------------------------------------------------------

class _RingPainter extends CustomPainter {
  _RingPainter({required this.progress, required this.isActive});

  final double progress;
  final bool isActive;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 3;

    // 배경 링 (회색)
    final bgPaint = Paint()
      ..color = isActive
          ? const Color(0x55FFFFFF)
          : const Color(0x44FFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;
    canvas.drawCircle(center, radius, bgPaint);

    // 프로그래스 아크 (빨간색)
    if (progress > 0) {
      final progressPaint = Paint()
        ..color = AppColors.primary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2,
        2 * math.pi * progress,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.isActive != isActive;
}
