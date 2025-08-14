import 'package:yelpax/features/home_services/data/datasources/home_services_remote_data_source.dart';
import 'package:yelpax/features/home_services/domain/entities/professional.dart';
import 'package:yelpax/features/home_services/domain/repositories/home_services_repository.dart';

class HomeServicesRepositoryImpl implements HomeServicesRepository {
  final HomeServicesRemoteDataSource remoteDataSource;
  HomeServicesRepositoryImpl(this.remoteDataSource);
  @override
  Future<List<Professional>> searchProfessionals(String query) {
    return remoteDataSource.searchProfessionals(query);
  }
}
