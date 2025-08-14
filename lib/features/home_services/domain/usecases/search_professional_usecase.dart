import 'package:dartz/dartz.dart';
import 'package:yelpax/core/error/failures/failure.dart';
import 'package:yelpax/features/home_services/domain/entities/professional.dart';
import 'package:yelpax/features/home_services/domain/repositories/home_services_repository.dart';

class SearchProfessionalUsecase {
  final HomeServicesRepository repository;

  SearchProfessionalUsecase(this.repository);

  Future<Either<Failure, List<Professional>>> call(String query) {
    return repository.searchProfessionals(query);
  }
}
