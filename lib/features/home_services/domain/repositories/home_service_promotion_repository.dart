import 'package:dartz/dartz.dart';
import '../../../../core/error/failures/failure.dart';
import '../entities/home_services_promotion_entity.dart';

abstract class HomeServicePromotionRepository {
  Future<Either<Failure, List<HomeServicesPromotionEntity>>>
  getHomeServicePromotions();
}
