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

  // Light theme (Publish 등)
  static const blackHigh = Color(0xDD000000); // 87%
  static const lightGray = Color(0xFFF0F0F0);
  static const lightGrayBorder = Color(0xFFEEEEEE);
  static const lightGrayBackground = Color(0xFFF5F5F5);
  static const grey = Color(0xFF9E9E9E);
  static const greySecondary = Color(0xFF757575);
  static const success = Color(0xFF4CAF50);

  // Utility
  static const divider = Color(0xFF2C2C2C);
  static const overlay = Color(0x80000000); // 50% 블랙
  static const overlayDark = Color(0xB3000000); // 70% 블랙
  static const whiteOverlayHigh = Color(0x55FFFFFF); // 33%
  static const whiteOverlayLow = Color(0x44FFFFFF); // 27%
}
