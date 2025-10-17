import 'package:dartz/dartz.dart';
import 'package:yelpax/core/error/failures/failure.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_fetch_professionals_entity.dart';
import 'package:yelpax/features/home_services/domain/repositories/home_services_repository.dart';

class HomeServicesFindprosUsecase {
  HomeServicesRepository repository;
  HomeServicesFindprosUsecase({required this.repository});

  Future<Either<Failure, List<HomeServicesFetchProfessionalsEntity>>> call(
    String query,
  ) {
    return repository.fetchPros(query);
  }

  Future<Either<Failure, List<HomeServicesFetchProfessionalsEntity>>>
  callByServiceIdZipCode(String serviceId, String zipCode) async {
    return repository.fetchProsByServiceIdAndZip(serviceId, zipCode);
  }
}
