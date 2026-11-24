import 'package:service/feather.dart';

/// Repos, services and controllers, each found once with `di.find()`: none is
/// built by hand. In order (each finds the ones above it, lazily); start()
/// calls it after the infrastructure (database, cipher, JWT, rate limiter).
void registerDependencies() {
  di
    //--------------- Repos ---------------\\
    ..putLazy<BucketTableRepo>(() => BucketTableRepo(di.find()))
    ..putLazy<ObjectMetaTableRepo>(() => ObjectMetaTableRepo(di.find()))
    ..putLazy<AnonymousRuleTableRepo>(() => AnonymousRuleTableRepo(di.find()))
    ..putLazy<AccessKeyTableRepo>(() => AccessKeyTableRepo(di.find()))
    //--------------- Services ---------------\\
    ..putLazy<ObjectMetaService>(ObjectMetaService.new)
    ..putLazy<ObjectService>(ObjectService.new)
    ..putLazy<BucketService>(BucketService.new)
    ..putLazy<MultipartService>(MultipartService.new)
    ..putLazy<PresignService>(PresignService.new)
    ..putLazy<AnonymousAccessService>(AnonymousAccessService.new)
    ..putLazy<AccessKeyService>(AccessKeyService.new)
    ..putLazy<AuthService>(AuthService.new)
    //--------------- Controllers ---------------\\
    ..putLazy<AuthController>(AuthController.new)
    ..putLazy<BucketAdminController>(BucketAdminController.new)
    ..putLazy<AnonymousAccessController>(AnonymousAccessController.new)
    ..putLazy<AccessKeyController>(AccessKeyController.new)
    ..putLazy<BucketController>(BucketController.new)
    ..putLazy<ObjectController>(ObjectController.new)
    ..putLazy<MultipartController>(MultipartController.new);
}
