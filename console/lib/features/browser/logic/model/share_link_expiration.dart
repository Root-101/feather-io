/// How long a shared link lasts
enum ShareLinkExpiration {
  hour(Duration(hours: 1)),
  day(Duration(days: 1)),
  week(Duration(days: 7));

  final Duration duration;

  const ShareLinkExpiration(this.duration);
}
