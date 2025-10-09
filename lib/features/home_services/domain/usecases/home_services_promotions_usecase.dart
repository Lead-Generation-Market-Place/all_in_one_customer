import 'package:dartz/dartz.dart';
import 'package:yelpax/core/error/failures/failure.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_promotion_entity.dart';
import 'package:yelpax/features/home_services/domain/repositories/home_services_repository.dart';

class HomeServicesPromotionsUsecase {
  HomeServicesRepository repository;
  HomeServicesPromotionsUsecase({required this.repository});

  Future<Either<Failure, List<HomeServicesPromotionEntity>>>
  getPromotionsUsecase() {
    return repository.getPromotions();
  }
}
