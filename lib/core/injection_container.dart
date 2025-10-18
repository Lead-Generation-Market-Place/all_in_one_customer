//the core injection container which can be used for network
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:yelpax/core/auth/auth_manager.dart';
import 'package:yelpax/core/network/endpoints.dart';
import 'package:yelpax/core/storage/secure_storage_service.dart';
import 'package:yelpax/features/home_services/data/datasources/home_services_location_local_data_source.dart';
import 'package:yelpax/features/home_services/data/datasources/home_services_remote_data_source.dart';
import 'package:yelpax/features/home_services/data/repositories/home_services_repository_impl.dart';
import 'package:yelpax/features/home_services/domain/repositories/home_services_repository.dart';
import 'package:yelpax/features/home_services/domain/usecases/home_services_findpros_usecase.dart';
import 'package:yelpax/features/home_services/domain/usecases/home_services_get_current_location_usecase.dart';
import 'package:yelpax/features/home_services/domain/usecases/home_services_promotions_usecase.dart';
import 'package:yelpax/features/home_services/domain/usecases/home_services_usecase.dart';
import 'package:yelpax/features/home_services/domain/usecases/fetch_services_query_usecase.dart';
import 'package:yelpax/features/home_services/presentation/controllers/home_services_controller.dart';
import 'package:yelpax/features/home_services/presentation/controllers/home_services_promotion_controller.dart';
import 'package:yelpax/features/home_services/presentation/controllers/fetch_services_query_controller.dart';
import 'package:yelpax/features/home_services/sub_features/service_professionals_id_zipcode/controllers/home_services_findpros_controller.dart';
import 'package:yelpax/features/signin/data/datasources/auth_remote_data_source.dart';
import 'package:yelpax/features/signin/data/repositories/auth_repository_impl.dart';
import 'package:yelpax/features/signin/domain/repositories/auth_repository.dart';
import 'package:yelpax/features/signin/domain/usecases/sign_in_usecase.dart';
import 'package:yelpax/features/signin/presentation/controllers/sign_in_controller.dart';

import '../features/home_services/presentation/controllers/home_services_location_controller.dart';
import 'network/dio_client.dart';
import 'network/network_info.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  //! External packages
  getIt.registerLazySingleton(() => Logger());
  getIt.registerLazySingleton(() => Connectivity());

  //! Core Network
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectivity: getIt<Connectivity>()),
  );
  //! core secure storage
  getIt.registerLazySingleton<LocalStorageService>(
    () => SecureStorageService(),
  );
  //! Dio Client
  getIt.registerLazySingleton(
    () => Dio(
      BaseOptions(
        baseUrl: Endpoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    ),
  );
  getIt.registerLazySingleton(
    () => DioClient(dio: getIt<Dio>(), logger: getIt<Logger>()),
  );
  //login feature
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(dioClient: getIt<DioClient>()),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt<AuthRemoteDataSource>(),
      localStorageService: getIt<LocalStorageService>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );

  //auth manager or wrapper
  getIt.registerLazySingleton<AuthManager>(
    () => AuthManager(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<SignInUseCase>(
    () => SignInUseCase(repository: getIt<AuthRepository>()),
  );
  getIt.registerFactory<SignInController>(
    () => SignInController(signInUseCase: getIt<SignInUseCase>()),
  );

  //Local Data Source
  getIt.registerLazySingleton<HomeServicesLocationLocalDataSource>(
    () => HomeServicesLocationLocalDataSourceImpl(),
  );
  //home services di

  getIt.registerLazySingleton<HomeServicesRemoteDataSource>(
    () => HomeServicesRemoteDataSourceImpl(dioClient: getIt<DioClient>()),
  );
  getIt.registerLazySingleton<HomeServicesRepository>(
    () => HomeServicesRepositoryImpl(
      remoteDataSource: getIt<HomeServicesRemoteDataSource>(),
      locationLocalDataSource: getIt<HomeServicesLocationLocalDataSource>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );
  getIt.registerLazySingleton<HomeServicesUsecase>(
    () => HomeServicesUsecase(
      homeServicesRepository: getIt<HomeServicesRepository>(),
    ),
  );
  getIt.registerFactory<HomeServicesController>(
    () => HomeServicesController(
      homeServicesUsecase: getIt<HomeServicesUsecase>(),
    ),
  );

  //promotions
  getIt.registerLazySingleton<HomeServicesPromotionsUsecase>(
    () => HomeServicesPromotionsUsecase(
      repository: getIt<HomeServicesRepository>(),
    ),
  );
  getIt.registerFactory<HomeServicesPromotionController>(
    () => HomeServicesPromotionController(
      usecase: getIt<HomeServicesPromotionsUsecase>(),
    ),
  );

  //Find Pros

  getIt.registerLazySingleton<HomeServicesFindprosUsecase>(
    () => HomeServicesFindprosUsecase(
      repository: getIt<HomeServicesRepository>(),
    ),
  );
  getIt.registerFactory<HomeServicesFindprosController>(
    () => HomeServicesFindprosController(
      usecase: getIt<HomeServicesFindprosUsecase>(),
    ),
  );

  //home services search professional di
  getIt.registerLazySingleton<SearchProfessionalUsecase>(
    () =>
        SearchProfessionalUsecase(repository: getIt<HomeServicesRepository>()),
  );
  getIt.registerFactory<FetchServicesQueryController>(
    () => FetchServicesQueryController(
      searchProfessionalUsecase: getIt<SearchProfessionalUsecase>(),
    ),
  );

  getIt.registerLazySingleton<HomeServicesGetCurrentLocationUsecase>(
    () => HomeServicesGetCurrentLocationUsecase(
      repository: getIt<HomeServicesRepository>(),

    ),
  );
  getIt.registerFactory<HomeServicesLocationController>(
    () => HomeServicesLocationController(
      getCurrentLocationUsecase: getIt<HomeServicesGetCurrentLocationUsecase>(),
    ),
  );
}
