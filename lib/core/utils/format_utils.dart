abstract final class FormatUtils {
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
