//the core injection container which can be used for network
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:yelpax/core/auth/auth_manager.dart';
import 'package:yelpax/core/network/endpoints.dart';
import 'package:yelpax/core/storage/secure_storage_service.dart';
import 'package:yelpax/features/signin/data/datasources/auth_remote_data_source.dart';
import 'package:yelpax/features/signin/data/repositories/auth_repository_impl.dart';
import 'package:yelpax/features/signin/domain/repositories/auth_repository.dart';
import 'package:yelpax/features/signin/domain/usecases/sign_in_usecase.dart';
import 'package:yelpax/features/signin/presentation/controllers/sign_in_controller.dart';

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
  getIt.registerLazySingleton<SignInUseCase>(
    () => SignInUseCase(repository: getIt<AuthRepository>()),
  );
  getIt.registerFactory<SignInController>(
    () => SignInController(signInUseCase: getIt<SignInUseCase>()),
  );

//auth manager or wrapper
  getIt.registerLazySingleton<AuthManager>(() => AuthManager(getIt<AuthRepository>()),);

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
}
