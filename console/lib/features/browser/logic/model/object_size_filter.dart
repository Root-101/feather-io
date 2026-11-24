/// Size range: under 1 MB, from 1 to 100 MB, over 100 MB
enum ObjectSizeFilter {
  small,
  medium,
  large;

  static const int _mb = 1024 * 1024;

  bool matches(int bytes) => switch (this) {
    small => bytes < _mb,
    medium => bytes >= _mb && bytes <= 100 * _mb,
    large => bytes > 100 * _mb,
  };
}
