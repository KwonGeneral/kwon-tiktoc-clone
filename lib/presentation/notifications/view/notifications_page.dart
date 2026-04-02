import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/constants/app_strings.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.black,
      body: Center(
        child: Text(
          AppStrings.placeholderNotifications,
          style: TextStyle(color: AppColors.whiteSecondary, fontSize: 16),
        ),
      ),
    );
  }
}
