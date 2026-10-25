import 'package:console/app_exporter.dart';
import 'package:material_ui/material_ui.dart';

/// *Filter* button of the browser: type, size and modification date of the
/// objects of the pages already loaded
class ObjectsFilterButton extends StatelessWidget {
  final ObjectFilter filter;
  final ValueChanged<ObjectFilter> onChanged;

  const ObjectsFilterButton({
    required this.filter,
    required this.onChanged,
    super.key,
  });

  Set<T> _toggle<T>(Set<T> set, T value) =>
      set.contains(value) ? ({...set}..remove(value)) : {...set, value};

  @override
  Widget build(BuildContext context) {
    return AppFilterButton(
      activeCount: filter.activeCount,
      onClear: () => onChanged(ObjectFilter.none),
      note: app.intl.objects.filterFoldersHidden,
      groups: [
        AppFilterGroup(
          title: app.intl.objects.filterType,
          options: [
            for (final type in ObjectTypeFilter.values)
              AppFilterOption(
                label: _typeLabel(type),
                selected: filter.types.contains(type),
                onTap: () => onChanged(
                  filter.copyWith(types: _toggle(filter.types, type)),
                ),
              ),
          ],
        ),
        AppFilterGroup(
          title: app.intl.objects.filterSize,
          options: [
            for (final size in ObjectSizeFilter.values)
              AppFilterOption(
                label: _sizeLabel(size),
                selected: filter.sizes.contains(size),
                onTap: () => onChanged(
                  filter.copyWith(sizes: _toggle(filter.sizes, size)),
                ),
              ),
          ],
        ),
        AppFilterGroup(
          title: app.intl.objects.filterModified,
          options: [
            for (final date in ObjectDateFilter.values)
              AppFilterOption(
                label: _dateLabel(date),
                selected: filter.dates.contains(date),
                onTap: () => onChanged(
                  filter.copyWith(dates: _toggle(filter.dates, date)),
                ),
              ),
          ],
        ),
      ],
    );
  }

  String _typeLabel(ObjectTypeFilter type) => switch (type) {
    ObjectTypeFilter.image => app.intl.objects.fileTypeImage,
    ObjectTypeFilter.video => app.intl.objects.fileTypeVideo,
    ObjectTypeFilter.audio => app.intl.objects.fileTypeAudio,
    ObjectTypeFilter.document => app.intl.objects.fileTypeDocument,
    ObjectTypeFilter.archive => app.intl.objects.fileTypeArchive,
    ObjectTypeFilter.other => app.intl.objects.filterTypeOther,
  };

  String _sizeLabel(ObjectSizeFilter size) => switch (size) {
    ObjectSizeFilter.small => app.intl.objects.filterSizeSmall,
    ObjectSizeFilter.medium => app.intl.objects.filterSizeMedium,
    ObjectSizeFilter.large => app.intl.objects.filterSizeLarge,
  };

  String _dateLabel(ObjectDateFilter date) => switch (date) {
    ObjectDateFilter.last24Hours => app.intl.objects.filterDate24h,
    ObjectDateFilter.last7Days => app.intl.objects.filterDate7d,
    ObjectDateFilter.last30Days => app.intl.objects.filterDate30d,
    ObjectDateFilter.older => app.intl.objects.filterDateOlder,
  };
}
