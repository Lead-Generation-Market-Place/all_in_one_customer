import 'package:dartz/dartz.dart';
import 'package:yelpax/core/error/failures/failure.dart';
import 'package:yelpax/features/it_services/domain/entities/it_services_entity.dart';

abstract class ItServicesRepository {
  Future<Either<Failure,List<ItServicesEntity>>> onChanged(String queyr);
}