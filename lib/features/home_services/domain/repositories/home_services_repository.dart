import 'package:dartz/dartz.dart';
import 'package:yelpax/core/error/failures/failure.dart';
import 'package:yelpax/features/home_services/domain/entities/professional.dart';

abstract class HomeServicesRepository {
  Future<Either<Failure, List<Professional>>> searchProfessionals(String query);
}
