import 'package:kwon_tiktoc_clone/core/constants/app_strings.dart';

abstract final class FormatUtils {
  static String timeAgo(DateTime dateTime) {
    final diff = DateTime.now().difference(dateTime);

    if (diff.inMinutes < 1) return AppStrings.commentJustNow;
    if (diff.inHours < 1) {
      return AppStrings.commentMinutesAgo.replaceAll(
        '{m}',
        diff.inMinutes.toString(),
      );
    }
    if (diff.inDays < 1) {
      return AppStrings.commentHoursAgo.replaceAll(
        '{h}',
        diff.inHours.toString(),
      );
    }
    return AppStrings.commentDaysAgo.replaceAll('{d}', diff.inDays.toString());
  }

  /// 숫자를 축약 포맷으로 변환 (1200 → 1.2K, 5500000 → 5.5M)
  static String compactNumber(int number) {
    if (number >= 1000000000) {
      return '${(number / 1000000000).toStringAsFixed(1)}B';
    }
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    }
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
}
