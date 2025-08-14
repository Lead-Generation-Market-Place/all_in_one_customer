import 'package:yelpax/features/home_services/data/repositories/home_services_repository_impl.dart';
import 'package:yelpax/features/home_services/domain/usecases/search_professional_usecase.dart';

import 'data/datasources/home_services_remote_data_source.dart';
import 'presentation/controllers/search_professional_controller.dart';

SearchProfessionalController searchProfessionalController() {
  final dataSource = HomeServicesRemoteDataSourceImpl();
  final repository = HomeServicesRepositoryImpl(dataSource);
  final usecase = SearchProfessionalUsecase(repository);
  return SearchProfessionalController(usecase);
}
