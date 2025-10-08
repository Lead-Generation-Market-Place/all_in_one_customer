import 'package:dartz/dartz.dart';
import '../../../../core/error/failures/failure.dart';
import '../entities/professional.dart';
import '../repositories/home_services_repository.dart';

class SearchProfessionalUsecase {
  final HomeServicesRepository repository;

  SearchProfessionalUsecase({required this.repository});

  Future<Either<Failure, List<Professional>>> call(String query) {
    return repository.searchProfessionals(query);
  }
}
