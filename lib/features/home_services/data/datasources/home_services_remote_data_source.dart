import 'package:yelpax/features/home_services/data/models/professional_model.dart';

abstract class HomeServicesRemoteDataSource {
  Future<List<ProfessionalModel>> searchProfessionals(String query);
}

class HomeServicesRemoteDataSourceImpl implements HomeServicesRemoteDataSource {
  @override
  Future<List<ProfessionalModel>> searchProfessionals(String query) async {
    final response = await Future.delayed(const Duration(seconds: 2), () {
      return [
        {"id": "1", "name": "John Doe", "serviceType": "Plumber"},
        {"id": "2", "name": "Jane Smith", "serviceType": "Electrician"},
      ];
    });

    return response.map((json) => ProfessionalModel.fromJson(json)).toList();
  }
}
