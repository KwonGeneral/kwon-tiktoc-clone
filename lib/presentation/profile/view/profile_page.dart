// Phase 8에서 본격 구현 예정
import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/constants/app_strings.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.black,
      body: Center(
        child: Text(
          AppStrings.placeholderProfile,
          style: TextStyle(
            color: AppColors.whiteSecondary,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
