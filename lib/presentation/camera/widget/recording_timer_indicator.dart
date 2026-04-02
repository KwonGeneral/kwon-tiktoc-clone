import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';

class RecordingTimerIndicator extends StatelessWidget {
  const RecordingTimerIndicator({
    super.key,
    required this.elapsed,
  });

  final Duration elapsed;

  @override
  Widget build(BuildContext context) {
    final seconds = elapsed.inMilliseconds / 1000;
    final maxSeconds =
        AppConstants.maxRecordingDuration.inMilliseconds / 1000;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 타이머 텍스트
        Text(
          '${seconds.toStringAsFixed(1)}s / ${maxSeconds.toInt()}s',
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        // 프로그레스 바
        SizedBox(
          width: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: seconds / maxSeconds,
              backgroundColor: AppColors.whiteDisabled,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.primary),
              minHeight: 3,
            ),
          ),
        ),
      ],
    );
  }
}
