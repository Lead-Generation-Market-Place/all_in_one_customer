import 'package:yelpax/features/it_services/data/datasources/it_services_remote_datasource.dart';
import 'package:yelpax/features/it_services/data/repositories/it_services_repository_impl.dart';
import 'package:yelpax/features/it_services/domain/usecases/it_services_usecase.dart';
import 'package:yelpax/features/it_services/presentation/controllers/it_services_controller.dart';

ItServicesController itServicesDi(){
  ItServicesRemoteDatasourceImpl datasource=ItServicesRemoteDatasourceImpl();
  ItServicesRepositoryImpl repository=ItServicesRepositoryImpl(remoteDatasource: datasource);
  ItServicesUsecase usecase=ItServicesUsecase(repository: repository);
  return ItServicesController(usecase);
}