
import 'package:yelpax/features/home_services/domain/entities/home_services_wishlist_entity.dart';

import 'home_services_model.dart';

class HomeServicesWishlistModel extends HomeServicesWishlistEntity{
  HomeServicesWishlistModel({
    required super.id,
    required super.userId,
    required super.homeServicesEntity,
    required super.createdAt,
    required super.updatedAt
  });

  factory HomeServicesWishlistModel.fromJson(Map<String, dynamic> json) {
    return HomeServicesWishlistModel(
      id: json['_id'],
      userId: json['user_id'],
      homeServicesEntity: HomeServicesModel.fromJson(json['service_id']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }



  factory HomeServicesWishlistModel.empty(){
    return HomeServicesWishlistModel(id: "",
     userId: "",
      homeServicesEntity: HomeServicesModel.assignEmptyValues(),
       createdAt: DateTime.now(),
        updatedAt: DateTime.now());
  }


}