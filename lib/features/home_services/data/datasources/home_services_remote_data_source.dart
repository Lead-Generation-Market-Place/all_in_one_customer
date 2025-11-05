import 'package:flutter/material.dart';
import 'package:yelpax/core/network/dio_client.dart';
import 'package:yelpax/core/network/endpoints.dart';
import 'package:yelpax/features/home_services/data/models/home_service_promotion_model.dart';
import 'package:yelpax/features/home_services/data/models/home_services_fetch_professional_model.dart';
import 'package:yelpax/features/home_services/data/models/home_services_model.dart';
import 'package:yelpax/features/home_services/data/models/home_services_wishlist_model.dart';
import '../../../../core/error/exceptions/exceptions.dart';

abstract class HomeServicesRemoteDataSource {
  Future<List<HomeServicesModel>> fetchServicesQuery(String query);
  Future<List<HomeServicesModel>> fetchPopularHomeServices();
  Future<List<HomeServicesModel>> fetchAllHomeServices();
  Future<List<HomeServicePromotionModel>> fetchPromotions();
  Future<List<HomeServicesFetchProfessionalModel>> findPros(String query);
  Future<List<HomeServicesFetchProfessionalModel>> fetchProsByServiceAndZip(
    String serviceId,
    String zipCode,
  );
  Future<List<HomeServicesModel>> fetchNearbyHomeServices(String zipCode);
  Future<List<HomeServicesWishlistModel>> fetchUserWishlists(String userId);
  Future<void> addToWishlist(String serviceId, String userId);
  Future<void> removeFromWishlist(String wishlistId);
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
  Future<List<HomeServicesModel>> fetchPopularHomeServices() async {
    final response = await dioClient.get(Endpoints.getPopularServices);
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
  Future<List<HomeServicesModel>> fetchAllHomeServices() async {
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
    print("Fetchingggggggggggggggggggg prosssssssssssssss in remote data source");
    final response = await dioClient.get("${Endpoints.findpros}/$query");
    if (response.statusCode == 200) {
       print("Fetchingggggggggggggggggggg prosssssssssssssss in remote data source Success");
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
        data: {"serviceId": serviceId, "zipCode": zipCode},
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
    } catch (e) {
      throw ServerException("An error occurred while fetching professionals");
    }
  }

  @override
  Future<List<HomeServicesModel>> fetchNearbyHomeServices(
    String zipCode,
  ) async {
    final endpoint = Endpoints.replacePathParameters(Endpoints.nearbyServices, {
      "zipCode": "11235",
    });
    try {
      final response = await dioClient.get(endpoint);

      if (response.statusCode == 200) {
        final json = response.data;
        final List<dynamic> listData = json['data'] ?? [];

        var res = listData.map((e) {
          // Extract the nested service_id object
          final serviceData = e['service_id'] ?? {};
          return HomeServicesModel.fromJson(serviceData);
        }).toList();

        return res;
      } else if (response.statusCode == 404) {
        throw NotFoundException("No Services Found On zip code");
      } else {
        throw ServerException(
          "Failed to get Services Server Problem: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw ServerException("An error occurred while fetching Services");
    }
  }

  @override
  Future<List<HomeServicesWishlistModel>> fetchUserWishlists(
    String userId,
  ) async {
    final endpoint = Endpoints.replacePathParameters(Endpoints.wishlists, {
      "userId": userId,
    });

    try {
      final response = await dioClient.get(endpoint);

      if (response.statusCode == 200) {
        final json = response.data as Map<String, dynamic>;

        // Handle empty or null data
        if (json['data'] == null || json['data'] is! List) {
          return [];
        }

        final List<dynamic> listData = json['data'];

        // Convert to models, filtering out any invalid items
        final result = listData
            .where((item) => item is Map<String, dynamic>)
            .map((e) => HomeServicesWishlistModel.fromJson(e))
            .toList();

        return result;
      } else if (response.statusCode == 404) {
        throw NotFoundException("Wishlist not found for user");
      } else if (response.statusCode == 500) {
        throw ServerException("Server error while fetching wishlist");
      } else {
        throw ServerException(
          "Failed to fetch wishlist: ${response.statusCode}",
        );
      }
    } on ServerException {
      rethrow;
    } on NotFoundException {
      rethrow;
    } catch (e, s) {
      debugPrint("Wishlist fetch error in remote data source: $e\nStack: $s");
      throw ServerException("Network error while fetching wishlist");
    }
  }

  @override
  Future<void> addToWishlist(String serviceId, String userId) async {
    Map params = {"user_id": userId, "service_id": serviceId};

    try {
      final response = await dioClient.post(
        Endpoints.addToWishlist,
        data: params,
      );

      if (response.statusCode == 201) {
      } else if (response.statusCode == 404) {
        throw NotFoundException("Wishlist not added for user");
      } else if (response.statusCode == 500) {
        throw ServerException("Server error while adding wishlist");
      } else {
        throw ServerException("Failed to add wishlist: ${response.statusCode}");
      }
    } on ServerException {
      rethrow;
    } on NotFoundException {
      rethrow;
    } catch (e, s) {
      debugPrint("Wishlist adding error in remote data source: $e\nStack: $s");
      throw ServerException("Network error while fetching wishlist");
    }
  }

  @override
  Future<void> removeFromWishlist(String wishlistId) async {
    try {
      final response = await dioClient.delete(Endpoints.removeFromWishlist);

      if (response.statusCode == 200) {
      } else if (response.statusCode == 404) {
        throw NotFoundException("Wishlist deleted");
      } else if (response.statusCode == 500) {
        throw ServerException("Server error while deleting wishlist");
      } else {
        throw ServerException(
          "Failed to Delete wishlist: ${response.statusCode}",
        );
      }
    } on ServerException {
      rethrow;
    } on NotFoundException {
      rethrow;
    } catch (e, s) {
      debugPrint(
        "Wishlist deleting error in remote data source: $e\nStack: $s",
      );
      throw ServerException("Network error while deleting wishlist");
    }
  }
}
