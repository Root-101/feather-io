///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'messages.g.dart';

// Path: <root>
typedef AppMessagesEn = AppMessages; // ignore: unused_element

class AppMessages with BaseTranslations<AppMessagesLocale, AppMessages> {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppMessagesLocale.build] is preferred.
  AppMessages({
    Map<String, Node>? overrides,
    PluralResolver? cardinalResolver,
    PluralResolver? ordinalResolver,
    TranslationMetadata<AppMessagesLocale, AppMessages>? meta,
  }) : assert(
         overrides == null,
         'Set "translation_overrides: true" in order to enable this feature.',
       ),
       _meta =
           meta ??
           TranslationMetadata(
             locale: AppMessagesLocale.en,
             overrides: overrides ?? {},
             cardinalResolver: cardinalResolver,
             ordinalResolver: ordinalResolver,
           ) {
    _meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <en>.
  final TranslationMetadata<AppMessagesLocale, AppMessages> _meta;
  @override
  TranslationMetadata<AppMessagesLocale, AppMessages> get $meta => _meta;

  /// Access flat map
  dynamic operator [](String key) => _meta.getTranslation(key);

  late final AppMessages _root = this; // ignore: unused_field

  AppMessages $copyWith({
    TranslationMetadata<AppMessagesLocale, AppMessages>? meta,
  }) => AppMessages(meta: meta ?? this.$meta);

  // Translations
  late final AppMessages$app$en app = AppMessages$app$en._(_root);
  late final AppMessages$common$en common = AppMessages$common$en._(_root);
  late final AppMessages$errors$en errors = AppMessages$errors$en._(_root);
  late final AppMessages$nav$en nav = AppMessages$nav$en._(_root);
  late final AppMessages$login$en login = AppMessages$login$en._(_root);
  late final AppMessages$buckets$en buckets = AppMessages$buckets$en._(_root);
  late final AppMessages$objects$en objects = AppMessages$objects$en._(_root);
  late final AppMessages$colors$en colors = AppMessages$colors$en._(_root);
  late final AppMessages$bucketAdmin$en bucketAdmin =
      AppMessages$bucketAdmin$en._(_root);
  late final AppMessages$anonymousAccess$en anonymousAccess =
      AppMessages$anonymousAccess$en._(_root);
  late final AppMessages$browser$en browser = AppMessages$browser$en._(_root);
  late final AppMessages$transfers$en transfers = AppMessages$transfers$en._(
    _root,
  );
  late final AppMessages$accessKeys$en accessKeys = AppMessages$accessKeys$en._(
    _root,
  );
}

// Path: app
class AppMessages$app$en {
  AppMessages$app$en._(this._root);

  final AppMessages _root; // ignore: unused_field

  // Translations

  /// en: 'Feather IO'
  String get name => 'Feather IO';

  /// en: 'Need more space'
  String get needMoreSpace => 'Need more space';

  /// en: 'Connecting to the storage service…'
  String get splashText => 'Connecting to the storage service…';

  /// en: 'With ♥ from Root101'
  String get credit => 'With ♥ from Root101';
}

// Path: common
class AppMessages$common$en {
  AppMessages$common$en._(this._root);

  final AppMessages _root; // ignore: unused_field

  // Translations

  /// en: 'Loading'
  String get loading => 'Loading';

  /// en: 'Error'
  String get error => 'Error';

  /// en: 'Try again'
  String get tryAgain => 'Try again';

  /// en: 'No data'
  String get noData => 'No data';

  /// en: 'Cancel'
  String get cancel => 'Cancel';

  /// en: 'Close'
  String get close => 'Close';

  /// en: 'Delete'
  String get delete => 'Delete';

  /// en: 'Edit'
  String get edit => 'Edit';

  /// en: 'Refresh'
  String get refresh => 'Refresh';

  /// en: 'Required'
  String get required => 'Required';

  /// en: 'Preview'
  String get preview => 'Preview';

  /// en: 'Download'
  String get download => 'Download';

  /// en: 'Upload'
  String get upload => 'Upload';

  /// en: 'Filter'
  String get filter => 'Filter';

  /// en: 'Name'
  String get name => 'Name';

  /// en: 'Type'
  String get type => 'Type';

  /// en: 'Size'
  String get size => 'Size';

  /// en: 'Objects'
  String get objects => 'Objects';

  /// en: 'Created At'
  String get createdAt => 'Created At';

  /// en: 'Last Modified'
  String get lastModified => 'Last Modified';
}

// Path: errors
class AppMessages$errors$en {
  AppMessages$errors$en._(this._root);

  final AppMessages _root; // ignore: unused_field

  // Translations

  /// en: 'Request to API server was cancelled'
  String get requestCancelled => 'Request to API server was cancelled';

  /// en: 'Connection timeout with API server. Check your internet connection'
  String get connectionTimeout =>
      'Connection timeout with API server. Check your internet connection';

  /// en: 'Connection to API server failed due to internet connection'
  String get noConnection =>
      'Connection to API server failed due to internet connection';

  /// en: 'Receive timeout in connection with API server'
  String get receiveTimeout => 'Receive timeout in connection with API server';

  /// en: 'Send timeout with API server'
  String get sendTimeout => 'Send timeout with API server';

  /// en: 'Bad certificate'
  String get badCertificate => 'Bad certificate';

  /// en: 'Connection error'
  String get connection => 'Connection error';

  /// en: 'Validation error'
  String get validation => 'Validation error';

  /// en: 'Server error'
  String get server => 'Server error';

  /// en: 'Unknown error'
  String get unknown => 'Unknown error';
}

// Path: nav
class AppMessages$nav$en {
  AppMessages$nav$en._(this._root);

  final AppMessages _root; // ignore: unused_field

  // Translations

  /// en: 'Browser'
  String get browser => 'Browser';

  /// en: 'Buckets'
  String get buckets => 'Buckets';

  /// en: 'Language: {name: String}'
  String language({required String name}) => 'Language: ${name}';

  /// en: 'Log out'
  String get logout => 'Log out';

  /// en: 'Access keys'
  String get accessKeys => 'Access keys';
}

// Path: login
class AppMessages$login$en {
  AppMessages$login$en._(this._root);

  final AppMessages _root; // ignore: unused_field

  // Translations

  /// en: 'Access Key'
  String get accessKey => 'Access Key';

  /// en: 'Enter your access key'
  String get accessKeyHint => 'Enter your access key';

  /// en: 'Secret Key'
  String get secretKey => 'Secret Key';

  /// en: 'Enter your secret key'
  String get secretKeyHint => 'Enter your secret key';

  /// en: 'Login'
  String get button => 'Login';

  /// en: 'Sign in'
  String get title => 'Sign in';

  /// en: 'Manage your buckets and access keys.'
  String get description => 'Manage your buckets and access keys.';

  /// en: 'The keys are set on the server with:'
  String get envHint => 'The keys are set on the server with:';

  /// en: 'and'
  String get envHintAnd => 'and';

  /// en: 'S3, without the weight.'
  String get tagline => 'S3, without the weight.';

  /// en: 'No setup, no learning curve. Point your usual AWS tools here and start uploading.'
  String get pitch =>
      'No setup, no learning curve. Point your usual AWS tools here and start uploading.';

  List<String> get tags => [
    'Self-hosted',
    'S3-compatible',
    'Lightweight',
    'Built in Dart',
  ];
}

// Path: buckets
class AppMessages$buckets$en {
  AppMessages$buckets$en._(this._root);

  final AppMessages _root; // ignore: unused_field

  // Translations

  /// en: 'Buckets'
  String get title => 'Buckets';

  /// en: 'Manage your S3 compatible buckets and storage resources.'
  String get subtitle =>
      'Manage your S3 compatible buckets and storage resources.';

  /// en: 'Create Bucket'
  String get create => 'Create Bucket';

  /// en: 'Edit Bucket'
  String get edit => 'Edit Bucket';

  /// en: 'Total Buckets'
  String get totalBuckets => 'Total Buckets';

  /// en: 'Total Objects'
  String get totalObjects => 'Total Objects';

  /// en: 'Total Storage'
  String get totalStorage => 'Total Storage';

  /// en: 'Search buckets...'
  String get searchHint => 'Search buckets...';

  /// en: 'No buckets found'
  String get empty => 'No buckets found';

  /// en: 'No buckets matching "{query: String}"'
  String noMatch({required String query}) => 'No buckets matching "${query}"';

  /// en: 'Delete bucket'
  String get deleteTitle => 'Delete bucket';

  /// en: 'Are you sure you want to delete the {name: String} bucket?'
  String deleteConfirm({required String name}) =>
      'Are you sure you want to delete the ${name} bucket?';

  /// en: 'R/W'
  String get readWriteBadge => 'R/W';

  /// en: 'You have read and write access to this bucket'
  String get readWriteTooltip =>
      'You have read and write access to this bucket';

  /// en: 'Created {date: String}'
  String createdAt({required String date}) => 'Created ${date}';

  /// en: 'Configure high-performance object storage parameters, redundancy, and protection policies.'
  String get createDescription =>
      'Configure high-performance object storage parameters, redundancy, and protection policies.';

  /// en: '01 General Configuration'
  String get createSectionGeneral => '01 General Configuration';

  /// en: '02 Additional Info'
  String get createSectionAdditional => '02 Additional Info';

  /// en: 'Bucket Identifier'
  String get createNameLabel => 'Bucket Identifier';

  /// en: 'my-bucket-name'
  String get createNameHint => 'my-bucket-name';

  /// en: 'Description (Optional)'
  String get createDescriptionLabel => 'Description (Optional)';

  /// en: 'Brief description of the bucket usage'
  String get createDescriptionHint => 'Brief description of the bucket usage';

  /// en: 'Bucket name is required'
  String get nameRequired => 'Bucket name is required';

  /// en: 'Between 3 and 63 characters'
  String get nameLength => 'Between 3 and 63 characters';

  /// en: 'Lowercase, numbers and hyphens only'
  String get nameChars => 'Lowercase, numbers and hyphens only';

  /// en: 'Cannot start or end with a hyphen'
  String get nameHyphenEdges => 'Cannot start or end with a hyphen';

  /// en: 'Lowercase, numbers and hyphens only'
  String get ruleChars => 'Lowercase, numbers and hyphens only';

  /// en: 'No hyphen at start/end'
  String get ruleHyphenEdges => 'No hyphen at start/end';

  /// en: 'Color'
  String get createColorLabel => 'Color';

  /// en: 'A bucket with this name already exists'
  String get nameExists => 'A bucket with this name already exists';

  /// en: 'Couldn't create the bucket'
  String get createErrorTitle => 'Couldn\'t create the bucket';

  /// en: 'Change the description and color of the {name: String} bucket. The name can't be changed.'
  String editDescription({required String name}) =>
      'Change the description and color of the ${name} bucket. The name can\'t be changed.';

  /// en: 'Save changes'
  String get editSave => 'Save changes';

  /// en: 'Couldn't save the bucket'
  String get editErrorTitle => 'Couldn\'t save the bucket';

  /// en: 'Bucket "{name: String}" updated'
  String updatedSuccess({required String name}) => 'Bucket "${name}" updated';

  /// en: 'Bucket "{name: String}" created'
  String createdSuccess({required String name}) => 'Bucket "${name}" created';

  /// en: 'Used in S3 paths: /{name: String}'
  String namePathHint({required String name}) => 'Used in S3 paths: /${name}';

  /// en: 'Settings'
  String get settings => 'Settings';
}

// Path: objects
class AppMessages$objects$en {
  AppMessages$objects$en._(this._root);

  final AppMessages _root; // ignore: unused_field

  // Translations

  /// en: 'Search objects...'
  String get searchHint => 'Search objects...';

  /// en: 'No objects found'
  String get empty => 'No objects found';

  /// en: 'No objects match the filters'
  String get noMatchFilter => 'No objects match the filters';

  /// en: 'Filters'
  String get filtersTitle => 'Filters';

  /// en: 'Clear'
  String get filtersClear => 'Clear';

  /// en: 'Type'
  String get filterType => 'Type';

  /// en: 'Other'
  String get filterTypeOther => 'Other';

  /// en: 'Size'
  String get filterSize => 'Size';

  /// en: 'Under 1 MB'
  String get filterSizeSmall => 'Under 1 MB';

  /// en: '1 MB – 100 MB'
  String get filterSizeMedium => '1 MB – 100 MB';

  /// en: 'Over 100 MB'
  String get filterSizeLarge => 'Over 100 MB';

  /// en: 'Modified'
  String get filterModified => 'Modified';

  /// en: 'Last 24 hours'
  String get filterDate24h => 'Last 24 hours';

  /// en: 'Last 7 days'
  String get filterDate7d => 'Last 7 days';

  /// en: 'Last 30 days'
  String get filterDate30d => 'Last 30 days';

  /// en: 'Older than 30 days'
  String get filterDateOlder => 'Older than 30 days';

  /// en: 'Folders are hidden while a filter is active.'
  String get filterFoldersHidden =>
      'Folders are hidden while a filter is active.';

  /// en: 'No objects matching "{query: String}"'
  String noMatch({required String query}) => 'No objects matching "${query}"';

  /// en: 'Drag files here to upload'
  String get dragHint => 'Drag files here to upload';

  /// en: 'Drop here to upload'
  String get dropHere => 'Drop here to upload';

  /// en: 'Delete objects'
  String get deleteTitle => 'Delete objects';

  /// en: '(one) {Are you sure you want to delete 1 object?} (other) {Are you sure you want to delete {count: int} objects?}'
  String deleteConfirm({required int count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: 'Are you sure you want to delete 1 object?',
        other: 'Are you sure you want to delete ${count} objects?',
      );

  /// en: 'Upload files'
  String get uploadFiles => 'Upload files';

  /// en: 'Upload directory'
  String get uploadDirectory => 'Upload directory';

  /// en: 'Folder'
  String get fileTypeFolder => 'Folder';

  /// en: 'File'
  String get fileTypeFile => 'File';

  /// en: 'Image'
  String get fileTypeImage => 'Image';

  /// en: 'Video'
  String get fileTypeVideo => 'Video';

  /// en: 'Audio'
  String get fileTypeAudio => 'Audio';

  /// en: 'Text'
  String get fileTypeText => 'Text';

  /// en: 'Document'
  String get fileTypeDocument => 'Document';

  /// en: 'Spreadsheet'
  String get fileTypeSpreadsheet => 'Spreadsheet';

  /// en: 'Archive'
  String get fileTypeArchive => 'Archive';

  /// en: 'New folder'
  String get newFolder => 'New folder';

  /// en: 'Create folder'
  String get newFolderCreate => 'Create folder';

  /// en: 'Folder name'
  String get folderNameLabel => 'Folder name';

  /// en: 'invoices-2026'
  String get folderNameHint => 'invoices-2026';

  /// en: 'It will be created in {path: String}'
  String folderPathHelper({required String path}) =>
      'It will be created in ${path}';

  /// en: 'Folder "{name: String}" created'
  String folderCreated({required String name}) => 'Folder "${name}" created';

  /// en: 'There's already a folder or object with that name here.'
  String get folderExists =>
      'There\'s already a folder or object with that name here.';

  /// en: 'Rename'
  String get rename => 'Rename';

  /// en: 'New name'
  String get renameLabel => 'New name';

  /// en: 'It stays at {path: String}'
  String renamePathHelper({required String path}) => 'It stays at ${path}';

  /// en: 'Renamed to "{name: String}"'
  String renamed({required String name}) => 'Renamed to "${name}"';

  /// en: 'There's already an object or folder with that name in this folder.'
  String get nameExists =>
      'There\'s already an object or folder with that name in this folder.';

  /// en: 'The name is required'
  String get nameRequired => 'The name is required';

  /// en: 'Don't use / \ or any of < > : " | ? *'
  String get nameInvalid => 'Don\'t use / \ or any of < > : " | ? *';

  /// en: 'It's the current name'
  String get nameUnchanged => 'It\'s the current name';

  /// en: 'The action couldn't be completed'
  String get actionErrorTitle => 'The action couldn\'t be completed';

  /// en: 'Details'
  String get details => 'Details';

  /// en: 'Move'
  String get move => 'Move';

  /// en: 'Move selection'
  String get moveSelection => 'Move selection';

  /// en: '(one) {Move 1 object} (other) {Move {count: int} objects}'
  String moveTitle({required int count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: 'Move 1 object',
        other: 'Move ${count} objects',
      );

  /// en: 'Target bucket'
  String get moveBucket => 'Target bucket';

  /// en: 'Target folder'
  String get moveFolder => 'Target folder';

  /// en: 'No subfolders'
  String get moveNoFolders => 'No subfolders';

  /// en: 'Move here'
  String get moveHere => 'Move here';

  /// en: 'They'll be moved to {path: String}. Objects with the same name there are replaced.'
  String moveHelper({required String path}) =>
      'They\'ll be moved to ${path}. Objects with the same name there are replaced.';

  /// en: 'They're already in this folder. Choose another one.'
  String get moveSameFolder =>
      'They\'re already in this folder. Choose another one.';

  /// en: '(one) {1 object moved} (other) {{count: int} objects moved}'
  String moved({required int count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: '1 object moved',
        other: '${count} objects moved',
      );

  /// en: 'Only {moved: int} of {total: int} objects were moved.'
  String movePartial({required int moved, required int total}) =>
      'Only ${moved} of ${total} objects were moved.';

  /// en: '{type: String} · {size: String}'
  String detailsSubtitle({required String type, required String size}) =>
      '${type} · ${size}';

  /// en: 'Key'
  String get detailsKey => 'Key';

  /// en: 'Type'
  String get detailsType => 'Type';

  /// en: 'Size'
  String get detailsSize => 'Size';

  /// en: '({bytes: int} bytes)'
  String detailsSizeBytes({required int bytes}) => '(${bytes} bytes)';

  /// en: 'Modified'
  String get detailsModified => 'Modified';

  /// en: 'URL'
  String get detailsUrl => 'URL';

  /// en: 'Copy URL'
  String get detailsCopyUrl => 'Copy URL';

  /// en: 'URL copied'
  String get detailsUrlCopied => 'URL copied';

  /// en: 'Rows per page:'
  String get pageSize => 'Rows per page:';

  /// en: 'Page {page: int} of {total: int}'
  String pageOf({required int page, required int total}) =>
      'Page ${page} of ${total}';

  /// en: 'Previous page'
  String get previousPage => 'Previous page';

  /// en: 'Next page'
  String get nextPage => 'Next page';

  /// en: 'Search and filters only apply to the pages already loaded.'
  String get pagerHint =>
      'Search and filters only apply to the pages already loaded.';

  /// en: 'Search and filters only apply to the pages already loaded ({loaded: int} of {total: int}).'
  String pagerHintPages({required int loaded, required int total}) =>
      'Search and filters only apply to the pages already loaded (${loaded} of ${total}).';

  /// en: 'Share link'
  String get shareLink => 'Share link';

  /// en: 'Anyone with the link can download {name: String} until it expires, without signing in.'
  String shareLinkDescription({required String name}) =>
      'Anyone with the link can download ${name} until it expires, without signing in.';

  /// en: 'Expires in'
  String get shareLinkExpiresIn => 'Expires in';

  /// en: '1 hour'
  String get shareLinkHour => '1 hour';

  /// en: '1 day'
  String get shareLinkDay => '1 day';

  /// en: '7 days'
  String get shareLinkWeek => '7 days';

  /// en: 'Valid until {date: String}'
  String shareLinkValidUntil({required String date}) => 'Valid until ${date}';

  /// en: 'Copy link'
  String get shareLinkCopy => 'Copy link';

  /// en: 'Link copied'
  String get shareLinkCopied => 'Link copied';
}

// Path: colors
class AppMessages$colors$en {
  AppMessages$colors$en._(this._root);

  final AppMessages _root; // ignore: unused_field

  // Translations

  /// en: 'No color'
  String get none => 'No color';

  /// en: 'Custom color'
  String get custom => 'Custom color';

  /// en: 'Apply'
  String get apply => 'Apply';

  /// en: 'Saturation and brightness'
  String get saturationBrightness => 'Saturation and brightness';

  /// en: 'Hue'
  String get hue => 'Hue';

  /// en: 'Icon contrast: {ratio: String}:1'
  String contrast({required String ratio}) => 'Icon contrast: ${ratio}:1';

  /// en: 'Low contrast with the icon ({ratio: String}:1)'
  String contrastLow({required String ratio}) =>
      'Low contrast with the icon (${ratio}:1)';

  /// en: 'Enter a 6-digit HEX color, for example #0E7490'
  String get hexInvalid => 'Enter a 6-digit HEX color, for example #0E7490';

  /// en: 'Violet'
  String get violet => 'Violet';

  /// en: 'Blue'
  String get blue => 'Blue';

  /// en: 'Teal'
  String get teal => 'Teal';

  /// en: 'Green'
  String get green => 'Green';

  /// en: 'Amber'
  String get amber => 'Amber';

  /// en: 'Red'
  String get red => 'Red';

  /// en: 'Pink'
  String get pink => 'Pink';

  /// en: 'Slate'
  String get slate => 'Slate';
}

// Path: bucketAdmin
class AppMessages$bucketAdmin$en {
  AppMessages$bucketAdmin$en._(this._root);

  final AppMessages _root; // ignore: unused_field

  // Translations

  /// en: '(one) {1 bucket} (other) {{count: int} buckets}'
  String count({required int count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: '1 bucket',
        other: '${count} buckets',
      );

  /// en: '(one) {1 object · {size: String}} (other) {{count: int} objects · {size: String}}'
  String stats({required int count, required String size}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: '1 object · ${size}',
        other: '${count} objects · ${size}',
      );

  /// en: 'Create a bucket to configure it here.'
  String get noBucketsDescription => 'Create a bucket to configure it here.';

  /// en: 'Open in browser'
  String get openInBrowser => 'Open in browser';

  /// en: 'General'
  String get tabGeneral => 'General';

  /// en: 'Anonymous access'
  String get tabAccess => 'Anonymous access';

  /// en: 'Danger zone'
  String get tabDanger => 'Danger zone';

  /// en: 'Objects'
  String get detailObjects => 'Objects';

  /// en: 'Size'
  String get detailSize => 'Size';

  /// en: 'Created'
  String get detailCreated => 'Created';

  /// en: 'Last modified'
  String get detailLastModified => 'Last modified';

  /// en: 'No objects'
  String get detailNeverModified => 'No objects';

  /// en: 'Name'
  String get detailName => 'Name';

  /// en: 'S3 path'
  String get detailS3Path => 'S3 path';

  /// en: 'Copy path'
  String get detailCopyPath => 'Copy path';

  /// en: 'Path copied'
  String get detailPathCopied => 'Path copied';

  /// en: 'Description'
  String get detailDescription => 'Description';

  /// en: 'No description'
  String get detailNoDescription => 'No description';

  /// en: 'Color'
  String get detailColor => 'Color';

  /// en: 'Empty bucket'
  String get emptyTitle => 'Empty bucket';

  /// en: 'The bucket has no objects.'
  String get emptyAlreadyEmpty => 'The bucket has no objects.';

  /// en: '(one) {Deletes its only object ({size: String}). The bucket, its settings and its access rules are kept. This can't be undone.} (other) {Deletes its {count: int} objects ({size: String}). The bucket, its settings and its access rules are kept. This can't be undone.}'
  String emptyDescription({
    required int count,
    required String size,
  }) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
    count,
    one:
        'Deletes its only object (${size}). The bucket, its settings and its access rules are kept. This can\'t be undone.',
    other:
        'Deletes its ${count} objects (${size}). The bucket, its settings and its access rules are kept. This can\'t be undone.',
  );

  /// en: '(one) {1 object ({size: String}) will be deleted from {name: String}. This can't be undone.} (other) {{count: int} objects ({size: String}) will be deleted from {name: String}. This can't be undone.}'
  String emptyConfirm({
    required int count,
    required String size,
    required String name,
  }) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
    count,
    one:
        '1 object (${size}) will be deleted from ${name}. This can\'t be undone.',
    other:
        '${count} objects (${size}) will be deleted from ${name}. This can\'t be undone.',
  );

  /// en: 'Type {name: String} to confirm'
  String emptyTypeName({required String name}) => 'Type ${name} to confirm';

  /// en: 'The button turns on when the name matches.'
  String get emptyTypeNameHelper =>
      'The button turns on when the name matches.';

  /// en: 'Deletes the bucket with its description, color and access rules. As in S3, only an empty bucket can be deleted.'
  String get deleteDescription =>
      'Deletes the bucket with its description, color and access rules. As in S3, only an empty bucket can be deleted.';

  /// en: '(one) {The bucket has 1 object. Empty it first.} (other) {The bucket has {count: int} objects. Empty it first.}'
  String deleteNotEmpty({required int count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: 'The bucket has 1 object. Empty it first.',
        other: 'The bucket has ${count} objects. Empty it first.',
      );
}

// Path: anonymousAccess
class AppMessages$anonymousAccess$en {
  AppMessages$anonymousAccess$en._(this._root);

  final AppMessages _root; // ignore: unused_field

  // Translations

  /// en: 'Each rule makes a prefix reachable without credentials. Anything no rule covers still needs authentication.'
  String get description =>
      'Each rule makes a prefix reachable without credentials. Anything no rule covers still needs authentication.';

  /// en: 'Private bucket'
  String get privateTitle => 'Private bucket';

  /// en: 'Every request needs credentials. Add a rule to serve a prefix without authentication, for example a website's images.'
  String get privateDescription =>
      'Every request needs credentials. Add a rule to serve a prefix without authentication, for example a website\'s images.';

  /// en: 'Read only'
  String get readOnly => 'Read only';

  /// en: 'Write only'
  String get writeOnly => 'Write only';

  /// en: 'Read and write'
  String get readWrite => 'Read and write';

  /// en: 'List and download objects'
  String get readOnlyOps => 'List and download objects';

  /// en: 'Upload and delete objects'
  String get writeOnlyOps => 'Upload and delete objects';

  /// en: 'List, download, upload and delete'
  String get readWriteOps => 'List, download, upload and delete';

  /// en: 'Anyone can list and download.'
  String get readOnlyDescription => 'Anyone can list and download.';

  /// en: 'Anyone can upload and delete, but not see.'
  String get writeOnlyDescription =>
      'Anyone can upload and delete, but not see.';

  /// en: 'Full access without credentials.'
  String get readWriteDescription => 'Full access without credentials.';

  /// en: 'Websites, catalogs, public downloads.'
  String get readOnlyUseCase => 'Websites, catalogs, public downloads.';

  /// en: 'Upload inboxes, forms.'
  String get writeOnlyUseCase => 'Upload inboxes, forms.';

  /// en: 'Use it only on temporary prefixes.'
  String get readWriteUseCase => 'Use it only on temporary prefixes.';

  /// en: 'Add rule'
  String get ruleAdd => 'Add rule';

  /// en: 'Prefix'
  String get rulePrefix => 'Prefix';

  /// en: 'Access'
  String get ruleAccess => 'Access';

  /// en: 'Allowed without credentials'
  String get ruleOps => 'Allowed without credentials';

  /// en: 'Prefixes are relative to the bucket and accept * as a wildcard. When several rules match, the first one applies.'
  String get ruleHint =>
      'Prefixes are relative to the bucket and accept * as a wildcard. When several rules match, the first one applies.';

  /// en: 'Delete rule'
  String get ruleDeleteTitle => 'Delete rule';

  /// en: 'Delete the rule {prefix: String}? Objects under that prefix will need credentials again.'
  String ruleDeleteConfirm({required String prefix}) =>
      'Delete the rule ${prefix}? Objects under that prefix will need credentials again.';

  /// en: 'Add access rule'
  String get ruleFormTitle => 'Add access rule';

  /// en: 'Make a prefix of {bucket: String} reachable without credentials.'
  String ruleFormDescription({required String bucket}) =>
      'Make a prefix of ${bucket} reachable without credentials.';

  /// en: '01 Prefix'
  String get ruleFormSectionPrefix => '01 Prefix';

  /// en: '02 Access type'
  String get ruleFormSectionAccess => '02 Access type';

  /// en: 'Prefix or pattern'
  String get rulePrefixLabel => 'Prefix or pattern';

  /// en: 'public/'
  String get rulePrefixHint => 'public/';

  /// en: 'Without *, it covers everything that starts with it (end it with / for a folder). With *, the whole key must match (for example, *.jpg covers only .jpg files), and it only opens listings if it ends in *.'
  String get rulePrefixHelper =>
      'Without *, it covers everything that starts with it (end it with / for a folder). With *, the whole key must match (for example, *.jpg covers only .jpg files), and it only opens listings if it ends in *.';

  /// en: 'The prefix is required'
  String get rulePrefixRequired => 'The prefix is required';

  /// en: 'Couldn't add the rule'
  String get ruleFormErrorTitle => 'Couldn\'t add the rule';

  /// en: 'Rule {prefix: String} added'
  String ruleCreatedSuccess({required String prefix}) => 'Rule ${prefix} added';
}

// Path: browser
class AppMessages$browser$en {
  AppMessages$browser$en._(this._root);

  final AppMessages _root; // ignore: unused_field

  // Translations

  /// en: 'Bucket "{name: String}" doesn't exist'
  String bucketNotFound({required String name}) =>
      'Bucket "${name}" doesn\'t exist';

  /// en: 'It may have been deleted, or the link is misspelled.'
  String get bucketNotFoundDescription =>
      'It may have been deleted, or the link is misspelled.';

  /// en: 'View buckets'
  String get backToBuckets => 'View buckets';

  /// en: 'Folder "{folder: String}" doesn't exist in this bucket'
  String folderNotFound({required String folder}) =>
      'Folder "${folder}" doesn\'t exist in this bucket';

  /// en: 'It may have been deleted, or the path is misspelled. In S3 a folder only exists while it has objects.'
  String get folderNotFoundDescription =>
      'It may have been deleted, or the path is misspelled. In S3 a folder only exists while it has objects.';

  /// en: 'Go to the bucket root'
  String get goToBucketRoot => 'Go to the bucket root';
}

// Path: transfers
class AppMessages$transfers$en {
  AppMessages$transfers$en._(this._root);

  final AppMessages _root; // ignore: unused_field

  // Translations

  /// en: 'Transfers'
  String get title => 'Transfers';

  /// en: '(one) {1 transfer in progress} (other) {{count: int} transfers in progress}'
  String active({required int count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: '1 transfer in progress',
        other: '${count} transfers in progress',
      );

  /// en: '(one) {1 transfer failed} (other) {{count: int} transfers failed}'
  String failed({required int count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: '1 transfer failed',
        other: '${count} transfers failed',
      );

  /// en: 'All transfers finished'
  String get allDone => 'All transfers finished';

  /// en: 'No transfers yet. Uploads and downloads keep going in the background while you use the console.'
  String get empty =>
      'No transfers yet. Uploads and downloads keep going in the background while you use the console.';

  /// en: '(one) {1 file added to transfers} (other) {{count: int} files added to transfers}'
  String uploadsAdded({required int count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: '1 file added to transfers',
        other: '${count} files added to transfers',
      );

  /// en: 'Downloading {name: String} in the background'
  String downloadAdded({required String name}) =>
      'Downloading ${name} in the background';

  /// en: 'Clear finished'
  String get clearFinished => 'Clear finished';

  /// en: 'Upload'
  String get upload => 'Upload';

  /// en: 'Download'
  String get download => 'Download';

  /// en: 'Queued'
  String get statusQueued => 'Queued';

  /// en: 'Preparing the zip…'
  String get statusPreparing => 'Preparing the zip…';

  /// en: '{done: String} of {total: String} · {percent: int}%'
  String statusProgress({
    required String done,
    required String total,
    required int percent,
  }) => '${done} of ${total} · ${percent}%';

  /// en: 'Uploaded · {size: String}'
  String statusUploaded({required String size}) => 'Uploaded · ${size}';

  /// en: 'Downloaded · {size: String}'
  String statusDownloaded({required String size}) => 'Downloaded · ${size}';

  /// en: 'Error: {message: String}'
  String statusFailed({required String message}) => 'Error: ${message}';

  /// en: 'Cancelled'
  String get statusCancelled => 'Cancelled';

  /// en: 'Cancel'
  String get cancel => 'Cancel';

  /// en: 'Remove from list'
  String get remove => 'Remove from list';
}

// Path: accessKeys
class AppMessages$accessKeys$en {
  AppMessages$accessKeys$en._(this._root);

  final AppMessages _root; // ignore: unused_field

  // Translations

  /// en: 'Each key lets an S3 client (AWS CLI, rclone, SDKs) in, only to the buckets you give it.'
  String get description =>
      'Each key lets an S3 client (AWS CLI, rclone, SDKs) in, only to the buckets you give it.';

  /// en: 'The secret is shown only once, when the key is created or its secret is regenerated.'
  String get secretOnce =>
      'The secret is shown only once, when the key is created or its secret is regenerated.';

  /// en: 'Search by name or ID...'
  String get searchHint => 'Search by name or ID...';

  /// en: 'Create key'
  String get create => 'Create key';

  /// en: 'Name'
  String get columnName => 'Name';

  /// en: 'Access key ID'
  String get columnId => 'Access key ID';

  /// en: 'Permissions'
  String get columnPermissions => 'Permissions';

  /// en: 'Last used'
  String get columnLastUsed => 'Last used';

  /// en: 'Status'
  String get columnStatus => 'Status';

  /// en: 'Root key'
  String get rootName => 'Root key';

  /// en: 'Root'
  String get rootBadge => 'Root';

  /// en: 'Everything, including the console'
  String get rootPermissions => 'Everything, including the console';

  /// en: 'Set with FEATHER_ACCESS and FEATHER_SECRET: it can't be edited or deleted'
  String get rootLocked =>
      'Set with FEATHER_ACCESS and FEATHER_SECRET: it can\'t be edited or deleted';

  /// en: 'Created {date: String}'
  String createdOn({required String date}) => 'Created ${date}';

  /// en: 'Copy ID'
  String get copyId => 'Copy ID';

  /// en: 'ID copied'
  String get idCopied => 'ID copied';

  /// en: 'All'
  String get allBuckets => 'All';

  /// en: 'No buckets: edit it to give it access'
  String get noBuckets => 'No buckets: edit it to give it access';

  /// en: '+ create buckets'
  String get createsBuckets => '+ create buckets';

  /// en: 'Read only'
  String get levelReadOnly => 'Read only';

  /// en: 'Write only'
  String get levelWriteOnly => 'Write only';

  /// en: 'Read and write'
  String get levelReadWrite => 'Read and write';

  /// en: 'Read'
  String get levelShortRead => 'Read';

  /// en: 'Write'
  String get levelShortWrite => 'Write';

  /// en: 'Both'
  String get levelShortBoth => 'Both';

  /// en: 'List and download objects.'
  String get levelReadOnlyDescription => 'List and download objects.';

  /// en: 'Upload and delete objects, without seeing them.'
  String get levelWriteOnlyDescription =>
      'Upload and delete objects, without seeing them.';

  /// en: 'List, download, upload and delete objects.'
  String get levelReadWriteDescription =>
      'List, download, upload and delete objects.';

  /// en: 'Active'
  String get statusActive => 'Active';

  /// en: 'Disabled'
  String get statusDisabled => 'Disabled';

  /// en: 'Expired'
  String get statusExpired => 'Expired';

  /// en: 'Expires {date: String}'
  String expiresOn({required String date}) => 'Expires ${date}';

  /// en: 'Expired {date: String}'
  String expiredOn({required String date}) => 'Expired ${date}';

  /// en: 'Never'
  String get neverUsed => 'Never';

  /// en: 'Just now'
  String get usedNow => 'Just now';

  /// en: '{count: int} min ago'
  String usedMinutes({required int count}) => '${count} min ago';

  /// en: '{count: int} h ago'
  String usedHours({required int count}) => '${count} h ago';

  /// en: '(one) {1 day ago} (other) {{count: int} days ago}'
  String usedDays({required int count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        count,
        one: '1 day ago',
        other: '${count} days ago',
      );

  /// en: 'Actions of {name: String}'
  String actions({required String name}) => 'Actions of ${name}';

  /// en: 'Edit permissions'
  String get editPermissions => 'Edit permissions';

  /// en: 'Regenerate secret'
  String get regenerateSecret => 'Regenerate secret';

  /// en: 'Disable'
  String get disable => 'Disable';

  /// en: 'Enable'
  String get enable => 'Enable';

  /// en: 'Keys are only for S3 clients: the console opens with the root key. A disabled or expired key gets 403 InvalidAccessKeyId.'
  String get footerHint =>
      'Keys are only for S3 clients: the console opens with the root key. A disabled or expired key gets 403 InvalidAccessKeyId.';

  /// en: 'Only the root key exists'
  String get emptyTitle => 'Only the root key exists';

  /// en: 'Create a key for each client or application, with access to its own buckets only. You can then revoke it without touching the others.'
  String get emptyDescription =>
      'Create a key for each client or application, with access to its own buckets only. You can then revoke it without touching the others.';

  /// en: 'Create the first key'
  String get createFirst => 'Create the first key';

  /// en: 'No key matches the search or the filters'
  String get noMatch => 'No key matches the search or the filters';

  /// en: 'Status'
  String get filterStatus => 'Status';

  /// en: 'Level'
  String get filterLevel => 'Level';

  /// en: 'Bucket'
  String get filterBucket => 'Bucket';

  /// en: 'Delete key'
  String get deleteTitle => 'Delete key';

  /// en: 'Delete the key {name: String}? Clients using it will get 403 right away. To pause it, disable it instead.'
  String deleteConfirm({required String name}) =>
      'Delete the key ${name}? Clients using it will get 403 right away. To pause it, disable it instead.';

  /// en: 'Regenerate secret'
  String get regenerateTitle => 'Regenerate secret';

  /// en: 'Generate a new secret for {name: String}? The current one stops working right away.'
  String regenerateConfirm({required String name}) =>
      'Generate a new secret for ${name}? The current one stops working right away.';

  /// en: 'Regenerate'
  String get regenerate => 'Regenerate';

  /// en: 'Key {name: String} deleted'
  String deletedSuccess({required String name}) => 'Key ${name} deleted';

  /// en: 'Key {name: String} disabled'
  String disabledSuccess({required String name}) => 'Key ${name} disabled';

  /// en: 'Key {name: String} enabled'
  String enabledSuccess({required String name}) => 'Key ${name} enabled';

  /// en: 'Key {name: String} saved'
  String savedSuccess({required String name}) => 'Key ${name} saved';

  /// en: 'Create access key'
  String get formCreateTitle => 'Create access key';

  /// en: 'Edit access key'
  String get formEditTitle => 'Edit access key';

  /// en: 'The ID and the secret are generated when it is created.'
  String get formCreateDescription =>
      'The ID and the secret are generated when it is created.';

  /// en: '{id: String}. The secret doesn't change.'
  String formEditDescription({required String id}) =>
      '${id}. The secret doesn\'t change.';

  /// en: '01 Identification'
  String get formSectionIdentity => '01 Identification';

  /// en: '02 Scope'
  String get formSectionScope => '02 Scope';

  /// en: '03 Permissions'
  String get formSectionPermissions => '03 Permissions';

  /// en: 'Name'
  String get nameLabel => 'Name';

  /// en: 'Backups NAS'
  String get nameHint => 'Backups NAS';

  /// en: 'Give the key a name'
  String get nameRequired => 'Give the key a name';

  /// en: 'Expiration'
  String get expiryLabel => 'Expiration';

  /// en: 'Never expires'
  String get expiryNever => 'Never expires';

  /// en: 'In 30 days'
  String get expiry30Days => 'In 30 days';

  /// en: 'In 90 days'
  String get expiry90Days => 'In 90 days';

  /// en: 'In 1 year'
  String get expiryYear => 'In 1 year';

  /// en: 'Keep: {date: String}'
  String expiryKeep({required String date}) => 'Keep: ${date}';

  /// en: 'All buckets'
  String get scopeAll => 'All buckets';

  /// en: 'Also the ones created later. With write access it can also create and delete buckets.'
  String get scopeAllDescription =>
      'Also the ones created later. With write access it can also create and delete buckets.';

  /// en: 'Specific buckets'
  String get scopeSome => 'Specific buckets';

  /// en: 'Only the ones you check, each with its level. It only sees those when listing.'
  String get scopeSomeDescription =>
      'Only the ones you check, each with its level. It only sees those when listing.';

  /// en: '{count: int} of {total: int} checked'
  String bucketsChecked({required int count, required int total}) =>
      '${count} of ${total} checked';

  /// en: 'Check at least one bucket'
  String get bucketsRequired => 'Check at least one bucket';

  /// en: 'There are no buckets yet: create one, or give the key every bucket.'
  String get bucketsEmpty =>
      'There are no buckets yet: create one, or give the key every bucket.';

  /// en: 'The key couldn't be saved'
  String get formErrorTitle => 'The key couldn\'t be saved';

  /// en: 'Key created: {name: String}'
  String secretCreatedTitle({required String name}) => 'Key created: ${name}';

  /// en: 'New secret: {name: String}'
  String secretRegeneratedTitle({required String name}) =>
      'New secret: ${name}';

  /// en: 'Copy the secret now: this is the only time it is shown. If you lose it, you'll have to regenerate it.'
  String get secretWarning =>
      'Copy the secret now: this is the only time it is shown. If you lose it, you\'ll have to regenerate it.';

  /// en: 'Secret access key'
  String get secretLabel => 'Secret access key';

  /// en: 'Copy secret'
  String get copySecret => 'Copy secret';

  /// en: 'Secret copied'
  String get secretCopied => 'Secret copied';

  /// en: 'Download as .csv'
  String get downloadCsv => 'Download as .csv';

  /// en: 'I've saved the secret somewhere safe'
  String get secretSaved => 'I\'ve saved the secret somewhere safe';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on AppMessages {
  dynamic _flatMapFunction(String path) {
    return switch (path) {
      'app.name' => 'Feather IO',
      'app.needMoreSpace' => 'Need more space',
      'app.splashText' => 'Connecting to the storage service…',
      'app.credit' => 'With ♥ from Root101',
      'common.loading' => 'Loading',
      'common.error' => 'Error',
      'common.tryAgain' => 'Try again',
      'common.noData' => 'No data',
      'common.cancel' => 'Cancel',
      'common.close' => 'Close',
      'common.delete' => 'Delete',
      'common.edit' => 'Edit',
      'common.refresh' => 'Refresh',
      'common.required' => 'Required',
      'common.preview' => 'Preview',
      'common.download' => 'Download',
      'common.upload' => 'Upload',
      'common.filter' => 'Filter',
      'common.name' => 'Name',
      'common.type' => 'Type',
      'common.size' => 'Size',
      'common.objects' => 'Objects',
      'common.createdAt' => 'Created At',
      'common.lastModified' => 'Last Modified',
      'errors.requestCancelled' => 'Request to API server was cancelled',
      'errors.connectionTimeout' =>
        'Connection timeout with API server. Check your internet connection',
      'errors.noConnection' =>
        'Connection to API server failed due to internet connection',
      'errors.receiveTimeout' =>
        'Receive timeout in connection with API server',
      'errors.sendTimeout' => 'Send timeout with API server',
      'errors.badCertificate' => 'Bad certificate',
      'errors.connection' => 'Connection error',
      'errors.validation' => 'Validation error',
      'errors.server' => 'Server error',
      'errors.unknown' => 'Unknown error',
      'nav.browser' => 'Browser',
      'nav.buckets' => 'Buckets',
      'nav.language' => ({required String name}) => 'Language: ${name}',
      'nav.logout' => 'Log out',
      'nav.accessKeys' => 'Access keys',
      'login.accessKey' => 'Access Key',
      'login.accessKeyHint' => 'Enter your access key',
      'login.secretKey' => 'Secret Key',
      'login.secretKeyHint' => 'Enter your secret key',
      'login.button' => 'Login',
      'login.title' => 'Sign in',
      'login.description' => 'Manage your buckets and access keys.',
      'login.envHint' => 'The keys are set on the server with:',
      'login.envHintAnd' => 'and',
      'login.tagline' => 'S3, without the weight.',
      'login.pitch' => 'No setup, no learning curve. Point your usual AWS tools here and start uploading.',
      'login.tags.0' => 'Self-hosted',
      'login.tags.1' => 'S3-compatible',
      'login.tags.2' => 'Lightweight',
      'login.tags.3' => 'Built in Dart',
      'buckets.title' => 'Buckets',
      'buckets.subtitle' =>
        'Manage your S3 compatible buckets and storage resources.',
      'buckets.create' => 'Create Bucket',
      'buckets.edit' => 'Edit Bucket',
      'buckets.totalBuckets' => 'Total Buckets',
      'buckets.totalObjects' => 'Total Objects',
      'buckets.totalStorage' => 'Total Storage',
      'buckets.searchHint' => 'Search buckets...',
      'buckets.empty' => 'No buckets found',
      'buckets.noMatch' => ({
        required String query,
      }) => 'No buckets matching "${query}"',
      'buckets.deleteTitle' => 'Delete bucket',
      'buckets.deleteConfirm' => ({
        required String name,
      }) => 'Are you sure you want to delete the ${name} bucket?',
      'buckets.readWriteBadge' => 'R/W',
      'buckets.readWriteTooltip' =>
        'You have read and write access to this bucket',
      'buckets.createdAt' => ({required String date}) => 'Created ${date}',
      'buckets.createDescription' => 'Configure high-performance object storage parameters, redundancy, and protection policies.',
      'buckets.createSectionGeneral' => '01 General Configuration',
      'buckets.createSectionAdditional' => '02 Additional Info',
      'buckets.createNameLabel' => 'Bucket Identifier',
      'buckets.createNameHint' => 'my-bucket-name',
      'buckets.createDescriptionLabel' => 'Description (Optional)',
      'buckets.createDescriptionHint' =>
        'Brief description of the bucket usage',
      'buckets.nameRequired' => 'Bucket name is required',
      'buckets.nameLength' => 'Between 3 and 63 characters',
      'buckets.nameChars' => 'Lowercase, numbers and hyphens only',
      'buckets.nameHyphenEdges' => 'Cannot start or end with a hyphen',
      'buckets.ruleChars' => 'Lowercase, numbers and hyphens only',
      'buckets.ruleHyphenEdges' => 'No hyphen at start/end',
      'buckets.createColorLabel' => 'Color',
      'buckets.nameExists' => 'A bucket with this name already exists',
      'buckets.createErrorTitle' => 'Couldn\'t create the bucket',
      'buckets.editDescription' => ({
        required String name,
      }) => 'Change the description and color of the ${name} bucket. The name can\'t be changed.',
      'buckets.editSave' => 'Save changes',
      'buckets.editErrorTitle' => 'Couldn\'t save the bucket',
      'buckets.updatedSuccess' => ({
        required String name,
      }) => 'Bucket "${name}" updated',
      'buckets.createdSuccess' => ({
        required String name,
      }) => 'Bucket "${name}" created',
      'buckets.namePathHint' => ({
        required String name,
      }) => 'Used in S3 paths: /${name}',
      'buckets.settings' => 'Settings',
      'objects.searchHint' => 'Search objects...',
      'objects.empty' => 'No objects found',
      'objects.noMatchFilter' => 'No objects match the filters',
      'objects.filtersTitle' => 'Filters',
      'objects.filtersClear' => 'Clear',
      'objects.filterType' => 'Type',
      'objects.filterTypeOther' => 'Other',
      'objects.filterSize' => 'Size',
      'objects.filterSizeSmall' => 'Under 1 MB',
      'objects.filterSizeMedium' => '1 MB – 100 MB',
      'objects.filterSizeLarge' => 'Over 100 MB',
      'objects.filterModified' => 'Modified',
      'objects.filterDate24h' => 'Last 24 hours',
      'objects.filterDate7d' => 'Last 7 days',
      'objects.filterDate30d' => 'Last 30 days',
      'objects.filterDateOlder' => 'Older than 30 days',
      'objects.filterFoldersHidden' =>
        'Folders are hidden while a filter is active.',
      'objects.noMatch' => ({
        required String query,
      }) => 'No objects matching "${query}"',
      'objects.dragHint' => 'Drag files here to upload',
      'objects.dropHere' => 'Drop here to upload',
      'objects.deleteTitle' => 'Delete objects',
      'objects.deleteConfirm' =>
        ({required int count}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
              count,
              one: 'Are you sure you want to delete 1 object?',
              other: 'Are you sure you want to delete ${count} objects?',
            ),
      'objects.uploadFiles' => 'Upload files',
      'objects.uploadDirectory' => 'Upload directory',
      'objects.fileTypeFolder' => 'Folder',
      'objects.fileTypeFile' => 'File',
      'objects.fileTypeImage' => 'Image',
      'objects.fileTypeVideo' => 'Video',
      'objects.fileTypeAudio' => 'Audio',
      'objects.fileTypeText' => 'Text',
      'objects.fileTypeDocument' => 'Document',
      'objects.fileTypeSpreadsheet' => 'Spreadsheet',
      'objects.fileTypeArchive' => 'Archive',
      'objects.newFolder' => 'New folder',
      'objects.newFolderCreate' => 'Create folder',
      'objects.folderNameLabel' => 'Folder name',
      'objects.folderNameHint' => 'invoices-2026',
      'objects.folderPathHelper' => ({
        required String path,
      }) => 'It will be created in ${path}',
      'objects.folderCreated' => ({
        required String name,
      }) => 'Folder "${name}" created',
      'objects.folderExists' =>
        'There\'s already a folder or object with that name here.',
      'objects.rename' => 'Rename',
      'objects.renameLabel' => 'New name',
      'objects.renamePathHelper' => ({
        required String path,
      }) => 'It stays at ${path}',
      'objects.renamed' => ({required String name}) => 'Renamed to "${name}"',
      'objects.nameExists' =>
        'There\'s already an object or folder with that name in this folder.',
      'objects.nameRequired' => 'The name is required',
      'objects.nameInvalid' => 'Don\'t use / \ or any of < > : " | ? *',
      'objects.nameUnchanged' => 'It\'s the current name',
      'objects.actionErrorTitle' => 'The action couldn\'t be completed',
      'objects.details' => 'Details',
      'objects.move' => 'Move',
      'objects.moveSelection' => 'Move selection',
      'objects.moveTitle' =>
        ({required int count}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
              count,
              one: 'Move 1 object',
              other: 'Move ${count} objects',
            ),
      'objects.moveBucket' => 'Target bucket',
      'objects.moveFolder' => 'Target folder',
      'objects.moveNoFolders' => 'No subfolders',
      'objects.moveHere' => 'Move here',
      'objects.moveHelper' => ({
        required String path,
      }) => 'They\'ll be moved to ${path}. Objects with the same name there are replaced.',
      'objects.moveSameFolder' =>
        'They\'re already in this folder. Choose another one.',
      'objects.moved' =>
        ({required int count}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
              count,
              one: '1 object moved',
              other: '${count} objects moved',
            ),
      'objects.movePartial' => ({
        required int moved,
        required int total,
      }) => 'Only ${moved} of ${total} objects were moved.',
      'objects.detailsSubtitle' => ({
        required String type,
        required String size,
      }) => '${type} · ${size}',
      'objects.detailsKey' => 'Key',
      'objects.detailsType' => 'Type',
      'objects.detailsSize' => 'Size',
      'objects.detailsSizeBytes' => ({
        required int bytes,
      }) => '(${bytes} bytes)',
      'objects.detailsModified' => 'Modified',
      'objects.detailsUrl' => 'URL',
      'objects.detailsCopyUrl' => 'Copy URL',
      'objects.detailsUrlCopied' => 'URL copied',
      'objects.pageSize' => 'Rows per page:',
      'objects.pageOf' => ({
        required int page,
        required int total,
      }) => 'Page ${page} of ${total}',
      'objects.previousPage' => 'Previous page',
      'objects.nextPage' => 'Next page',
      'objects.pagerHint' =>
        'Search and filters only apply to the pages already loaded.',
      'objects.pagerHintPages' => ({
        required int loaded,
        required int total,
      }) => 'Search and filters only apply to the pages already loaded (${loaded} of ${total}).',
      'objects.shareLink' => 'Share link',
      'objects.shareLinkDescription' => ({
        required String name,
      }) => 'Anyone with the link can download ${name} until it expires, without signing in.',
      'objects.shareLinkExpiresIn' => 'Expires in',
      'objects.shareLinkHour' => '1 hour',
      'objects.shareLinkDay' => '1 day',
      'objects.shareLinkWeek' => '7 days',
      'objects.shareLinkValidUntil' => ({
        required String date,
      }) => 'Valid until ${date}',
      'objects.shareLinkCopy' => 'Copy link',
      'objects.shareLinkCopied' => 'Link copied',
      'colors.none' => 'No color',
      'colors.custom' => 'Custom color',
      'colors.apply' => 'Apply',
      'colors.saturationBrightness' => 'Saturation and brightness',
      'colors.hue' => 'Hue',
      'colors.contrast' => ({
        required String ratio,
      }) => 'Icon contrast: ${ratio}:1',
      'colors.contrastLow' => ({
        required String ratio,
      }) => 'Low contrast with the icon (${ratio}:1)',
      'colors.hexInvalid' => 'Enter a 6-digit HEX color, for example #0E7490',
      'colors.violet' => 'Violet',
      'colors.blue' => 'Blue',
      'colors.teal' => 'Teal',
      'colors.green' => 'Green',
      'colors.amber' => 'Amber',
      'colors.red' => 'Red',
      'colors.pink' => 'Pink',
      'colors.slate' => 'Slate',
      'bucketAdmin.count' =>
        ({required int count}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
              count,
              one: '1 bucket',
              other: '${count} buckets',
            ),
      'bucketAdmin.stats' =>
        ({required int count, required String size}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
              count,
              one: '1 object · ${size}',
              other: '${count} objects · ${size}',
            ),
      'bucketAdmin.noBucketsDescription' =>
        'Create a bucket to configure it here.',
      'bucketAdmin.openInBrowser' => 'Open in browser',
      'bucketAdmin.tabGeneral' => 'General',
      'bucketAdmin.tabAccess' => 'Anonymous access',
      'bucketAdmin.tabDanger' => 'Danger zone',
      'bucketAdmin.detailObjects' => 'Objects',
      'bucketAdmin.detailSize' => 'Size',
      'bucketAdmin.detailCreated' => 'Created',
      'bucketAdmin.detailLastModified' => 'Last modified',
      'bucketAdmin.detailNeverModified' => 'No objects',
      'bucketAdmin.detailName' => 'Name',
      'bucketAdmin.detailS3Path' => 'S3 path',
      'bucketAdmin.detailCopyPath' => 'Copy path',
      'bucketAdmin.detailPathCopied' => 'Path copied',
      'bucketAdmin.detailDescription' => 'Description',
      'bucketAdmin.detailNoDescription' => 'No description',
      'bucketAdmin.detailColor' => 'Color',
      'bucketAdmin.emptyTitle' => 'Empty bucket',
      'bucketAdmin.emptyAlreadyEmpty' => 'The bucket has no objects.',
      'bucketAdmin.emptyDescription' =>
        ({
          required int count,
          required String size,
        }) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
          count,
          one:
              'Deletes its only object (${size}). The bucket, its settings and its access rules are kept. This can\'t be undone.',
          other:
              'Deletes its ${count} objects (${size}). The bucket, its settings and its access rules are kept. This can\'t be undone.',
        ),
      'bucketAdmin.emptyConfirm' =>
        ({
          required int count,
          required String size,
          required String name,
        }) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
          count,
          one:
              '1 object (${size}) will be deleted from ${name}. This can\'t be undone.',
          other:
              '${count} objects (${size}) will be deleted from ${name}. This can\'t be undone.',
        ),
      'bucketAdmin.emptyTypeName' => ({
        required String name,
      }) => 'Type ${name} to confirm',
      'bucketAdmin.emptyTypeNameHelper' =>
        'The button turns on when the name matches.',
      'bucketAdmin.deleteDescription' => 'Deletes the bucket with its description, color and access rules. As in S3, only an empty bucket can be deleted.',
      'bucketAdmin.deleteNotEmpty' =>
        ({required int count}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
              count,
              one: 'The bucket has 1 object. Empty it first.',
              other: 'The bucket has ${count} objects. Empty it first.',
            ),
      'anonymousAccess.description' => 'Each rule makes a prefix reachable without credentials. Anything no rule covers still needs authentication.',
      'anonymousAccess.privateTitle' => 'Private bucket',
      'anonymousAccess.privateDescription' => 'Every request needs credentials. Add a rule to serve a prefix without authentication, for example a website\'s images.',
      'anonymousAccess.readOnly' => 'Read only',
      'anonymousAccess.writeOnly' => 'Write only',
      'anonymousAccess.readWrite' => 'Read and write',
      'anonymousAccess.readOnlyOps' => 'List and download objects',
      'anonymousAccess.writeOnlyOps' => 'Upload and delete objects',
      'anonymousAccess.readWriteOps' => 'List, download, upload and delete',
      'anonymousAccess.readOnlyDescription' => 'Anyone can list and download.',
      'anonymousAccess.writeOnlyDescription' =>
        'Anyone can upload and delete, but not see.',
      'anonymousAccess.readWriteDescription' =>
        'Full access without credentials.',
      'anonymousAccess.readOnlyUseCase' =>
        'Websites, catalogs, public downloads.',
      'anonymousAccess.writeOnlyUseCase' => 'Upload inboxes, forms.',
      'anonymousAccess.readWriteUseCase' =>
        'Use it only on temporary prefixes.',
      'anonymousAccess.ruleAdd' => 'Add rule',
      'anonymousAccess.rulePrefix' => 'Prefix',
      'anonymousAccess.ruleAccess' => 'Access',
      'anonymousAccess.ruleOps' => 'Allowed without credentials',
      'anonymousAccess.ruleHint' => 'Prefixes are relative to the bucket and accept * as a wildcard. When several rules match, the first one applies.',
      'anonymousAccess.ruleDeleteTitle' => 'Delete rule',
      'anonymousAccess.ruleDeleteConfirm' => ({
        required String prefix,
      }) => 'Delete the rule ${prefix}? Objects under that prefix will need credentials again.',
      'anonymousAccess.ruleFormTitle' => 'Add access rule',
      'anonymousAccess.ruleFormDescription' => ({
        required String bucket,
      }) => 'Make a prefix of ${bucket} reachable without credentials.',
      'anonymousAccess.ruleFormSectionPrefix' => '01 Prefix',
      'anonymousAccess.ruleFormSectionAccess' => '02 Access type',
      'anonymousAccess.rulePrefixLabel' => 'Prefix or pattern',
      'anonymousAccess.rulePrefixHint' => 'public/',
      'anonymousAccess.rulePrefixHelper' => 'Without *, it covers everything that starts with it (end it with / for a folder). With *, the whole key must match (for example, *.jpg covers only .jpg files), and it only opens listings if it ends in *.',
      'anonymousAccess.rulePrefixRequired' => 'The prefix is required',
      'anonymousAccess.ruleFormErrorTitle' => 'Couldn\'t add the rule',
      'anonymousAccess.ruleCreatedSuccess' => ({
        required String prefix,
      }) => 'Rule ${prefix} added',
      'browser.bucketNotFound' => ({
        required String name,
      }) => 'Bucket "${name}" doesn\'t exist',
      'browser.bucketNotFoundDescription' =>
        'It may have been deleted, or the link is misspelled.',
      'browser.backToBuckets' => 'View buckets',
      'browser.folderNotFound' => ({
        required String folder,
      }) => 'Folder "${folder}" doesn\'t exist in this bucket',
      'browser.folderNotFoundDescription' => 'It may have been deleted, or the path is misspelled. In S3 a folder only exists while it has objects.',
      'browser.goToBucketRoot' => 'Go to the bucket root',
      'transfers.title' => 'Transfers',
      'transfers.active' =>
        ({required int count}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
              count,
              one: '1 transfer in progress',
              other: '${count} transfers in progress',
            ),
      'transfers.failed' =>
        ({required int count}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
              count,
              one: '1 transfer failed',
              other: '${count} transfers failed',
            ),
      'transfers.allDone' => 'All transfers finished',
      'transfers.empty' => 'No transfers yet. Uploads and downloads keep going in the background while you use the console.',
      'transfers.uploadsAdded' =>
        ({required int count}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
              count,
              one: '1 file added to transfers',
              other: '${count} files added to transfers',
            ),
      'transfers.downloadAdded' => ({
        required String name,
      }) => 'Downloading ${name} in the background',
      'transfers.clearFinished' => 'Clear finished',
      'transfers.upload' => 'Upload',
      'transfers.download' => 'Download',
      'transfers.statusQueued' => 'Queued',
      'transfers.statusPreparing' => 'Preparing the zip…',
      'transfers.statusProgress' => ({
        required String done,
        required String total,
        required int percent,
      }) => '${done} of ${total} · ${percent}%',
      'transfers.statusUploaded' => ({
        required String size,
      }) => 'Uploaded · ${size}',
      'transfers.statusDownloaded' => ({
        required String size,
      }) => 'Downloaded · ${size}',
      'transfers.statusFailed' => ({
        required String message,
      }) => 'Error: ${message}',
      'transfers.statusCancelled' => 'Cancelled',
      'transfers.cancel' => 'Cancel',
      'transfers.remove' => 'Remove from list',
      'accessKeys.description' => 'Each key lets an S3 client (AWS CLI, rclone, SDKs) in, only to the buckets you give it.',
      'accessKeys.secretOnce' => 'The secret is shown only once, when the key is created or its secret is regenerated.',
      'accessKeys.searchHint' => 'Search by name or ID...',
      'accessKeys.create' => 'Create key',
      'accessKeys.columnName' => 'Name',
      'accessKeys.columnId' => 'Access key ID',
      'accessKeys.columnPermissions' => 'Permissions',
      'accessKeys.columnLastUsed' => 'Last used',
      'accessKeys.columnStatus' => 'Status',
      'accessKeys.rootName' => 'Root key',
      'accessKeys.rootBadge' => 'Root',
      'accessKeys.rootPermissions' => 'Everything, including the console',
      'accessKeys.rootLocked' => 'Set with FEATHER_ACCESS and FEATHER_SECRET: it can\'t be edited or deleted',
      'accessKeys.createdOn' => ({required String date}) => 'Created ${date}',
      'accessKeys.copyId' => 'Copy ID',
      'accessKeys.idCopied' => 'ID copied',
      'accessKeys.allBuckets' => 'All',
      'accessKeys.noBuckets' => 'No buckets: edit it to give it access',
      'accessKeys.createsBuckets' => '+ create buckets',
      'accessKeys.levelReadOnly' => 'Read only',
      'accessKeys.levelWriteOnly' => 'Write only',
      'accessKeys.levelReadWrite' => 'Read and write',
      'accessKeys.levelShortRead' => 'Read',
      'accessKeys.levelShortWrite' => 'Write',
      'accessKeys.levelShortBoth' => 'Both',
      'accessKeys.levelReadOnlyDescription' => 'List and download objects.',
      'accessKeys.levelWriteOnlyDescription' =>
        'Upload and delete objects, without seeing them.',
      'accessKeys.levelReadWriteDescription' =>
        'List, download, upload and delete objects.',
      'accessKeys.statusActive' => 'Active',
      'accessKeys.statusDisabled' => 'Disabled',
      'accessKeys.statusExpired' => 'Expired',
      'accessKeys.expiresOn' => ({required String date}) => 'Expires ${date}',
      'accessKeys.expiredOn' => ({required String date}) => 'Expired ${date}',
      'accessKeys.neverUsed' => 'Never',
      'accessKeys.usedNow' => 'Just now',
      'accessKeys.usedMinutes' => ({required int count}) => '${count} min ago',
      'accessKeys.usedHours' => ({required int count}) => '${count} h ago',
      'accessKeys.usedDays' =>
        ({required int count}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
              count,
              one: '1 day ago',
              other: '${count} days ago',
            ),
      'accessKeys.actions' => ({required String name}) => 'Actions of ${name}',
      'accessKeys.editPermissions' => 'Edit permissions',
      'accessKeys.regenerateSecret' => 'Regenerate secret',
      'accessKeys.disable' => 'Disable',
      'accessKeys.enable' => 'Enable',
      'accessKeys.footerHint' => 'Keys are only for S3 clients: the console opens with the root key. A disabled or expired key gets 403 InvalidAccessKeyId.',
      'accessKeys.emptyTitle' => 'Only the root key exists',
      'accessKeys.emptyDescription' => 'Create a key for each client or application, with access to its own buckets only. You can then revoke it without touching the others.',
      'accessKeys.createFirst' => 'Create the first key',
      'accessKeys.noMatch' => 'No key matches the search or the filters',
      'accessKeys.filterStatus' => 'Status',
      'accessKeys.filterLevel' => 'Level',
      'accessKeys.filterBucket' => 'Bucket',
      'accessKeys.deleteTitle' => 'Delete key',
      'accessKeys.deleteConfirm' => ({
        required String name,
      }) => 'Delete the key ${name}? Clients using it will get 403 right away. To pause it, disable it instead.',
      'accessKeys.regenerateTitle' => 'Regenerate secret',
      'accessKeys.regenerateConfirm' => ({
        required String name,
      }) => 'Generate a new secret for ${name}? The current one stops working right away.',
      'accessKeys.regenerate' => 'Regenerate',
      'accessKeys.deletedSuccess' => ({
        required String name,
      }) => 'Key ${name} deleted',
      'accessKeys.disabledSuccess' => ({
        required String name,
      }) => 'Key ${name} disabled',
      'accessKeys.enabledSuccess' => ({
        required String name,
      }) => 'Key ${name} enabled',
      'accessKeys.savedSuccess' => ({
        required String name,
      }) => 'Key ${name} saved',
      'accessKeys.formCreateTitle' => 'Create access key',
      'accessKeys.formEditTitle' => 'Edit access key',
      'accessKeys.formCreateDescription' =>
        'The ID and the secret are generated when it is created.',
      'accessKeys.formEditDescription' => ({
        required String id,
      }) => '${id}. The secret doesn\'t change.',
      'accessKeys.formSectionIdentity' => '01 Identification',
      'accessKeys.formSectionScope' => '02 Scope',
      'accessKeys.formSectionPermissions' => '03 Permissions',
      'accessKeys.nameLabel' => 'Name',
      'accessKeys.nameHint' => 'Backups NAS',
      'accessKeys.nameRequired' => 'Give the key a name',
      'accessKeys.expiryLabel' => 'Expiration',
      'accessKeys.expiryNever' => 'Never expires',
      'accessKeys.expiry30Days' => 'In 30 days',
      'accessKeys.expiry90Days' => 'In 90 days',
      'accessKeys.expiryYear' => 'In 1 year',
      'accessKeys.expiryKeep' => ({required String date}) => 'Keep: ${date}',
      'accessKeys.scopeAll' => 'All buckets',
      'accessKeys.scopeAllDescription' => 'Also the ones created later. With write access it can also create and delete buckets.',
      'accessKeys.scopeSome' => 'Specific buckets',
      'accessKeys.scopeSomeDescription' => 'Only the ones you check, each with its level. It only sees those when listing.',
      'accessKeys.bucketsChecked' => ({
        required int count,
        required int total,
      }) => '${count} of ${total} checked',
      'accessKeys.bucketsRequired' => 'Check at least one bucket',
      'accessKeys.bucketsEmpty' =>
        'There are no buckets yet: create one, or give the key every bucket.',
      'accessKeys.formErrorTitle' => 'The key couldn\'t be saved',
      'accessKeys.secretCreatedTitle' => ({
        required String name,
      }) => 'Key created: ${name}',
      'accessKeys.secretRegeneratedTitle' => ({
        required String name,
      }) => 'New secret: ${name}',
      'accessKeys.secretWarning' => 'Copy the secret now: this is the only time it is shown. If you lose it, you\'ll have to regenerate it.',
      'accessKeys.secretLabel' => 'Secret access key',
      'accessKeys.copySecret' => 'Copy secret',
      'accessKeys.secretCopied' => 'Secret copied',
      'accessKeys.downloadCsv' => 'Download as .csv',
      'accessKeys.secretSaved' => 'I\'ve saved the secret somewhere safe',
      _ => null,
    };
  }
}
