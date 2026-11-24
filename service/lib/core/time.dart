/// Now, in UTC: every moment the service stores, sends or compares with a
/// stored date. Never `DateTime.now()` alone (drift and the JSON would mix
/// zones); a wait or a deadline is measured with a `Stopwatch`.
DateTime utcNow() => DateTime.now().toUtc();

extension JsonDate on DateTime {
  /// This moment as the API writes it: ISO 8601 in UTC with milliseconds
  /// (`2026-10-30T05:16:13.373Z`), never epoch numbers.
  String toJsonDate() {
    final text = toUtc().toIso8601String();
    // toIso8601String gives microseconds when there are any: keep 3 decimals
    final dot = text.indexOf('.');
    return dot < 0 ? text : '${text.substring(0, dot + 4)}Z';
  }
}
