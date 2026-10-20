class NumberFormatter {
  static String formatCount(int? count) {
    if (count == null) return '0';
    
    if (count >= 1000000) {
      double million = count / 1000000;
      return '${million.toStringAsFixed(million.truncateToDouble() == million ? 0 : 1)}m';
    } else if (count >= 1000) {
      double thousand = count / 1000;
      return '${thousand.toStringAsFixed(thousand.truncateToDouble() == thousand ? 0 : 1)}k';
    } else {
      return count.toString();
    }
  }
}
