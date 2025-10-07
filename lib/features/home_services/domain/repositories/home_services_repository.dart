import 'package:dartz/dartz.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_entity.dart';
import '../../../../core/error/failures/failure.dart';
import '../entities/professional.dart';

abstract class HomeServicesRepository {
  Future<Either<Failure, List<Professional>>> searchProfessionals(String query);
  Future<Either<Failure,List<HomeServicesEntity>>>getHomeServices();
  

}
