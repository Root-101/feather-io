import 'package:console/app_exporter.dart';

/// Object filter of the browser. Within a group, matching one option is
/// enough; across groups all of them must match. Folders have no type, size or
/// date, so they are hidden while any filter is active
class ObjectFilter {
  final Set<ObjectTypeFilter> types;
  final Set<ObjectSizeFilter> sizes;
  final Set<ObjectDateFilter> dates;

  const ObjectFilter({
    this.types = const {},
    this.sizes = const {},
    this.dates = const {},
  });

  static const ObjectFilter none = ObjectFilter();

  /// Checked options, for the button's badge
  int get activeCount => types.length + sizes.length + dates.length;

  bool get isActive => activeCount > 0;

  bool matches(BrowserObjectWrapper wrapper, {DateTime? now}) {
    if (!isActive) return true;
    if (wrapper.isFolder) return false;

    if (types.isNotEmpty &&
        !types.contains(ObjectTypeFilter.of(wrapper.name))) {
      return false;
    }
    final size = wrapper.size;
    if (sizes.isNotEmpty &&
        (size == null || !sizes.any((s) => s.matches(size)))) {
      return false;
    }
    final lastModified = wrapper.lastModified;
    final reference = now ?? DateTime.now();
    if (dates.isNotEmpty &&
        (lastModified == null ||
            !dates.any((d) => d.matches(lastModified, reference)))) {
      return false;
    }
    return true;
  }

  ObjectFilter copyWith({
    Set<ObjectTypeFilter>? types,
    Set<ObjectSizeFilter>? sizes,
    Set<ObjectDateFilter>? dates,
  }) {
    return ObjectFilter(
      types: types ?? this.types,
      sizes: sizes ?? this.sizes,
      dates: dates ?? this.dates,
    );
  }
}
