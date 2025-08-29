import 'package:yelpax/core/error/exceptions/exceptions.dart';
import 'package:yelpax/features/home_services/data/models/home_service_promotion_model.dart';

abstract class HomeServicesPromotionRemoteDataSource {
  Future<List<HomeServicePromotionModel>> searchPromotions();
}

class HomeServicesPromotionRemoteDataSourceImpl
    implements HomeServicesPromotionRemoteDataSource {
  List promotions = [
    {
      "id": "1",
      "serviceName": "Handy Man",
      "promotionName": "Free Repairing",
      "promotionImage": "assets/images/handy_man.jpg",
      "serviceProviders": "All 20",
    },
    {
      "id": "2",
      "serviceName": "Home Cleaning",
      "promotionName": "40% Discount on First Hire",
      "promotionImage": "assets/images/home_cleaning.jpg",
      "serviceProviders": "All 100",
    },
    {
      "id": "1",
      "serviceName": "Junk Removal",
      "promotionName": "Free Truck Expense",
      "promotionImage": "assets/images/junk_removal.jpg",
      "serviceProviders": "All 34",
    },
  ];

  @override
  Future<List<HomeServicePromotionModel>> searchPromotions() async {
    try {
      await Future.delayed(Duration(seconds: 2));
      return promotions
          .map((e) => HomeServicePromotionModel.fromJson(e))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
