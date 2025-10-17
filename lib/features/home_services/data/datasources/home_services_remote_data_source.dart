import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yelpax/core/network/dio_client.dart';
import 'package:yelpax/core/network/endpoints.dart';
import 'package:yelpax/features/home_services/data/models/home_service_promotion_model.dart';
import 'package:yelpax/features/home_services/data/models/home_services_fetch_professional_model.dart';
import 'package:yelpax/features/home_services/data/models/home_services_model.dart';

import '../../../../core/error/exceptions/exceptions.dart';

abstract class HomeServicesRemoteDataSource {
  Future<List<HomeServicesModel>> fetchServicesQuery(String query);
  Future<List<HomeServicesModel>> fetchHomeServices();
  Future<List<HomeServicePromotionModel>> fetchPromotions();
  Future<List<HomeServicesFetchProfessionalModel>> findPros(String query);
  Future<List<HomeServicesFetchProfessionalModel>> fetchProsByServiceAndZip(
    String serviceId,
    String zipCode,
  );
}

class HomeServicesRemoteDataSourceImpl implements HomeServicesRemoteDataSource {
  final DioClient dioClient;

  HomeServicesRemoteDataSourceImpl({required this.dioClient});

  List filteredList = [];
  @override
  Future<List<HomeServicesModel>> fetchServicesQuery(String query) async {
    final response = await dioClient.get(Endpoints.getServices);
    if (response.statusCode == 200) {
      final json = response.data as Map<String, dynamic>;
      final List<dynamic> services = json['data'];
      filteredList.clear();
      services.forEach((element) {
        if (element["name"].toString().toLowerCase().contains(
          query.toLowerCase(),
        )) {
          filteredList.add(element);
        }
      });
      return filteredList.map((e) => HomeServicesModel.fromJson(e)).toList();
    } else if (response.statusCode == 404) {
      throw NotFoundException("Not Found Home Services");
    } else {
      throw ServerException("Faild To Get Home Services");
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

 @override
Future<List<HomeServicesFetchProfessionalModel>> fetchProsByServiceAndZip(
  String serviceId,
  String zipCode,
) async {
  try {
    final response = await dioClient.post(
      Endpoints.findpros,
      data: {
        "serviceId": serviceId,
        "zipCode": zipCode,
      },
    );

    if (response.statusCode == 200) {
      final json = response.data;

    
        final List<dynamic> listData = json['data'] ?? [];
        return listData
            .map((e) => HomeServicesFetchProfessionalModel.fromJson(e))
            .toList();
      
    } else if (response.statusCode == 404) {
      throw NotFoundException(
        "No professionals found for this service and zip code",
      );
    } else {
      throw ServerException(
        "Failed to get professionals: ${response.statusCode}",
      );
    }
  } catch (e, s) {
    debugPrint("Error in fetchProsByServiceAndZip: $e\n$s");
    throw ServerException("An error occurred while fetching professionals");
  }
}

}
