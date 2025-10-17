import 'package:dartz/dartz.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_entity.dart';
import '../../../../core/error/failures/failure.dart';
import '../repositories/home_services_repository.dart';

class SearchProfessionalUsecase {
  final HomeServicesRepository repository;

  SearchProfessionalUsecase({required this.repository});

  Future<Either<Failure, List<HomeServicesEntity>>> call(String query) {
    return repository.fetchServicesQuery(query);
  }
}
