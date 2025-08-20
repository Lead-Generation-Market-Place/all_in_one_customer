import 'package:yelpax/core/error/exceptions/exceptions.dart';
import 'package:yelpax/features/home_services/data/models/professional_model.dart';

abstract class HomeServicesRemoteDataSource {
  Future<List<ProfessionalModel>> searchProfessionals(String query);
}

class HomeServicesRemoteDataSourceImpl implements HomeServicesRemoteDataSource {
  List categories = [
    {"id": "1", "name": "Handy Man"},
    {"id": "2", "name": "Home Cleaning"},
    {"id": "1", "name": "Handy Mainetnance"},
    {"id": "1", "name": "Handy Repair"},
    {"id": "3", "name": "Junk Removal"},
    {"id": "4", "name": "Plumber"},
    {"id": "5", "name": "TV Mounting"},
  ];
  List filteredList = [];
  @override
  Future<List<ProfessionalModel>> searchProfessionals(String query) async {
    filteredList.clear();
    categories.forEach((element) {
      if (element['name'].toString().toLowerCase().contains(
        query.toLowerCase(),
      )) {
        filteredList.add(element);
      }
    });
    try {
      final response = await Future.delayed(const Duration(seconds: 2), () {
        return filteredList;
      });

      return response.map((json) => ProfessionalModel.fromJson(json)).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
