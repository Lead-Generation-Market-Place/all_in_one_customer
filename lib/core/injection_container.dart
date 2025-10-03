//the core injection container which can be used for network
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:yelpax/core/network/endpoints.dart';

import 'network/dio_client.dart';
import 'network/network_info.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  //! External packages
  getIt.registerLazySingleton(() => Logger());
  getIt.registerLazySingleton(() => Connectivity());

  //! Core
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectivity: getIt<Connectivity>()),
  );

  //! Dio Client
  getIt.registerLazySingleton(() => Dio(BaseOptions(
    baseUrl: Endpoints.baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  )));

  getIt.registerLazySingleton(() => DioClient(
    dio: getIt<Dio>(),
    logger: getIt<Logger>(),
  ));
}