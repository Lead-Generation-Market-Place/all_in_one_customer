import 'package:dartz/dartz.dart';
import 'package:yelpax/core/error/failures/failure.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_promotion_entity.dart';

abstract class HomeServicePromotionRepository {
  Future<Either<Failure, List<HomeServicesPromotionEntity>>>
  getHomeServicePromotions();
}
