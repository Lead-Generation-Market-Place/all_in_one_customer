import 'package:yelpax/core/network/dio_client.dart';
import 'package:yelpax/core/network/endpoints.dart';
import 'package:yelpax/features/home_services/data/models/home_service_promotion_model.dart';
import 'package:yelpax/features/home_services/data/models/home_services_fetch_professional_model.dart';
import 'package:yelpax/features/home_services/data/models/home_services_model.dart';

import '../../../../core/error/exceptions/exceptions.dart';
import '../models/professional_model.dart';

abstract class HomeServicesRemoteDataSource {
  Future<List<ProfessionalModel>> searchProfessionals(String query);
  Future<List<HomeServicesModel>> fetchHomeServices();
  Future<List<HomeServicePromotionModel>> fetchPromotions();
  Future<List<HomeServicesFetchProfessionalModel>> findPros(String query);
}

class HomeServicesRemoteDataSourceImpl implements HomeServicesRemoteDataSource {
  final DioClient dioClient;

  HomeServicesRemoteDataSourceImpl({required this.dioClient});

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

  @override
  Future<List<HomeServicesModel>> fetchHomeServices() async {
    final response = await dioClient.get(Endpoints.getServices);
    if (response.statusCode == 200) {
      final json = response.data as Map<String, dynamic>;
      final List<dynamic> listData = json['data'];
      return listData.map((e) => HomeServicesModel.fromJson(e)).toList();
    } else if (response.statusCode == 404) {
      throw NotFoundException("Not Found Home Services");
    } else {
      throw ServerException("Faild To Get Home Services");
    }
  }

  @override
  Future<List<HomeServicePromotionModel>> fetchPromotions() async {
    final response = await dioClient.get(Endpoints.promotions);
    if (response.statusCode == 200) {
      final json = response.data as Map<String, dynamic>;
      final List<dynamic> listData = json['data'];
      return listData
          .map((e) => HomeServicePromotionModel.fromJson(e))
          .toList();
    } else if (response.statusCode == 404) {
      throw NotFoundException("Promotions Not Found");
    } else {
      throw ServerException("Faild To Get Promotions");
    }
  }

  @override
  Future<List<HomeServicesFetchProfessionalModel>> findPros(
    String query,
  ) async {
    final response = await dioClient.get("${Endpoints.findpros}/$query");
    if (response.statusCode == 200) {
      final json = response.data as Map<String, dynamic>;
      final List<dynamic> listData = json['data'];
      return listData
          .map((e) => HomeServicesFetchProfessionalModel.fromJson(e))
          .toList();
    } else if (response.statusCode == 404) {
      throw NotFoundException(
        "There Is No Professionals For The Selected Service",
      );
    } else {
      throw ServerException("Faild To Get Professionals");
    }
  }
}
