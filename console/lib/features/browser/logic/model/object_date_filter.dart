/// Age of the last modification
enum ObjectDateFilter {
  last24Hours,
  last7Days,
  last30Days,
  older;

  bool matches(DateTime lastModified, DateTime now) {
    final age = now.difference(lastModified);
    return switch (this) {
      last24Hours => age <= const Duration(hours: 24),
      last7Days => age <= const Duration(days: 7),
      last30Days => age <= const Duration(days: 30),
      older => age > const Duration(days: 30),
    };
  }
}
