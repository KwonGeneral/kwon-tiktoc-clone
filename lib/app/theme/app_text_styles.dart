import 'package:flutter/painting.dart';
import 'app_colors.dart';

abstract final class AppTextStyles {
  static const username = TextStyle(
    color: AppColors.white,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static const description = TextStyle(
    color: AppColors.white,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const count = TextStyle(
    color: AppColors.white,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  static const tabActive = TextStyle(
    color: AppColors.white,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static const tabInactive = TextStyle(
    color: AppColors.whiteSecondary,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const musicInfo = TextStyle(
    color: AppColors.white,
    fontSize: 13,
    fontWeight: FontWeight.w400,
  );

  static const profileName = TextStyle(
    color: AppColors.white,
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  static const profileId = TextStyle(
    color: AppColors.whiteSecondary,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const profileCount = TextStyle(
    color: AppColors.white,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );

  static const profileLabel = TextStyle(
    color: AppColors.whiteSecondary,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
}
