import 'package:dartz/dartz.dart';
import 'package:yelpax/core/error/exceptions/exceptions.dart';
import 'package:yelpax/core/error/failures/failure.dart';
import 'package:yelpax/features/it_services/data/datasources/it_services_remote_datasource.dart';
import 'package:yelpax/features/it_services/domain/entities/it_services_entity.dart';
import 'package:yelpax/features/it_services/domain/repositories/it_services_repository.dart';

class ItServicesRepositoryImpl implements ItServicesRepository{
  ItServicesRemoteDatasource remoteDatasource;
  ItServicesRepositoryImpl({required this.remoteDatasource});
  
  @override
  Future<Either<Failure,List<ItServicesEntity>>> onChanged(String query)async {
      try{
        final result=await remoteDatasource.onChanged(query);
        return Right(result);

      }on ServerException catch (e){
        return Left(ServerFailure(e.message));
      }catch(e){
        return Left(GenericFailure(e.toString()));
      }
    
  }

}