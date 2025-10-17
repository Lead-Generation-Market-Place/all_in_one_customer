import 'package:dartz/dartz.dart';
import 'package:yelpax/core/network/network_info.dart';
import 'package:yelpax/features/home_services/data/models/home_service_promotion_model.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_entity.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_fetch_professionals_entity.dart';
import '../../../../core/error/exceptions/exceptions.dart';
import '../../../../core/error/failures/failure.dart';
import '../datasources/home_services_remote_data_source.dart';
import '../../domain/repositories/home_services_repository.dart';

class HomeServicesRepositoryImpl implements HomeServicesRepository {
  final HomeServicesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  HomeServicesRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<HomeServicesEntity>>> fetchServicesQuery(
    String query,
  ) async {
    try {
      final result = await remoteDataSource.fetchServicesQuery(query);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(GenericFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<HomeServicesEntity>>> getHomeServices() async {
    try {
      final models = await remoteDataSource.fetchHomeServices();
      if (!await networkInfo.isConnected) {
        return Left(NoInternetFailure('No Internet Connection'));
      }
      return Right(models);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on CustomDioException catch (e) {
      return Left(DioFailure(e.message));
    } catch (e) {
      return Left(GenericFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<HomeServicePromotionModel>>>
  getPromotions() async {
    try {
      final models = await remoteDataSource.fetchPromotions();
      if (!await networkInfo.isConnected) {
        return Left(NoInternetFailure('No Internet Connection'));
      }
      return Right(models);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on CustomDioException catch (e) {
      return Left(DioFailure(e.message));
    } catch (e) {
      return Left(GenericFailure(e.toString()));
    }
  }

   

  @override
  Future<Either<Failure, List<HomeServicesFetchProfessionalsEntity>>> fetchPros(String query) async{
      try {
      final models = await remoteDataSource.findPros(query);
      if (!await networkInfo.isConnected) {
        return Left(NoInternetFailure('No Internet Connection'));
      }
      return Right(models);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on CustomDioException catch (e) {
      return Left(DioFailure(e.message));
    } catch (e) {
      return Left(GenericFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, List<HomeServicesFetchProfessionalsEntity>>> fetchProsByServiceIdAndZip(String serviceId, String zipCode) async{
      try {
      final models = await remoteDataSource.fetchProsByServiceAndZip(serviceId,zipCode);
      if (!await networkInfo.isConnected) {
        return Left(NoInternetFailure('No Internet Connection'));
      }
      return Right(models);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on CustomDioException catch (e) {
      return Left(DioFailure(e.message));
    } catch (e) {
      return Left(GenericFailure(e.toString()));
    }
  }
  
  

}
