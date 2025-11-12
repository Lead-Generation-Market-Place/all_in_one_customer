import 'package:yelpax/features/home_services/domain/entities/home_services_location_entity.dart';
import 'package:yelpax/features/home_services/domain/repositories/home_services_repository.dart';
import '../../../../core/error/failures/failure.dart';
import 'package:dartz/dartz.dart';

class HomeServicesGetCurrentLocationUsecase {
  final HomeServicesRepository repository;

  HomeServicesGetCurrentLocationUsecase({required this.repository});

  Future<Either<Failure, HomeServicesLocationEntity>> call() async {
    return await repository.getCurrentLocation();
  }
}