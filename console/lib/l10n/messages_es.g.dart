///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'messages.g.dart';

import 'package:intl/intl.dart';
import 'package:slang/generated.dart';

// Path: <root>
class AppMessagesEs
    with BaseTranslations<AppMessagesLocale, AppMessages>
    implements AppMessages {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppMessagesLocale.build] is preferred.
  AppMessagesEs({
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
             locale: AppMessagesLocale.es,
             overrides: overrides ?? {},
             cardinalResolver: cardinalResolver,
             ordinalResolver: ordinalResolver,
           ) {
    _meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <es>.
  final TranslationMetadata<AppMessagesLocale, AppMessages> _meta;
  @override
  TranslationMetadata<AppMessagesLocale, AppMessages> get $meta => _meta;

  /// Access flat map
  @override
  dynamic operator [](String key) => _meta.getTranslation(key);

  late final AppMessagesEs _root = this; // ignore: unused_field

  @override
  AppMessagesEs $copyWith({
    TranslationMetadata<AppMessagesLocale, AppMessages>? meta,
  }) => AppMessagesEs(meta: meta ?? this.$meta);

  // Translations
  @override
  late final AppMessages$app$es app = AppMessages$app$es._(_root);
  @override
  late final AppMessages$common$es common = AppMessages$common$es._(_root);
  @override
  late final AppMessages$errors$es errors = AppMessages$errors$es._(_root);
  @override
  late final AppMessages$nav$es nav = AppMessages$nav$es._(_root);
  @override
  late final AppMessages$login$es login = AppMessages$login$es._(_root);
  @override
  late final AppMessages$buckets$es buckets = AppMessages$buckets$es._(_root);
  @override
  late final AppMessages$objects$es objects = AppMessages$objects$es._(_root);
  @override
  late final AppMessages$colors$es colors = AppMessages$colors$es._(_root);
  @override
  late final AppMessages$bucketAdmin$es bucketAdmin =
      AppMessages$bucketAdmin$es._(_root);
  @override
  late final AppMessages$anonymousAccess$es anonymousAccess =
      AppMessages$anonymousAccess$es._(_root);
  @override
  late final AppMessages$browser$es browser = AppMessages$browser$es._(_root);
  @override
  late final AppMessages$transfers$es transfers = AppMessages$transfers$es._(
    _root,
  );
  @override
  late final AppMessages$accessKeys$es accessKeys = AppMessages$accessKeys$es._(
    _root,
  );
}

// Path: app
class AppMessages$app$es implements AppMessages$app$en {
  AppMessages$app$es._(this._root);

  final AppMessagesEs _root; // ignore: unused_field

  // Translations
  @override
  String get name => 'Feather IO';
  @override
  String get needMoreSpace => 'Se necesita más espacio';
  @override
  String get splashTitle => 'Administración';
  @override
  String get splashFooter => 'Con ♥ desde Root101';
}

// Path: common
class AppMessages$common$es implements AppMessages$common$en {
  AppMessages$common$es._(this._root);

  final AppMessagesEs _root; // ignore: unused_field

  // Translations
  @override
  String get loading => 'Cargando';
  @override
  String get error => 'Error';
  @override
  String get tryAgain => 'Reintentar';
  @override
  String get noData => 'Sin datos';
  @override
  String get cancel => 'Cancelar';
  @override
  String get close => 'Cerrar';
  @override
  String get delete => 'Eliminar';
  @override
  String get edit => 'Editar';
  @override
  String get refresh => 'Actualizar';
  @override
  String get required => 'Requerido';
  @override
  String get preview => 'Vista previa';
  @override
  String get download => 'Descargar';
  @override
  String get upload => 'Subir';
  @override
  String get filter => 'Filtrar';
  @override
  String get name => 'Nombre';
  @override
  String get type => 'Tipo';
  @override
  String get size => 'Tamaño';
  @override
  String get objects => 'Objetos';
  @override
  String get createdAt => 'Fecha de creación';
  @override
  String get lastModified => 'Última modificación';
}

// Path: errors
class AppMessages$errors$es implements AppMessages$errors$en {
  AppMessages$errors$es._(this._root);

  final AppMessagesEs _root; // ignore: unused_field

  // Translations
  @override
  String get requestCancelled => 'La petición al servidor fue cancelada';
  @override
  String get connectionTimeout =>
      'Tiempo de conexión agotado con el servidor. Revisa tu conexión a internet';
  @override
  String get noConnection =>
      'No se pudo conectar con el servidor. Revisa tu conexión a internet';
  @override
  String get receiveTimeout =>
      'Tiempo de espera agotado al recibir datos del servidor';
  @override
  String get sendTimeout =>
      'Tiempo de espera agotado al enviar datos al servidor';
  @override
  String get badCertificate => 'Certificado inválido';
  @override
  String get connection => 'Error de conexión';
  @override
  String get validation => 'Error de validación';
  @override
  String get server => 'Error del servidor';
  @override
  String get unknown => 'Error desconocido';
}

// Path: nav
class AppMessages$nav$es implements AppMessages$nav$en {
  AppMessages$nav$es._(this._root);

  final AppMessagesEs _root; // ignore: unused_field

  // Translations
  @override
  String get browser => 'Explorador';
  @override
  String get buckets => 'Buckets';
  @override
  String language({required Object name}) => 'Idioma: ${name}';
  @override
  String get logout => 'Cerrar sesión';
  @override
  String get accessKeys => 'Claves de acceso';
}

// Path: login
class AppMessages$login$es implements AppMessages$login$en {
  AppMessages$login$es._(this._root);

  final AppMessagesEs _root; // ignore: unused_field

  // Translations
  @override
  String get accessKey => 'Clave de acceso';
  @override
  String get accessKeyHint => 'Introduce tu clave de acceso';
  @override
  String get secretKey => 'Clave secreta';
  @override
  String get secretKeyHint => 'Introduce tu clave secreta';
  @override
  String get button => 'Iniciar sesión';
  @override
  String get title => 'Inicia sesión';
  @override
  String get description => 'Gestiona tus buckets y tus claves de acceso.';
  @override
  String envHint({required Object access, required Object secret}) =>
      'Las claves se definen en el servidor con ${access} y ${secret}.';
  @override
  String get tagline => 'S3, sin el peso.';
  @override
  String get pitch =>
      'Los buckets son carpetas en tu disco. AWS CLI, rclone y los SDK de S3 se conectan con SigV4. Un binario de Dart y una consola web.';
  @override
  List<String> get tags => [
    'Autoalojado',
    'Compatible con S3',
    'Ligero',
    'Hecho en Dart',
  ];
}

// Path: buckets
class AppMessages$buckets$es implements AppMessages$buckets$en {
  AppMessages$buckets$es._(this._root);

  final AppMessagesEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Buckets';
  @override
  String get subtitle =>
      'Gestiona tus buckets compatibles con S3 y tus recursos de almacenamiento.';
  @override
  String get create => 'Crear bucket';
  @override
  String get edit => 'Editar bucket';
  @override
  String get totalBuckets => 'Total de buckets';
  @override
  String get totalObjects => 'Total de objetos';
  @override
  String get totalStorage => 'Almacenamiento total';
  @override
  String get searchHint => 'Buscar buckets...';
  @override
  String get empty => 'No se encontraron buckets';
  @override
  String noMatch({required Object query}) =>
      'Ningún bucket coincide con "${query}"';
  @override
  String get deleteTitle => 'Eliminar bucket';
  @override
  String deleteConfirm({required Object name}) =>
      '¿Seguro que quieres eliminar el bucket ${name}?';
  @override
  String get readWriteBadge => 'L/E';
  @override
  String get readWriteTooltip =>
      'En este bucket tienes acceso de lectura y escritura';
  @override
  String createdAt({required Object date}) => 'Creado ${date}';
  @override
  String get createDescription =>
      'Configura los parámetros del almacenamiento de objetos de alto rendimiento, la redundancia y las políticas de protección.';
  @override
  String get createSectionGeneral => '01 Configuración general';
  @override
  String get createSectionAdditional => '02 Información adicional';
  @override
  String get createNameLabel => 'Identificador del bucket';
  @override
  String get createNameHint => 'mi-bucket';
  @override
  String get createDescriptionLabel => 'Descripción (opcional)';
  @override
  String get createDescriptionHint => 'Breve descripción del uso del bucket';
  @override
  String get nameRequired => 'El nombre del bucket es obligatorio';
  @override
  String get nameLength => 'Entre 3 y 63 caracteres';
  @override
  String get nameChars => 'Solo minúsculas, números y guiones';
  @override
  String get nameHyphenEdges => 'No puede empezar ni terminar con guion';
  @override
  String get ruleChars => 'Solo minúsculas, números y guiones';
  @override
  String get ruleHyphenEdges => 'Sin guion al inicio o al final';
  @override
  String get createColorLabel => 'Color';
  @override
  String get nameExists => 'Ya existe un bucket con ese nombre';
  @override
  String get createErrorTitle => 'No se pudo crear el bucket';
  @override
  String editDescription({required Object name}) =>
      'Cambia la descripción y el color del bucket ${name}. El nombre no se puede cambiar.';
  @override
  String get editSave => 'Guardar cambios';
  @override
  String get editErrorTitle => 'No se pudo guardar el bucket';
  @override
  String updatedSuccess({required Object name}) =>
      'Bucket «${name}» actualizado';
  @override
  String createdSuccess({required Object name}) => 'Bucket «${name}» creado';
  @override
  String namePathHint({required Object name}) =>
      'Se usará en las rutas S3: /${name}';
  @override
  String get settings => 'Configuración';
}

// Path: objects
class AppMessages$objects$es implements AppMessages$objects$en {
  AppMessages$objects$es._(this._root);

  final AppMessagesEs _root; // ignore: unused_field

  // Translations
  @override
  String get searchHint => 'Buscar objetos...';
  @override
  String get empty => 'No se encontraron objetos';
  @override
  String get noMatchFilter => 'Ningún objeto coincide con los filtros';
  @override
  String get filtersTitle => 'Filtros';
  @override
  String get filtersClear => 'Limpiar';
  @override
  String get filterType => 'Tipo';
  @override
  String get filterTypeOther => 'Otros';
  @override
  String get filterSize => 'Tamaño';
  @override
  String get filterSizeSmall => 'Menos de 1 MB';
  @override
  String get filterSizeMedium => 'De 1 MB a 100 MB';
  @override
  String get filterSizeLarge => 'Más de 100 MB';
  @override
  String get filterModified => 'Modificado';
  @override
  String get filterDate24h => 'Últimas 24 horas';
  @override
  String get filterDate7d => 'Últimos 7 días';
  @override
  String get filterDate30d => 'Últimos 30 días';
  @override
  String get filterDateOlder => 'Hace más de 30 días';
  @override
  String get filterFoldersHidden =>
      'Las carpetas se ocultan mientras haya un filtro activo.';
  @override
  String noMatch({required Object query}) =>
      'Ningún objeto coincide con "${query}"';
  @override
  String get dragHint => 'Arrastra ficheros aquí para subirlos';
  @override
  String get dropHere => 'Suelta aquí para subir';
  @override
  String get deleteTitle => 'Eliminar objetos';
  @override
  String deleteConfirm({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
        count,
        one: '¿Seguro que quieres eliminar 1 objeto?',
        other: '¿Seguro que quieres eliminar ${count} objetos?',
      );
  @override
  String get uploadFiles => 'Subir ficheros';
  @override
  String get uploadDirectory => 'Subir carpeta';
  @override
  String get fileTypeFolder => 'Carpeta';
  @override
  String get fileTypeFile => 'Fichero';
  @override
  String get fileTypeImage => 'Imagen';
  @override
  String get fileTypeVideo => 'Vídeo';
  @override
  String get fileTypeAudio => 'Audio';
  @override
  String get fileTypeText => 'Texto';
  @override
  String get fileTypeDocument => 'Documento';
  @override
  String get fileTypeSpreadsheet => 'Hoja de cálculo';
  @override
  String get fileTypeArchive => 'Comprimido';
  @override
  String get newFolder => 'Nueva carpeta';
  @override
  String get newFolderCreate => 'Crear carpeta';
  @override
  String get folderNameLabel => 'Nombre de la carpeta';
  @override
  String get folderNameHint => 'facturas-2026';
  @override
  String folderPathHelper({required Object path}) => 'Se creará en ${path}';
  @override
  String folderCreated({required Object name}) => 'Carpeta «${name}» creada';
  @override
  String get folderExists => 'Ya hay una carpeta u objeto con ese nombre aquí.';
  @override
  String get rename => 'Renombrar';
  @override
  String get renameLabel => 'Nuevo nombre';
  @override
  String renamePathHelper({required Object path}) => 'Queda en ${path}';
  @override
  String renamed({required Object name}) => 'Renombrado a «${name}»';
  @override
  String get nameExists =>
      'Ya hay un objeto o carpeta con ese nombre en esta carpeta.';
  @override
  String get nameRequired => 'El nombre es obligatorio';
  @override
  String get nameInvalid => 'No uses / \ ni ninguno de < > : " | ? *';
  @override
  String get nameUnchanged => 'Es el nombre actual';
  @override
  String get actionErrorTitle => 'No se pudo completar la acción';
  @override
  String get details => 'Detalles';
  @override
  String get move => 'Mover';
  @override
  String get moveSelection => 'Mover selección';
  @override
  String moveTitle({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
        count,
        one: 'Mover 1 objeto',
        other: 'Mover ${count} objetos',
      );
  @override
  String get moveBucket => 'Bucket de destino';
  @override
  String get moveFolder => 'Carpeta de destino';
  @override
  String get moveNoFolders => 'No hay subcarpetas';
  @override
  String get moveHere => 'Mover aquí';
  @override
  String moveHelper({required Object path}) =>
      'Se moverán a ${path}. Si ya hay objetos con esos nombres, se sustituyen.';
  @override
  String get moveSameFolder => 'Ya están en esta carpeta. Elige otra.';
  @override
  String moved({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
        count,
        one: '1 objeto movido',
        other: '${count} objetos movidos',
      );
  @override
  String movePartial({required Object moved, required Object total}) =>
      'Solo se movieron ${moved} de ${total} objetos.';
  @override
  String detailsSubtitle({required Object type, required Object size}) =>
      '${type} · ${size}';
  @override
  String get detailsKey => 'Key';
  @override
  String get detailsType => 'Tipo';
  @override
  String get detailsSize => 'Tamaño';
  @override
  String detailsSizeBytes({required Object bytes}) => '(${bytes} bytes)';
  @override
  String get detailsModified => 'Modificado';
  @override
  String get detailsUrl => 'URL';
  @override
  String get detailsCopyUrl => 'Copiar URL';
  @override
  String get detailsUrlCopied => 'URL copiada';
  @override
  String get pageSize => 'Filas por página:';
  @override
  String pageOf({required Object page, required Object total}) =>
      'Página ${page} de ${total}';
  @override
  String get previousPage => 'Página anterior';
  @override
  String get nextPage => 'Página siguiente';
  @override
  String get pagerHint =>
      'La búsqueda y los filtros solo se aplican a las páginas ya cargadas.';
  @override
  String pagerHintPages({required Object loaded, required Object total}) =>
      'La búsqueda y los filtros solo se aplican a las páginas ya cargadas (${loaded} de ${total}).';
  @override
  String get shareLink => 'Compartir enlace';
  @override
  String shareLinkDescription({required Object name}) =>
      'Cualquiera con el enlace podrá descargar ${name} hasta que caduque, sin iniciar sesión.';
  @override
  String get shareLinkExpiresIn => 'Caduca en';
  @override
  String get shareLinkHour => '1 hora';
  @override
  String get shareLinkDay => '1 día';
  @override
  String get shareLinkWeek => '7 días';
  @override
  String shareLinkValidUntil({required Object date}) =>
      'Válido hasta el ${date}';
  @override
  String get shareLinkCopy => 'Copiar enlace';
  @override
  String get shareLinkCopied => 'Enlace copiado';
}

// Path: colors
class AppMessages$colors$es implements AppMessages$colors$en {
  AppMessages$colors$es._(this._root);

  final AppMessagesEs _root; // ignore: unused_field

  // Translations
  @override
  String get none => 'Sin color';
  @override
  String get custom => 'Color personalizado';
  @override
  String get apply => 'Aplicar';
  @override
  String get saturationBrightness => 'Saturación y brillo';
  @override
  String get hue => 'Tono';
  @override
  String contrast({required Object ratio}) =>
      'Contraste con el icono: ${ratio}:1';
  @override
  String contrastLow({required Object ratio}) =>
      'Poco contraste con el icono (${ratio}:1)';
  @override
  String get hexInvalid =>
      'Escribe un color HEX de 6 dígitos, por ejemplo #0E7490';
  @override
  String get violet => 'Violeta';
  @override
  String get blue => 'Azul';
  @override
  String get teal => 'Verde azulado';
  @override
  String get green => 'Verde';
  @override
  String get amber => 'Ámbar';
  @override
  String get red => 'Rojo';
  @override
  String get pink => 'Rosa';
  @override
  String get slate => 'Pizarra';
}

// Path: bucketAdmin
class AppMessages$bucketAdmin$es implements AppMessages$bucketAdmin$en {
  AppMessages$bucketAdmin$es._(this._root);

  final AppMessagesEs _root; // ignore: unused_field

  // Translations
  @override
  String count({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
        count,
        one: '1 bucket',
        other: '${count} buckets',
      );
  @override
  String stats({required num count, required Object size}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
        count,
        one: '1 objeto · ${size}',
        other: '${count} objetos · ${size}',
      );
  @override
  String get noBucketsDescription => 'Crea un bucket para configurarlo aquí.';
  @override
  String get openInBrowser => 'Abrir en el explorador';
  @override
  String get tabGeneral => 'General';
  @override
  String get tabAccess => 'Acceso anónimo';
  @override
  String get tabDanger => 'Zona de peligro';
  @override
  String get detailObjects => 'Objetos';
  @override
  String get detailSize => 'Tamaño';
  @override
  String get detailCreated => 'Creado';
  @override
  String get detailLastModified => 'Última modificación';
  @override
  String get detailNeverModified => 'Sin objetos';
  @override
  String get detailName => 'Nombre';
  @override
  String get detailS3Path => 'Ruta S3';
  @override
  String get detailCopyPath => 'Copiar ruta';
  @override
  String get detailPathCopied => 'Ruta copiada';
  @override
  String get detailDescription => 'Descripción';
  @override
  String get detailNoDescription => 'Sin descripción';
  @override
  String get detailColor => 'Color';
  @override
  String get emptyTitle => 'Vaciar bucket';
  @override
  String get emptyAlreadyEmpty => 'El bucket no tiene objetos.';
  @override
  String emptyDescription({
    required num count,
    required Object size,
  }) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
    count,
    one:
        'Elimina su único objeto (${size}). El bucket, su configuración y sus reglas de acceso se mantienen. No se puede deshacer.',
    other:
        'Elimina sus ${count} objetos (${size}). El bucket, su configuración y sus reglas de acceso se mantienen. No se puede deshacer.',
  );
  @override
  String emptyConfirm({
    required num count,
    required Object size,
    required Object name,
  }) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
    count,
    one: 'Se eliminará 1 objeto (${size}) de ${name}. No se puede deshacer.',
    other:
        'Se eliminarán ${count} objetos (${size}) de ${name}. No se puede deshacer.',
  );
  @override
  String emptyTypeName({required Object name}) =>
      'Escribe ${name} para confirmar';
  @override
  String get emptyTypeNameHelper =>
      'El botón se activa cuando el nombre coincide.';
  @override
  String get deleteDescription =>
      'Borra el bucket con su descripción, color y reglas de acceso. Como en S3, solo se puede eliminar si está vacío.';
  @override
  String deleteNotEmpty({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
        count,
        one: 'El bucket tiene 1 objeto. Vacíalo primero.',
        other: 'El bucket tiene ${count} objetos. Vacíalo primero.',
      );
}

// Path: anonymousAccess
class AppMessages$anonymousAccess$es implements AppMessages$anonymousAccess$en {
  AppMessages$anonymousAccess$es._(this._root);

  final AppMessagesEs _root; // ignore: unused_field

  // Translations
  @override
  String get description =>
      'Cada regla deja un prefijo accesible sin credenciales. Lo que no cubre ninguna regla sigue necesitando autenticación.';
  @override
  String get privateTitle => 'Bucket privado';
  @override
  String get privateDescription =>
      'Todas las peticiones necesitan credenciales. Añade una regla para servir un prefijo sin autenticación, por ejemplo las imágenes de una web.';
  @override
  String get readOnly => 'Solo lectura';
  @override
  String get writeOnly => 'Solo escritura';
  @override
  String get readWrite => 'Lectura y escritura';
  @override
  String get readOnlyOps => 'Listar y descargar objetos';
  @override
  String get writeOnlyOps => 'Subir y borrar objetos';
  @override
  String get readWriteOps => 'Listar, descargar, subir y borrar';
  @override
  String get readOnlyDescription => 'Cualquiera puede listar y descargar.';
  @override
  String get writeOnlyDescription =>
      'Cualquiera puede subir y borrar, pero no ver.';
  @override
  String get readWriteDescription => 'Acceso completo sin credenciales.';
  @override
  String get readOnlyUseCase => 'Webs, catálogos, descargas públicas.';
  @override
  String get writeOnlyUseCase => 'Buzones de subida, formularios.';
  @override
  String get readWriteUseCase => 'Úsalo solo en prefijos temporales.';
  @override
  String get ruleAdd => 'Añadir regla';
  @override
  String get rulePrefix => 'Prefijo';
  @override
  String get ruleAccess => 'Acceso';
  @override
  String get ruleOps => 'Operaciones sin credenciales';
  @override
  String get ruleHint =>
      'Los prefijos son relativos al bucket y admiten * como comodín. Si varias reglas coinciden, se aplica la primera.';
  @override
  String get ruleDeleteTitle => 'Eliminar regla';
  @override
  String ruleDeleteConfirm({required Object prefix}) =>
      '¿Seguro que quieres eliminar la regla ${prefix}? Los objetos de ese prefijo volverán a necesitar credenciales.';
  @override
  String get ruleFormTitle => 'Añadir regla de acceso';
  @override
  String ruleFormDescription({required Object bucket}) =>
      'Deja un prefijo de ${bucket} accesible sin credenciales.';
  @override
  String get ruleFormSectionPrefix => '01 Prefijo';
  @override
  String get ruleFormSectionAccess => '02 Tipo de acceso';
  @override
  String get rulePrefixLabel => 'Prefijo o patrón';
  @override
  String get rulePrefixHint => 'public/';
  @override
  String get rulePrefixHelper =>
      'Sin *, cubre todo lo que empieza así (termina en / para una carpeta). Con *, tiene que coincidir la key entera (por ejemplo, *.jpg solo cubre ficheros .jpg), y solo abre los listados si termina en *.';
  @override
  String get rulePrefixRequired => 'El prefijo es obligatorio';
  @override
  String get ruleFormErrorTitle => 'No se pudo añadir la regla';
  @override
  String ruleCreatedSuccess({required Object prefix}) =>
      'Regla ${prefix} añadida';
}

// Path: browser
class AppMessages$browser$es implements AppMessages$browser$en {
  AppMessages$browser$es._(this._root);

  final AppMessagesEs _root; // ignore: unused_field

  // Translations
  @override
  String bucketNotFound({required Object name}) =>
      'El bucket «${name}» no existe';
  @override
  String get bucketNotFoundDescription =>
      'Puede que lo hayan borrado o que el enlace esté mal escrito.';
  @override
  String get backToBuckets => 'Ver buckets';
  @override
  String folderNotFound({required Object folder}) =>
      'La carpeta «${folder}» no existe en este bucket';
  @override
  String get folderNotFoundDescription =>
      'Puede que la hayan borrado o que la ruta esté mal escrita. En S3 una carpeta solo existe mientras tiene objetos.';
  @override
  String get goToBucketRoot => 'Ir a la raíz del bucket';
}

// Path: transfers
class AppMessages$transfers$es implements AppMessages$transfers$en {
  AppMessages$transfers$es._(this._root);

  final AppMessagesEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Transferencias';
  @override
  String active({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
        count,
        one: '1 transferencia en curso',
        other: '${count} transferencias en curso',
      );
  @override
  String failed({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
        count,
        one: '1 transferencia con error',
        other: '${count} transferencias con error',
      );
  @override
  String get allDone => 'Todas las transferencias han terminado';
  @override
  String get empty =>
      'Aún no hay transferencias. Las subidas y descargas siguen en segundo plano mientras usas la consola.';
  @override
  String uploadsAdded({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
        count,
        one: '1 fichero añadido a las transferencias',
        other: '${count} ficheros añadidos a las transferencias',
      );
  @override
  String downloadAdded({required Object name}) =>
      'Descargando ${name} en segundo plano';
  @override
  String get clearFinished => 'Limpiar terminadas';
  @override
  String get upload => 'Subida';
  @override
  String get download => 'Descarga';
  @override
  String get statusQueued => 'En cola';
  @override
  String get statusPreparing => 'Preparando el zip…';
  @override
  String statusProgress({
    required Object done,
    required Object total,
    required Object percent,
  }) => '${done} de ${total} · ${percent}%';
  @override
  String statusUploaded({required Object size}) => 'Subido · ${size}';
  @override
  String statusDownloaded({required Object size}) => 'Descargado · ${size}';
  @override
  String statusFailed({required Object message}) => 'Error: ${message}';
  @override
  String get statusCancelled => 'Cancelada';
  @override
  String get cancel => 'Cancelar';
  @override
  String get remove => 'Quitar de la lista';
}

// Path: accessKeys
class AppMessages$accessKeys$es implements AppMessages$accessKeys$en {
  AppMessages$accessKeys$es._(this._root);

  final AppMessagesEs _root; // ignore: unused_field

  // Translations
  @override
  String get description =>
      'Cada clave deja entrar a un cliente S3 (AWS CLI, rclone, SDKs) solo en los buckets que le des.';
  @override
  String get secretOnce =>
      'El secreto se muestra una sola vez, al crear la clave o al regenerarlo.';
  @override
  String get searchHint => 'Buscar por nombre o ID...';
  @override
  String get create => 'Crear clave';
  @override
  String get columnName => 'Nombre';
  @override
  String get columnId => 'Access key ID';
  @override
  String get columnPermissions => 'Permisos';
  @override
  String get columnLastUsed => 'Último uso';
  @override
  String get columnStatus => 'Estado';
  @override
  String get rootName => 'Clave raíz';
  @override
  String get rootBadge => 'Raíz';
  @override
  String get rootPermissions => 'Todo, incluida la consola';
  @override
  String get rootLocked =>
      'Se configura con FEATHER_ACCESS y FEATHER_SECRET: no se puede editar ni eliminar';
  @override
  String createdOn({required Object date}) => 'Creada el ${date}';
  @override
  String get copyId => 'Copiar ID';
  @override
  String get idCopied => 'ID copiado';
  @override
  String get allBuckets => 'Todos';
  @override
  String get noBuckets => 'Ningún bucket: edítala para darle acceso';
  @override
  String get createsBuckets => '+ crear buckets';
  @override
  String get levelReadOnly => 'Solo lectura';
  @override
  String get levelWriteOnly => 'Solo escritura';
  @override
  String get levelReadWrite => 'Lectura y escritura';
  @override
  String get levelShortRead => 'Lectura';
  @override
  String get levelShortWrite => 'Escritura';
  @override
  String get levelShortBoth => 'Ambos';
  @override
  String get levelReadOnlyDescription => 'Listar y descargar objetos.';
  @override
  String get levelWriteOnlyDescription => 'Subir y borrar objetos, sin verlos.';
  @override
  String get levelReadWriteDescription =>
      'Listar, descargar, subir y borrar objetos.';
  @override
  String get statusActive => 'Activa';
  @override
  String get statusDisabled => 'Desactivada';
  @override
  String get statusExpired => 'Caducada';
  @override
  String expiresOn({required Object date}) => 'Caduca el ${date}';
  @override
  String expiredOn({required Object date}) => 'Caducó el ${date}';
  @override
  String get neverUsed => 'Nunca';
  @override
  String get usedNow => 'Ahora mismo';
  @override
  String usedMinutes({required Object count}) => 'Hace ${count} min';
  @override
  String usedHours({required Object count}) => 'Hace ${count} h';
  @override
  String usedDays({required num count}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
        count,
        one: 'Hace 1 día',
        other: 'Hace ${count} días',
      );
  @override
  String actions({required Object name}) => 'Acciones de ${name}';
  @override
  String get editPermissions => 'Editar permisos';
  @override
  String get regenerateSecret => 'Regenerar secreto';
  @override
  String get disable => 'Desactivar';
  @override
  String get enable => 'Activar';
  @override
  String get footerHint =>
      'Las claves solo sirven para clientes S3: la consola se abre con la clave raíz. Una clave desactivada o caducada responde 403 InvalidAccessKeyId.';
  @override
  String get emptyTitle => 'Solo existe la clave raíz';
  @override
  String get emptyDescription =>
      'Crea una clave para cada cliente o aplicación, con acceso solo a sus buckets. Así puedes revocarla sin tocar las demás.';
  @override
  String get createFirst => 'Crear la primera clave';
  @override
  String get noMatch => 'Ninguna clave coincide con la búsqueda o los filtros';
  @override
  String get filterStatus => 'Estado';
  @override
  String get filterLevel => 'Nivel';
  @override
  String get filterBucket => 'Bucket';
  @override
  String get deleteTitle => 'Eliminar clave';
  @override
  String deleteConfirm({required Object name}) =>
      '¿Seguro que quieres eliminar la clave ${name}? Los clientes que la usen recibirán 403 al momento. Si solo quieres pausarla, desactívala.';
  @override
  String get regenerateTitle => 'Regenerar secreto';
  @override
  String regenerateConfirm({required Object name}) =>
      '¿Generar un secreto nuevo para ${name}? El actual deja de funcionar al momento.';
  @override
  String get regenerate => 'Regenerar';
  @override
  String deletedSuccess({required Object name}) => 'Clave ${name} eliminada';
  @override
  String disabledSuccess({required Object name}) => 'Clave ${name} desactivada';
  @override
  String enabledSuccess({required Object name}) => 'Clave ${name} activada';
  @override
  String savedSuccess({required Object name}) => 'Clave ${name} guardada';
  @override
  String get formCreateTitle => 'Crear clave de acceso';
  @override
  String get formEditTitle => 'Editar clave de acceso';
  @override
  String get formCreateDescription =>
      'El ID y el secreto se generan al crearla.';
  @override
  String formEditDescription({required Object id}) =>
      '${id}. El secreto no cambia.';
  @override
  String get formSectionIdentity => '01 Identificación';
  @override
  String get formSectionScope => '02 Alcance';
  @override
  String get formSectionPermissions => '03 Permisos';
  @override
  String get nameLabel => 'Nombre';
  @override
  String get nameHint => 'Backups NAS';
  @override
  String get nameRequired => 'Ponle un nombre a la clave';
  @override
  String get expiryLabel => 'Caducidad';
  @override
  String get expiryNever => 'Nunca caduca';
  @override
  String get expiry30Days => 'En 30 días';
  @override
  String get expiry90Days => 'En 90 días';
  @override
  String get expiryYear => 'En 1 año';
  @override
  String expiryKeep({required Object date}) => 'Mantener: ${date}';
  @override
  String get scopeAll => 'Todos los buckets';
  @override
  String get scopeAllDescription =>
      'También los que se creen después. Con escritura, además puede crear y eliminar buckets.';
  @override
  String get scopeSome => 'Buckets concretos';
  @override
  String get scopeSomeDescription =>
      'Solo los que marques, cada uno con su nivel. Solo ve esos al listar.';
  @override
  String bucketsChecked({required Object count, required Object total}) =>
      '${count} de ${total} marcados';
  @override
  String get bucketsRequired => 'Marca al menos un bucket';
  @override
  String get bucketsEmpty =>
      'Aún no hay buckets: crea uno, o dale a la clave todos los buckets.';
  @override
  String get formErrorTitle => 'No se pudo guardar la clave';
  @override
  String secretCreatedTitle({required Object name}) => 'Clave creada: ${name}';
  @override
  String secretRegeneratedTitle({required Object name}) =>
      'Secreto nuevo: ${name}';
  @override
  String get secretWarning =>
      'Copia el secreto ahora: es la única vez que se muestra. Si lo pierdes, tendrás que regenerarlo.';
  @override
  String get secretLabel => 'Secret access key';
  @override
  String get copySecret => 'Copiar secreto';
  @override
  String get secretCopied => 'Secreto copiado';
  @override
  String get downloadCsv => 'Descargar como .csv';
  @override
  String get secretSaved => 'He guardado el secreto en un lugar seguro';
}

/// The flat map containing all translations for locale <es>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on AppMessagesEs {
  dynamic _flatMapFunction(String path) {
    return switch (path) {
      'app.name' => 'Feather IO',
      'app.needMoreSpace' => 'Se necesita más espacio',
      'app.splashTitle' => 'Administración',
      'app.splashFooter' => 'Con ♥ desde Root101',
      'common.loading' => 'Cargando',
      'common.error' => 'Error',
      'common.tryAgain' => 'Reintentar',
      'common.noData' => 'Sin datos',
      'common.cancel' => 'Cancelar',
      'common.close' => 'Cerrar',
      'common.delete' => 'Eliminar',
      'common.edit' => 'Editar',
      'common.refresh' => 'Actualizar',
      'common.required' => 'Requerido',
      'common.preview' => 'Vista previa',
      'common.download' => 'Descargar',
      'common.upload' => 'Subir',
      'common.filter' => 'Filtrar',
      'common.name' => 'Nombre',
      'common.type' => 'Tipo',
      'common.size' => 'Tamaño',
      'common.objects' => 'Objetos',
      'common.createdAt' => 'Fecha de creación',
      'common.lastModified' => 'Última modificación',
      'errors.requestCancelled' => 'La petición al servidor fue cancelada',
      'errors.connectionTimeout' => 'Tiempo de conexión agotado con el servidor. Revisa tu conexión a internet',
      'errors.noConnection' =>
        'No se pudo conectar con el servidor. Revisa tu conexión a internet',
      'errors.receiveTimeout' =>
        'Tiempo de espera agotado al recibir datos del servidor',
      'errors.sendTimeout' =>
        'Tiempo de espera agotado al enviar datos al servidor',
      'errors.badCertificate' => 'Certificado inválido',
      'errors.connection' => 'Error de conexión',
      'errors.validation' => 'Error de validación',
      'errors.server' => 'Error del servidor',
      'errors.unknown' => 'Error desconocido',
      'nav.browser' => 'Explorador',
      'nav.buckets' => 'Buckets',
      'nav.language' => ({required Object name}) => 'Idioma: ${name}',
      'nav.logout' => 'Cerrar sesión',
      'nav.accessKeys' => 'Claves de acceso',
      'login.accessKey' => 'Clave de acceso',
      'login.accessKeyHint' => 'Introduce tu clave de acceso',
      'login.secretKey' => 'Clave secreta',
      'login.secretKeyHint' => 'Introduce tu clave secreta',
      'login.button' => 'Iniciar sesión',
      'login.title' => 'Inicia sesión',
      'login.description' => 'Gestiona tus buckets y tus claves de acceso.',
      'login.envHint' => ({
        required Object access,
        required Object secret,
      }) => 'Las claves se definen en el servidor con ${access} y ${secret}.',
      'login.tagline' => 'S3, sin el peso.',
      'login.pitch' => 'Los buckets son carpetas en tu disco. AWS CLI, rclone y los SDK de S3 se conectan con SigV4. Un binario de Dart y una consola web.',
      'login.tags.0' => 'Autoalojado',
      'login.tags.1' => 'Compatible con S3',
      'login.tags.2' => 'Ligero',
      'login.tags.3' => 'Hecho en Dart',
      'buckets.title' => 'Buckets',
      'buckets.subtitle' => 'Gestiona tus buckets compatibles con S3 y tus recursos de almacenamiento.',
      'buckets.create' => 'Crear bucket',
      'buckets.edit' => 'Editar bucket',
      'buckets.totalBuckets' => 'Total de buckets',
      'buckets.totalObjects' => 'Total de objetos',
      'buckets.totalStorage' => 'Almacenamiento total',
      'buckets.searchHint' => 'Buscar buckets...',
      'buckets.empty' => 'No se encontraron buckets',
      'buckets.noMatch' => ({
        required Object query,
      }) => 'Ningún bucket coincide con "${query}"',
      'buckets.deleteTitle' => 'Eliminar bucket',
      'buckets.deleteConfirm' => ({
        required Object name,
      }) => '¿Seguro que quieres eliminar el bucket ${name}?',
      'buckets.readWriteBadge' => 'L/E',
      'buckets.readWriteTooltip' =>
        'En este bucket tienes acceso de lectura y escritura',
      'buckets.createdAt' => ({required Object date}) => 'Creado ${date}',
      'buckets.createDescription' => 'Configura los parámetros del almacenamiento de objetos de alto rendimiento, la redundancia y las políticas de protección.',
      'buckets.createSectionGeneral' => '01 Configuración general',
      'buckets.createSectionAdditional' => '02 Información adicional',
      'buckets.createNameLabel' => 'Identificador del bucket',
      'buckets.createNameHint' => 'mi-bucket',
      'buckets.createDescriptionLabel' => 'Descripción (opcional)',
      'buckets.createDescriptionHint' => 'Breve descripción del uso del bucket',
      'buckets.nameRequired' => 'El nombre del bucket es obligatorio',
      'buckets.nameLength' => 'Entre 3 y 63 caracteres',
      'buckets.nameChars' => 'Solo minúsculas, números y guiones',
      'buckets.nameHyphenEdges' => 'No puede empezar ni terminar con guion',
      'buckets.ruleChars' => 'Solo minúsculas, números y guiones',
      'buckets.ruleHyphenEdges' => 'Sin guion al inicio o al final',
      'buckets.createColorLabel' => 'Color',
      'buckets.nameExists' => 'Ya existe un bucket con ese nombre',
      'buckets.createErrorTitle' => 'No se pudo crear el bucket',
      'buckets.editDescription' => ({
        required Object name,
      }) => 'Cambia la descripción y el color del bucket ${name}. El nombre no se puede cambiar.',
      'buckets.editSave' => 'Guardar cambios',
      'buckets.editErrorTitle' => 'No se pudo guardar el bucket',
      'buckets.updatedSuccess' => ({
        required Object name,
      }) => 'Bucket «${name}» actualizado',
      'buckets.createdSuccess' => ({
        required Object name,
      }) => 'Bucket «${name}» creado',
      'buckets.namePathHint' => ({
        required Object name,
      }) => 'Se usará en las rutas S3: /${name}',
      'buckets.settings' => 'Configuración',
      'objects.searchHint' => 'Buscar objetos...',
      'objects.empty' => 'No se encontraron objetos',
      'objects.noMatchFilter' => 'Ningún objeto coincide con los filtros',
      'objects.filtersTitle' => 'Filtros',
      'objects.filtersClear' => 'Limpiar',
      'objects.filterType' => 'Tipo',
      'objects.filterTypeOther' => 'Otros',
      'objects.filterSize' => 'Tamaño',
      'objects.filterSizeSmall' => 'Menos de 1 MB',
      'objects.filterSizeMedium' => 'De 1 MB a 100 MB',
      'objects.filterSizeLarge' => 'Más de 100 MB',
      'objects.filterModified' => 'Modificado',
      'objects.filterDate24h' => 'Últimas 24 horas',
      'objects.filterDate7d' => 'Últimos 7 días',
      'objects.filterDate30d' => 'Últimos 30 días',
      'objects.filterDateOlder' => 'Hace más de 30 días',
      'objects.filterFoldersHidden' =>
        'Las carpetas se ocultan mientras haya un filtro activo.',
      'objects.noMatch' => ({
        required Object query,
      }) => 'Ningún objeto coincide con "${query}"',
      'objects.dragHint' => 'Arrastra ficheros aquí para subirlos',
      'objects.dropHere' => 'Suelta aquí para subir',
      'objects.deleteTitle' => 'Eliminar objetos',
      'objects.deleteConfirm' =>
        ({required num count}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
              count,
              one: '¿Seguro que quieres eliminar 1 objeto?',
              other: '¿Seguro que quieres eliminar ${count} objetos?',
            ),
      'objects.uploadFiles' => 'Subir ficheros',
      'objects.uploadDirectory' => 'Subir carpeta',
      'objects.fileTypeFolder' => 'Carpeta',
      'objects.fileTypeFile' => 'Fichero',
      'objects.fileTypeImage' => 'Imagen',
      'objects.fileTypeVideo' => 'Vídeo',
      'objects.fileTypeAudio' => 'Audio',
      'objects.fileTypeText' => 'Texto',
      'objects.fileTypeDocument' => 'Documento',
      'objects.fileTypeSpreadsheet' => 'Hoja de cálculo',
      'objects.fileTypeArchive' => 'Comprimido',
      'objects.newFolder' => 'Nueva carpeta',
      'objects.newFolderCreate' => 'Crear carpeta',
      'objects.folderNameLabel' => 'Nombre de la carpeta',
      'objects.folderNameHint' => 'facturas-2026',
      'objects.folderPathHelper' => ({
        required Object path,
      }) => 'Se creará en ${path}',
      'objects.folderCreated' => ({
        required Object name,
      }) => 'Carpeta «${name}» creada',
      'objects.folderExists' =>
        'Ya hay una carpeta u objeto con ese nombre aquí.',
      'objects.rename' => 'Renombrar',
      'objects.renameLabel' => 'Nuevo nombre',
      'objects.renamePathHelper' => ({
        required Object path,
      }) => 'Queda en ${path}',
      'objects.renamed' => ({required Object name}) => 'Renombrado a «${name}»',
      'objects.nameExists' =>
        'Ya hay un objeto o carpeta con ese nombre en esta carpeta.',
      'objects.nameRequired' => 'El nombre es obligatorio',
      'objects.nameInvalid' => 'No uses / \ ni ninguno de < > : " | ? *',
      'objects.nameUnchanged' => 'Es el nombre actual',
      'objects.actionErrorTitle' => 'No se pudo completar la acción',
      'objects.details' => 'Detalles',
      'objects.move' => 'Mover',
      'objects.moveSelection' => 'Mover selección',
      'objects.moveTitle' =>
        ({required num count}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
              count,
              one: 'Mover 1 objeto',
              other: 'Mover ${count} objetos',
            ),
      'objects.moveBucket' => 'Bucket de destino',
      'objects.moveFolder' => 'Carpeta de destino',
      'objects.moveNoFolders' => 'No hay subcarpetas',
      'objects.moveHere' => 'Mover aquí',
      'objects.moveHelper' => ({
        required Object path,
      }) => 'Se moverán a ${path}. Si ya hay objetos con esos nombres, se sustituyen.',
      'objects.moveSameFolder' => 'Ya están en esta carpeta. Elige otra.',
      'objects.moved' =>
        ({required num count}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
              count,
              one: '1 objeto movido',
              other: '${count} objetos movidos',
            ),
      'objects.movePartial' => ({
        required Object moved,
        required Object total,
      }) => 'Solo se movieron ${moved} de ${total} objetos.',
      'objects.detailsSubtitle' => ({
        required Object type,
        required Object size,
      }) => '${type} · ${size}',
      'objects.detailsKey' => 'Key',
      'objects.detailsType' => 'Tipo',
      'objects.detailsSize' => 'Tamaño',
      'objects.detailsSizeBytes' => ({
        required Object bytes,
      }) => '(${bytes} bytes)',
      'objects.detailsModified' => 'Modificado',
      'objects.detailsUrl' => 'URL',
      'objects.detailsCopyUrl' => 'Copiar URL',
      'objects.detailsUrlCopied' => 'URL copiada',
      'objects.pageSize' => 'Filas por página:',
      'objects.pageOf' => ({
        required Object page,
        required Object total,
      }) => 'Página ${page} de ${total}',
      'objects.previousPage' => 'Página anterior',
      'objects.nextPage' => 'Página siguiente',
      'objects.pagerHint' =>
        'La búsqueda y los filtros solo se aplican a las páginas ya cargadas.',
      'objects.pagerHintPages' => ({
        required Object loaded,
        required Object total,
      }) => 'La búsqueda y los filtros solo se aplican a las páginas ya cargadas (${loaded} de ${total}).',
      'objects.shareLink' => 'Compartir enlace',
      'objects.shareLinkDescription' => ({
        required Object name,
      }) => 'Cualquiera con el enlace podrá descargar ${name} hasta que caduque, sin iniciar sesión.',
      'objects.shareLinkExpiresIn' => 'Caduca en',
      'objects.shareLinkHour' => '1 hora',
      'objects.shareLinkDay' => '1 día',
      'objects.shareLinkWeek' => '7 días',
      'objects.shareLinkValidUntil' => ({
        required Object date,
      }) => 'Válido hasta el ${date}',
      'objects.shareLinkCopy' => 'Copiar enlace',
      'objects.shareLinkCopied' => 'Enlace copiado',
      'colors.none' => 'Sin color',
      'colors.custom' => 'Color personalizado',
      'colors.apply' => 'Aplicar',
      'colors.saturationBrightness' => 'Saturación y brillo',
      'colors.hue' => 'Tono',
      'colors.contrast' => ({
        required Object ratio,
      }) => 'Contraste con el icono: ${ratio}:1',
      'colors.contrastLow' => ({
        required Object ratio,
      }) => 'Poco contraste con el icono (${ratio}:1)',
      'colors.hexInvalid' =>
        'Escribe un color HEX de 6 dígitos, por ejemplo #0E7490',
      'colors.violet' => 'Violeta',
      'colors.blue' => 'Azul',
      'colors.teal' => 'Verde azulado',
      'colors.green' => 'Verde',
      'colors.amber' => 'Ámbar',
      'colors.red' => 'Rojo',
      'colors.pink' => 'Rosa',
      'colors.slate' => 'Pizarra',
      'bucketAdmin.count' =>
        ({required num count}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
              count,
              one: '1 bucket',
              other: '${count} buckets',
            ),
      'bucketAdmin.stats' =>
        ({required num count, required Object size}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
              count,
              one: '1 objeto · ${size}',
              other: '${count} objetos · ${size}',
            ),
      'bucketAdmin.noBucketsDescription' =>
        'Crea un bucket para configurarlo aquí.',
      'bucketAdmin.openInBrowser' => 'Abrir en el explorador',
      'bucketAdmin.tabGeneral' => 'General',
      'bucketAdmin.tabAccess' => 'Acceso anónimo',
      'bucketAdmin.tabDanger' => 'Zona de peligro',
      'bucketAdmin.detailObjects' => 'Objetos',
      'bucketAdmin.detailSize' => 'Tamaño',
      'bucketAdmin.detailCreated' => 'Creado',
      'bucketAdmin.detailLastModified' => 'Última modificación',
      'bucketAdmin.detailNeverModified' => 'Sin objetos',
      'bucketAdmin.detailName' => 'Nombre',
      'bucketAdmin.detailS3Path' => 'Ruta S3',
      'bucketAdmin.detailCopyPath' => 'Copiar ruta',
      'bucketAdmin.detailPathCopied' => 'Ruta copiada',
      'bucketAdmin.detailDescription' => 'Descripción',
      'bucketAdmin.detailNoDescription' => 'Sin descripción',
      'bucketAdmin.detailColor' => 'Color',
      'bucketAdmin.emptyTitle' => 'Vaciar bucket',
      'bucketAdmin.emptyAlreadyEmpty' => 'El bucket no tiene objetos.',
      'bucketAdmin.emptyDescription' =>
        ({
          required num count,
          required Object size,
        }) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
          count,
          one:
              'Elimina su único objeto (${size}). El bucket, su configuración y sus reglas de acceso se mantienen. No se puede deshacer.',
          other:
              'Elimina sus ${count} objetos (${size}). El bucket, su configuración y sus reglas de acceso se mantienen. No se puede deshacer.',
        ),
      'bucketAdmin.emptyConfirm' =>
        ({
          required num count,
          required Object size,
          required Object name,
        }) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
          count,
          one:
              'Se eliminará 1 objeto (${size}) de ${name}. No se puede deshacer.',
          other:
              'Se eliminarán ${count} objetos (${size}) de ${name}. No se puede deshacer.',
        ),
      'bucketAdmin.emptyTypeName' => ({
        required Object name,
      }) => 'Escribe ${name} para confirmar',
      'bucketAdmin.emptyTypeNameHelper' =>
        'El botón se activa cuando el nombre coincide.',
      'bucketAdmin.deleteDescription' => 'Borra el bucket con su descripción, color y reglas de acceso. Como en S3, solo se puede eliminar si está vacío.',
      'bucketAdmin.deleteNotEmpty' =>
        ({required num count}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
              count,
              one: 'El bucket tiene 1 objeto. Vacíalo primero.',
              other: 'El bucket tiene ${count} objetos. Vacíalo primero.',
            ),
      'anonymousAccess.description' => 'Cada regla deja un prefijo accesible sin credenciales. Lo que no cubre ninguna regla sigue necesitando autenticación.',
      'anonymousAccess.privateTitle' => 'Bucket privado',
      'anonymousAccess.privateDescription' => 'Todas las peticiones necesitan credenciales. Añade una regla para servir un prefijo sin autenticación, por ejemplo las imágenes de una web.',
      'anonymousAccess.readOnly' => 'Solo lectura',
      'anonymousAccess.writeOnly' => 'Solo escritura',
      'anonymousAccess.readWrite' => 'Lectura y escritura',
      'anonymousAccess.readOnlyOps' => 'Listar y descargar objetos',
      'anonymousAccess.writeOnlyOps' => 'Subir y borrar objetos',
      'anonymousAccess.readWriteOps' => 'Listar, descargar, subir y borrar',
      'anonymousAccess.readOnlyDescription' =>
        'Cualquiera puede listar y descargar.',
      'anonymousAccess.writeOnlyDescription' =>
        'Cualquiera puede subir y borrar, pero no ver.',
      'anonymousAccess.readWriteDescription' =>
        'Acceso completo sin credenciales.',
      'anonymousAccess.readOnlyUseCase' =>
        'Webs, catálogos, descargas públicas.',
      'anonymousAccess.writeOnlyUseCase' => 'Buzones de subida, formularios.',
      'anonymousAccess.readWriteUseCase' =>
        'Úsalo solo en prefijos temporales.',
      'anonymousAccess.ruleAdd' => 'Añadir regla',
      'anonymousAccess.rulePrefix' => 'Prefijo',
      'anonymousAccess.ruleAccess' => 'Acceso',
      'anonymousAccess.ruleOps' => 'Operaciones sin credenciales',
      'anonymousAccess.ruleHint' => 'Los prefijos son relativos al bucket y admiten * como comodín. Si varias reglas coinciden, se aplica la primera.',
      'anonymousAccess.ruleDeleteTitle' => 'Eliminar regla',
      'anonymousAccess.ruleDeleteConfirm' => ({
        required Object prefix,
      }) => '¿Seguro que quieres eliminar la regla ${prefix}? Los objetos de ese prefijo volverán a necesitar credenciales.',
      'anonymousAccess.ruleFormTitle' => 'Añadir regla de acceso',
      'anonymousAccess.ruleFormDescription' => ({
        required Object bucket,
      }) => 'Deja un prefijo de ${bucket} accesible sin credenciales.',
      'anonymousAccess.ruleFormSectionPrefix' => '01 Prefijo',
      'anonymousAccess.ruleFormSectionAccess' => '02 Tipo de acceso',
      'anonymousAccess.rulePrefixLabel' => 'Prefijo o patrón',
      'anonymousAccess.rulePrefixHint' => 'public/',
      'anonymousAccess.rulePrefixHelper' => 'Sin *, cubre todo lo que empieza así (termina en / para una carpeta). Con *, tiene que coincidir la key entera (por ejemplo, *.jpg solo cubre ficheros .jpg), y solo abre los listados si termina en *.',
      'anonymousAccess.rulePrefixRequired' => 'El prefijo es obligatorio',
      'anonymousAccess.ruleFormErrorTitle' => 'No se pudo añadir la regla',
      'anonymousAccess.ruleCreatedSuccess' => ({
        required Object prefix,
      }) => 'Regla ${prefix} añadida',
      'browser.bucketNotFound' => ({
        required Object name,
      }) => 'El bucket «${name}» no existe',
      'browser.bucketNotFoundDescription' =>
        'Puede que lo hayan borrado o que el enlace esté mal escrito.',
      'browser.backToBuckets' => 'Ver buckets',
      'browser.folderNotFound' => ({
        required Object folder,
      }) => 'La carpeta «${folder}» no existe en este bucket',
      'browser.folderNotFoundDescription' => 'Puede que la hayan borrado o que la ruta esté mal escrita. En S3 una carpeta solo existe mientras tiene objetos.',
      'browser.goToBucketRoot' => 'Ir a la raíz del bucket',
      'transfers.title' => 'Transferencias',
      'transfers.active' =>
        ({required num count}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
              count,
              one: '1 transferencia en curso',
              other: '${count} transferencias en curso',
            ),
      'transfers.failed' =>
        ({required num count}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
              count,
              one: '1 transferencia con error',
              other: '${count} transferencias con error',
            ),
      'transfers.allDone' => 'Todas las transferencias han terminado',
      'transfers.empty' => 'Aún no hay transferencias. Las subidas y descargas siguen en segundo plano mientras usas la consola.',
      'transfers.uploadsAdded' =>
        ({required num count}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
              count,
              one: '1 fichero añadido a las transferencias',
              other: '${count} ficheros añadidos a las transferencias',
            ),
      'transfers.downloadAdded' => ({
        required Object name,
      }) => 'Descargando ${name} en segundo plano',
      'transfers.clearFinished' => 'Limpiar terminadas',
      'transfers.upload' => 'Subida',
      'transfers.download' => 'Descarga',
      'transfers.statusQueued' => 'En cola',
      'transfers.statusPreparing' => 'Preparando el zip…',
      'transfers.statusProgress' => ({
        required Object done,
        required Object total,
        required Object percent,
      }) => '${done} de ${total} · ${percent}%',
      'transfers.statusUploaded' => ({
        required Object size,
      }) => 'Subido · ${size}',
      'transfers.statusDownloaded' => ({
        required Object size,
      }) => 'Descargado · ${size}',
      'transfers.statusFailed' => ({
        required Object message,
      }) => 'Error: ${message}',
      'transfers.statusCancelled' => 'Cancelada',
      'transfers.cancel' => 'Cancelar',
      'transfers.remove' => 'Quitar de la lista',
      'accessKeys.description' => 'Cada clave deja entrar a un cliente S3 (AWS CLI, rclone, SDKs) solo en los buckets que le des.',
      'accessKeys.secretOnce' => 'El secreto se muestra una sola vez, al crear la clave o al regenerarlo.',
      'accessKeys.searchHint' => 'Buscar por nombre o ID...',
      'accessKeys.create' => 'Crear clave',
      'accessKeys.columnName' => 'Nombre',
      'accessKeys.columnId' => 'Access key ID',
      'accessKeys.columnPermissions' => 'Permisos',
      'accessKeys.columnLastUsed' => 'Último uso',
      'accessKeys.columnStatus' => 'Estado',
      'accessKeys.rootName' => 'Clave raíz',
      'accessKeys.rootBadge' => 'Raíz',
      'accessKeys.rootPermissions' => 'Todo, incluida la consola',
      'accessKeys.rootLocked' => 'Se configura con FEATHER_ACCESS y FEATHER_SECRET: no se puede editar ni eliminar',
      'accessKeys.createdOn' => ({required Object date}) => 'Creada el ${date}',
      'accessKeys.copyId' => 'Copiar ID',
      'accessKeys.idCopied' => 'ID copiado',
      'accessKeys.allBuckets' => 'Todos',
      'accessKeys.noBuckets' => 'Ningún bucket: edítala para darle acceso',
      'accessKeys.createsBuckets' => '+ crear buckets',
      'accessKeys.levelReadOnly' => 'Solo lectura',
      'accessKeys.levelWriteOnly' => 'Solo escritura',
      'accessKeys.levelReadWrite' => 'Lectura y escritura',
      'accessKeys.levelShortRead' => 'Lectura',
      'accessKeys.levelShortWrite' => 'Escritura',
      'accessKeys.levelShortBoth' => 'Ambos',
      'accessKeys.levelReadOnlyDescription' => 'Listar y descargar objetos.',
      'accessKeys.levelWriteOnlyDescription' =>
        'Subir y borrar objetos, sin verlos.',
      'accessKeys.levelReadWriteDescription' =>
        'Listar, descargar, subir y borrar objetos.',
      'accessKeys.statusActive' => 'Activa',
      'accessKeys.statusDisabled' => 'Desactivada',
      'accessKeys.statusExpired' => 'Caducada',
      'accessKeys.expiresOn' => ({required Object date}) => 'Caduca el ${date}',
      'accessKeys.expiredOn' => ({required Object date}) => 'Caducó el ${date}',
      'accessKeys.neverUsed' => 'Nunca',
      'accessKeys.usedNow' => 'Ahora mismo',
      'accessKeys.usedMinutes' => ({
        required Object count,
      }) => 'Hace ${count} min',
      'accessKeys.usedHours' => ({required Object count}) => 'Hace ${count} h',
      'accessKeys.usedDays' =>
        ({required num count}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('es'))(
              count,
              one: 'Hace 1 día',
              other: 'Hace ${count} días',
            ),
      'accessKeys.actions' => ({required Object name}) => 'Acciones de ${name}',
      'accessKeys.editPermissions' => 'Editar permisos',
      'accessKeys.regenerateSecret' => 'Regenerar secreto',
      'accessKeys.disable' => 'Desactivar',
      'accessKeys.enable' => 'Activar',
      'accessKeys.footerHint' => 'Las claves solo sirven para clientes S3: la consola se abre con la clave raíz. Una clave desactivada o caducada responde 403 InvalidAccessKeyId.',
      'accessKeys.emptyTitle' => 'Solo existe la clave raíz',
      'accessKeys.emptyDescription' => 'Crea una clave para cada cliente o aplicación, con acceso solo a sus buckets. Así puedes revocarla sin tocar las demás.',
      'accessKeys.createFirst' => 'Crear la primera clave',
      'accessKeys.noMatch' =>
        'Ninguna clave coincide con la búsqueda o los filtros',
      'accessKeys.filterStatus' => 'Estado',
      'accessKeys.filterLevel' => 'Nivel',
      'accessKeys.filterBucket' => 'Bucket',
      'accessKeys.deleteTitle' => 'Eliminar clave',
      'accessKeys.deleteConfirm' => ({
        required Object name,
      }) => '¿Seguro que quieres eliminar la clave ${name}? Los clientes que la usen recibirán 403 al momento. Si solo quieres pausarla, desactívala.',
      'accessKeys.regenerateTitle' => 'Regenerar secreto',
      'accessKeys.regenerateConfirm' => ({
        required Object name,
      }) => '¿Generar un secreto nuevo para ${name}? El actual deja de funcionar al momento.',
      'accessKeys.regenerate' => 'Regenerar',
      'accessKeys.deletedSuccess' => ({
        required Object name,
      }) => 'Clave ${name} eliminada',
      'accessKeys.disabledSuccess' => ({
        required Object name,
      }) => 'Clave ${name} desactivada',
      'accessKeys.enabledSuccess' => ({
        required Object name,
      }) => 'Clave ${name} activada',
      'accessKeys.savedSuccess' => ({
        required Object name,
      }) => 'Clave ${name} guardada',
      'accessKeys.formCreateTitle' => 'Crear clave de acceso',
      'accessKeys.formEditTitle' => 'Editar clave de acceso',
      'accessKeys.formCreateDescription' =>
        'El ID y el secreto se generan al crearla.',
      'accessKeys.formEditDescription' => ({
        required Object id,
      }) => '${id}. El secreto no cambia.',
      'accessKeys.formSectionIdentity' => '01 Identificación',
      'accessKeys.formSectionScope' => '02 Alcance',
      'accessKeys.formSectionPermissions' => '03 Permisos',
      'accessKeys.nameLabel' => 'Nombre',
      'accessKeys.nameHint' => 'Backups NAS',
      'accessKeys.nameRequired' => 'Ponle un nombre a la clave',
      'accessKeys.expiryLabel' => 'Caducidad',
      'accessKeys.expiryNever' => 'Nunca caduca',
      'accessKeys.expiry30Days' => 'En 30 días',
      'accessKeys.expiry90Days' => 'En 90 días',
      'accessKeys.expiryYear' => 'En 1 año',
      'accessKeys.expiryKeep' => ({
        required Object date,
      }) => 'Mantener: ${date}',
      'accessKeys.scopeAll' => 'Todos los buckets',
      'accessKeys.scopeAllDescription' => 'También los que se creen después. Con escritura, además puede crear y eliminar buckets.',
      'accessKeys.scopeSome' => 'Buckets concretos',
      'accessKeys.scopeSomeDescription' =>
        'Solo los que marques, cada uno con su nivel. Solo ve esos al listar.',
      'accessKeys.bucketsChecked' => ({
        required Object count,
        required Object total,
      }) => '${count} de ${total} marcados',
      'accessKeys.bucketsRequired' => 'Marca al menos un bucket',
      'accessKeys.bucketsEmpty' =>
        'Aún no hay buckets: crea uno, o dale a la clave todos los buckets.',
      'accessKeys.formErrorTitle' => 'No se pudo guardar la clave',
      'accessKeys.secretCreatedTitle' => ({
        required Object name,
      }) => 'Clave creada: ${name}',
      'accessKeys.secretRegeneratedTitle' => ({
        required Object name,
      }) => 'Secreto nuevo: ${name}',
      'accessKeys.secretWarning' => 'Copia el secreto ahora: es la única vez que se muestra. Si lo pierdes, tendrás que regenerarlo.',
      'accessKeys.secretLabel' => 'Secret access key',
      'accessKeys.copySecret' => 'Copiar secreto',
      'accessKeys.secretCopied' => 'Secreto copiado',
      'accessKeys.downloadCsv' => 'Descargar como .csv',
      'accessKeys.secretSaved' => 'He guardado el secreto en un lugar seguro',
      _ => null,
    };
  }
}
