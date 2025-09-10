import 'package:dartz/dartz.dart';
import 'package:yelpax/core/error/failures/failure.dart';
import 'package:yelpax/features/it/domain/entities/it_services_entity.dart';

abstract class ItServicesRepository {
  Future<Either<List<ItServicesEntity>,Failure>> onChanged(String queyr);
}