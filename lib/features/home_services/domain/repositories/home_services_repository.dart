import 'package:dartz/dartz.dart';
import '../../../../core/error/failures/failure.dart';
import '../entities/professional.dart';

abstract class HomeServicesRepository {
  Future<Either<Failure, List<Professional>>> searchProfessionals(String query);
}
