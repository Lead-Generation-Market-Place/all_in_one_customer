import 'package:dartz/dartz.dart';
import '../../../../core/error/failures/failure.dart';
import '../entities/home_services_promotion_entity.dart';
import '../repositories/home_service_promotion_repository.dart';

class HomeServicePromotionUsecase {
  HomeServicePromotionRepository homeServicePromotionRepository;

  HomeServicePromotionUsecase(this.homeServicePromotionRepository);

  Future<Either<Failure, List<HomeServicesPromotionEntity>>> call() {
    return homeServicePromotionRepository.getHomeServicePromotions();
  }
}
