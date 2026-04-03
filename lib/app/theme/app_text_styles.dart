import 'package:flutter/painting.dart';
import 'app_colors.dart';
import 'app_font_sizes.dart';

abstract final class AppTextStyles {
  static const username = TextStyle(
    color: AppColors.white,
    fontSize: AppFontSizes.subtitle,
    fontWeight: FontWeight.w700,
  );

  static const description = TextStyle(
    color: AppColors.white,
    fontSize: AppFontSizes.bodyMd,
    fontWeight: FontWeight.w400,
  );

  static const count = TextStyle(
    color: AppColors.white,
    fontSize: AppFontSizes.caption,
    fontWeight: FontWeight.w600,
  );

  static const tabActive = TextStyle(
    color: AppColors.white,
    fontSize: AppFontSizes.subtitle,
    fontWeight: FontWeight.w700,
  );

  static const tabInactive = TextStyle(
    color: AppColors.whiteSecondary,
    fontSize: AppFontSizes.subtitle,
    fontWeight: FontWeight.w400,
  );

  static const musicInfo = TextStyle(
    color: AppColors.white,
    fontSize: AppFontSizes.body,
    fontWeight: FontWeight.w400,
  );

  static const profileName = TextStyle(
    color: AppColors.white,
    fontSize: AppFontSizes.headline,
    fontWeight: FontWeight.w700,
  );

  static const profileId = TextStyle(
    color: AppColors.whiteSecondary,
    fontSize: AppFontSizes.bodyMd,
    fontWeight: FontWeight.w400,
  );

  static const profileCount = TextStyle(
    color: AppColors.white,
    fontSize: AppFontSizes.titleLg,
    fontWeight: FontWeight.w700,
  );

  static const profileLabel = TextStyle(
    color: AppColors.whiteSecondary,
    fontSize: AppFontSizes.caption,
    fontWeight: FontWeight.w400,
  );
}
