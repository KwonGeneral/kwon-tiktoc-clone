import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../core/constants/app_strings.dart';

class ProfileEmptyState extends StatelessWidget {
  const ProfileEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.photo_camera_back_outlined,
              size: 64,
              color: AppColors.whiteSecondary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            const Text(
              AppStrings.profileEmptyVideos,
              style: AppTextStyles.description,
            ),
            const SizedBox(height: 16),
            _buildUploadButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        AppStrings.profileUpload,
        style: AppTextStyles.description.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
