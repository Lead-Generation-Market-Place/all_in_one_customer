import 'package:dartz/dartz.dart';
import 'package:yelpax/core/error/failures/failure.dart';
import 'package:yelpax/features/it/domain/entities/it_services_entity.dart';
import 'package:yelpax/features/it/domain/repositories/it_services_repository.dart';

class ItServicesUsecase{
  ItServicesRepository repository;
  ItServicesUsecase({required this.repository});
  
  Future<Either<List<ItServicesEntity>,Failure>> onChanged(String query){
    return repository.onChanged(query);
  }
}