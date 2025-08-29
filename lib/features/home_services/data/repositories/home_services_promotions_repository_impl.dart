import 'package:dartz/dartz.dart';
import 'package:yelpax/core/error/exceptions/exceptions.dart';
import 'package:yelpax/core/error/failures/failure.dart';
import 'package:yelpax/features/home_services/data/datasources/home_services_promotion_remote_data_source.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_promotion_entity.dart';
import 'package:yelpax/features/home_services/domain/repositories/home_service_promotion_repository.dart';

class HomeServicesPromotionsRepositoryImpl
    implements HomeServicePromotionRepository {
  HomeServicesPromotionRemoteDataSourceImpl
  homeServicePromotionRemoteDataSource;

  HomeServicesPromotionsRepositoryImpl(
    this.homeServicePromotionRemoteDataSource,
  );

  @override
  Future<Either<Failure, List<HomeServicesPromotionEntity>>>
  getHomeServicePromotions() async {
    try {
      final result = await homeServicePromotionRemoteDataSource
          .searchPromotions();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(GenericFailure(e.toString()));
    }
  }
}
