import 'dart:ui';

abstract final class AppColors {
  // Background
  static const black = Color(0xFF000000);
  static const darkGray = Color(0xFF121212);
  static const commentBackground = Color(0xFF1C1C1E);
  static const commentInputBackground = Color(0xFF2A2A2C);
  static const gray = Color(0xFF2C2C2C);

  // Text
  static const white = Color(0xFFFFFFFF);
  static const whiteSecondary = Color(0xB3FFFFFF); // 70%
  static const whiteDisabled = Color(0x80FFFFFF); // 50%

  // Brand
  static const primary = Color(0xFFFF2D55); // TikTok 핑크
  static const secondary = Color(0xFF25F4EE); // TikTok 시안

  // Interaction
  static const like = Color(0xFFFF2D55);
  static const bookmark = Color(0xFFFACD00);

  // Social
  static const facebookBlue = Color(0xFF1877F2);

  // Notification
  static const commentPurple = Color(0xFF6C5CE7);

  // Utility
  static const divider = Color(0xFF2C2C2C);
  static const overlay = Color(0x80000000); // 50% 블랙
}
