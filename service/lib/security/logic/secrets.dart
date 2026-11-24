import 'dart:convert';

/// The one helper that compares secrets (keys, signatures).
abstract final class Secrets {
  /// Compares [given] with [expected] without stopping at the first
  /// difference (nor at a different length): the time gives nothing away.
  static bool sameText(String given, String expected) {
    final a = utf8.encode(given);
    final b = utf8.encode(expected);
    var diff = a.length ^ b.length;
    for (var i = 0; i < b.length; i++) {
      diff |= (i < a.length ? a[i] : 0) ^ b[i];
    }
    return diff == 0;
  }
}
