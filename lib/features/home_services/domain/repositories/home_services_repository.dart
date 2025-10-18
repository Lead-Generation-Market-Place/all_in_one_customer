import 'package:dartz/dartz.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_entity.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_fetch_professionals_entity.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_location_entity.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_promotion_entity.dart';
import '../../../../core/error/failures/failure.dart';

abstract class HomeServicesRepository {
  Future<Either<Failure, List<HomeServicesEntity>>> fetchServicesQuery(String query);
  Future<Either<Failure,List<HomeServicesEntity>>>getHomeServices();
  Future<Either<Failure,List<HomeServicesPromotionEntity>>>getPromotions();
  Future<Either<Failure,List<HomeServicesFetchProfessionalsEntity>>>fetchPros(String query);
  Future<Either<Failure,List<HomeServicesFetchProfessionalsEntity>>>fetchProsByServiceIdAndZip(String serviceId,String zipCode);
  Future<Either<Failure, HomeServicesLocationEntity>> getCurrentLocation();
}
