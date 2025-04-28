import 'package:get_it/get_it.dart';
import 'package:t_store_admin_panel/core/shared/widgets/layouts/sidebars/sidebar_cubit.dart';
import 'package:t_store_admin_panel/core/utils/storage/cache_storage_mangement.dart'
    show CacheStorageManagementImpl;
import 'package:t_store_admin_panel/core/utils/utils/constants/collection_constants.dart';
import 'package:t_store_admin_panel/data/abstract/repos/generic_repository.dart';
import 'package:t_store_admin_panel/data/abstract/repos/generic_repository_impl.dart';
import 'package:t_store_admin_panel/data/models/banners/banner_model.dart';
import 'package:t_store_admin_panel/data/repositories/authentication/authentication_repo_impl.dart';
import 'package:t_store_admin_panel/data/repositories/brands/brand_repo.dart';
import 'package:t_store_admin_panel/data/repositories/category/category_repo_impl.dart';
import 'package:t_store_admin_panel/data/repositories/media/media_repository_impl.dart';
import 'package:t_store_admin_panel/data/repositories/user/user_repo_impl.dart';
import 'package:t_store_admin_panel/data/services/abstract/generic_fire_base_services_impl.dart';
import 'package:t_store_admin_panel/data/services/abstract/generic_firebase_services.dart';
import 'package:t_store_admin_panel/data/services/authentication/authentication_firebase_services.dart';
import 'package:t_store_admin_panel/data/services/authentication/authentication_firestore_service.dart';
import 'package:t_store_admin_panel/data/services/brands/brand_firebase_services.dart';
import 'package:t_store_admin_panel/data/services/category/category_firebase_services.dart';
import 'package:t_store_admin_panel/data/services/media/media_firebase_services.dart';
import 'package:t_store_admin_panel/data/services/user/user_firebase_services.dart';
import 'package:t_store_admin_panel/data/services/user/user_manager.dart';
import 'package:t_store_admin_panel/domain/repositories/authentication/authentication_repo.dart';
import 'package:t_store_admin_panel/domain/repositories/category/category_repo.dart';
import 'package:t_store_admin_panel/domain/repositories/media/media_repository.dart';
import 'package:t_store_admin_panel/domain/repositories/user/user_repo.dart';
import 'package:t_store_admin_panel/features/authentiacation/presentation/cubit/sign_in/sign_in_cubit.dart';
import 'package:t_store_admin_panel/features/authentiacation/presentation/cubit/user/cubit/user_cubit.dart';
import 'package:t_store_admin_panel/features/banners/cubits/banners/banner_cubit.dart';
import 'package:t_store_admin_panel/features/banners/cubits/create_banner/create_banner_cubit.dart';
import 'package:t_store_admin_panel/features/brands/presentation/cubits/brand_cubit.dart';
import 'package:t_store_admin_panel/features/brands/presentation/screens/create_brands/cubits/create_brand_cubit.dart';
import 'package:t_store_admin_panel/features/brands/presentation/screens/edit_brands/cubit/edit_brand_cubit.dart';
import 'package:t_store_admin_panel/features/categories/cubits/category/category_cubit.dart';
import 'package:t_store_admin_panel/features/categories/cubits/create_category/create_category_cubit.dart';
import 'package:t_store_admin_panel/features/categories/cubits/edit_category/edit_category_cubit.dart';
import 'package:t_store_admin_panel/features/dashboard/presentation/cubits/cubit/dashboard_cubit.dart';
import 'package:t_store_admin_panel/features/media/cubits/actions/media_action_cubit.dart';
import 'package:t_store_admin_panel/features/media/cubits/media/media_cubit.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  // UserManager
  getIt.registerLazySingleton<UserManager>(() => UserManager());

  /// ----Authentication----
  // Firebase Services
  getIt.registerFactory<AuthFirebaseServices>(
    () => AuthFirebaseServicesImpl(getIt<UserManager>()),
  );
  getIt.registerFactory<AuthFirestoreService>(
    () => AuthFirestoreServiceImpl(getIt<UserManager>()),
  );
  // Repositories
  getIt.registerFactory<AuthenticationRepo>(
    () => AuthenticationRepoImpl(getIt<AuthFirebaseServices>()),
  );
  // Managers
  getIt.registerFactory<SignInCubit>(
    () =>
        SignInCubit(getIt<AuthenticationRepo>(), getIt<AuthFirestoreService>()),
  );

  /// ----User----
  // Firebase Services
  getIt.registerFactory<UserFirebaseServices>(
    () => UserFirebaseServicesImpl(getIt<UserManager>()),
  );
  // Repositories
  getIt.registerFactory<UserRepo>(
    () => UserRepoImpl(getIt<UserFirebaseServices>()),
  );
  // Managers
  getIt.registerLazySingleton<UserCubit>(() => UserCubit(getIt<UserRepo>()));

  /// ----Side Bar----
  getIt.registerLazySingleton<SidebarCubit>(() => SidebarCubit());

  /// ----Media----
  // Firebase Services
  getIt.registerLazySingleton<MediaFirebaseServices>(
    () => MediaFirebaseServicesImpl(),
  );

  // Repositories
  getIt.registerLazySingleton<MediaRepository>(
    () => MediaRepositoryImpl(getIt.get<MediaFirebaseServices>()),
  );

  // Manger
  getIt.registerLazySingleton<MediaCubit>(
    () => MediaCubit(getIt<MediaRepository>()),
  );
  getIt.registerLazySingleton<MediaActionCubit>(() => MediaActionCubit());

  getIt.registerFactory<DashboardCubit>(() => DashboardCubit());

  // Categories
  getIt.registerFactory<CategoryFirebaseServices>(
    () => CategoryFirebaseServicesImpl(),
  );
  getIt.registerFactory<CategoryRepo>(
    () => CategoryRepoImpl(getIt<CategoryFirebaseServices>()),
  );
  getIt.registerFactory<CategoryCubit>(
    () => CategoryCubit(getIt<CategoryRepo>()),
  );
  // create Category
  getIt.registerFactory<CreateCategoryCubit>(
    () => CreateCategoryCubit(getIt<CategoryRepo>()),
  );
  getIt.registerFactory<EditCategoryCubit>(
    () => EditCategoryCubit(getIt<CategoryRepo>()),
  );

  ///----Banners----
  // Register BaseFirebaseServices for Banners
  getIt.registerLazySingleton<GenericFirebaseServices<BannerModel>>(
    () => GenericFirebaseServicesImpl<BannerModel>(
      CollectionConstants.banners,
      (json, [id]) => BannerModel.fromMap(json, id),
      (banner) => banner.toJson(),
    ),
  );

  // Register BaseRepository for Banners
  getIt.registerLazySingleton<GenericRepository<BannerModel>>(
    () => GenericRepositoryImpl<BannerModel>(
      getIt<GenericFirebaseServices<BannerModel>>(),
    ),
  );

  // Register BannersCubit
  getIt.registerFactory<BannerCubit>(
    () => BannerCubit(getIt<GenericRepository<BannerModel>>()),
  );
  // Register CreateBannersCubit
  getIt.registerFactory<CreateBannerCubit>(
    () => CreateBannerCubit(
      GenericRepositoryImpl(
        GenericFirebaseServicesImpl(
          CollectionConstants.banners,
          (json, [id]) => BannerModel.fromMap(json, id),
          (banner) => banner.toJson(),
        ),
      ),
      CacheStorageManagementImpl(CollectionConstants.banners, 2),
    ),
  );

  /// ----Brands----
  // Register BaseFirebaseServices for Brands
  // getIt.registerLazySingleton<BrandsFirebaseServices>(
  //   () => BrandsFirebaseServices(
  //     GenericFirebaseServicesImpl<BrandModel>(
  //       CollectionConstants.brands,
  //       (json, [id]) => BrandModel.fromMap(json, id),
  //       (brand) => brand.toJson(),
  //     ),
  //   ),
  // );

  // Register BrandFirebaseServices
  getIt.registerLazySingleton<BrandFirebaseServices>(
    () => BrandFirebaseServicesImpl(),
  );

  // Register Brand Repository
  getIt.registerLazySingleton<BrandRepo>(
    () => BrandRepo(getIt<BrandFirebaseServices>()),
  );

  // Register Brand Cubit
  getIt.registerFactory<BrandCubit>(() => BrandCubit(getIt<BrandRepo>()));
  // Register Create Brand Cubit
  getIt.registerFactory<CreateBrandCubit>(
    () => CreateBrandCubit(getIt<BrandRepo>(), getIt<CategoryCubit>()),
  );
  // Register Edit Brand Cubit
  getIt.registerFactory<EditBrandCubit>(
    () => EditBrandCubit(getIt<BrandRepo>(), getIt<CategoryCubit>()),
  );
}

/// 🔄 Reset the user manager after logout
void resetUserManager() {
  if (getIt.isRegistered<UserManager>()) {
    getIt.unregister<UserManager>();
  }
  getIt.registerLazySingleton<UserManager>(() => UserManager());
}

/// 🔄 Reset the user cubit after logout
void resetUserCubit() {
  if (getIt.isRegistered<UserCubit>()) {
    getIt.unregister<UserCubit>();
  }
  getIt.registerLazySingleton<UserCubit>(() => UserCubit(getIt<UserRepo>()));
}
