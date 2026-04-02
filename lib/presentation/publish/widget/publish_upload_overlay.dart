import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../provider/publish_state.dart';

class PublishUploadOverlay extends StatelessWidget {
  const PublishUploadOverlay({
    super.key,
    required this.state,
    required this.onRetry,
  });

  final PublishState state;
  final VoidCallback onRetry;

  String get _statusText {
    switch (state.status) {
      case PublishStatus.compressing:
        return AppStrings.publishCompressing;
      case PublishStatus.uploading:
        return AppStrings.publishUploading;
      case PublishStatus.success:
        return AppStrings.publishSuccess;
      case PublishStatus.failed:
        return AppStrings.publishFailed;
      case PublishStatus.idle:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.7),
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 48),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (state.status == PublishStatus.failed) ...[
                const Icon(Icons.error_outline, color: AppColors.primary, size: 48),
                const SizedBox(height: 16),
                Text(
                  _statusText,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
                if (state.errorMessage != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    state.errorMessage!,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: onRetry,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(AppStrings.publishRetry),
                ),
              ] else if (state.status == PublishStatus.success) ...[
                const Icon(Icons.check_circle, color: Colors.green, size: 48),
                const SizedBox(height: 16),
                Text(
                  _statusText,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
              ] else ...[
                const SizedBox(
                  width: 48,
                  height: 48,
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                    strokeWidth: 3,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  _statusText,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: state.progress,
                  backgroundColor: const Color(0xFFEEEEEE),
                  color: AppColors.primary,
                  minHeight: 4,
                  borderRadius: BorderRadius.circular(2),
                ),
                const SizedBox(height: 8),
                Text(
                  '${(state.progress * 100).toInt()}%',
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
