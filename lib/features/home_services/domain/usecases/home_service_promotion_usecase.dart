import 'package:dartz/dartz.dart';
import 'package:yelpax/core/error/failures/failure.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_promotion_entity.dart';
import 'package:yelpax/features/home_services/domain/repositories/home_service_promotion_repository.dart';

class HomeServicePromotionUsecase {
  HomeServicePromotionRepository homeServicePromotionRepository;

  HomeServicePromotionUsecase(this.homeServicePromotionRepository);

  Future<Either<Failure, List<HomeServicesPromotionEntity>>> call() {
    return homeServicePromotionRepository.getHomeServicePromotions();
  }
}
