import 'package:dartz/dartz.dart';
import 'package:yelpax/core/error/exceptions/exceptions.dart';
import 'package:yelpax/core/error/failures/failure.dart';
import 'package:yelpax/features/home_services/data/datasources/home_services_remote_data_source.dart';
import 'package:yelpax/features/home_services/domain/entities/professional.dart';
import 'package:yelpax/features/home_services/domain/repositories/home_services_repository.dart';

class HomeServicesRepositoryImpl implements HomeServicesRepository {
  final HomeServicesRemoteDataSource remoteDataSource;
  HomeServicesRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Professional>>> searchProfessionals(
    String query,
  ) async {
    try {
      final result = await remoteDataSource.searchProfessionals(query);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(GenericFailure(e.toString()));
    }
  }
}
