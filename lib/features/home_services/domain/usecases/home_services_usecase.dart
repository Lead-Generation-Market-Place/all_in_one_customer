import 'package:dartz/dartz.dart';
import 'package:yelpax/core/error/failures/failure.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_entity.dart';
import 'package:yelpax/features/home_services/domain/repositories/home_services_repository.dart';

class HomeServicesUsecase {
  final HomeServicesRepository homeServicesRepository;
  HomeServicesUsecase({required this.homeServicesRepository});

  Future<Either<Failure, List<HomeServicesEntity>>> call() {
    return homeServicesRepository.getHomeServices();
  }
}
