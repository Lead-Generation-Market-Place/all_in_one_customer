import 'package:dartz/dartz.dart';
import 'package:yelpax/core/error/failures/failure.dart';
import 'package:yelpax/features/it_services/domain/entities/it_services_entity.dart';
import 'package:yelpax/features/it_services/domain/repositories/it_services_repository.dart';

class ItServicesUsecase{
  ItServicesRepository repository;
  ItServicesUsecase({required this.repository});
  
  Future<Either<Failure,List<ItServicesEntity>>> onChanged(String query){
    return repository.onChanged(query);
  }
}