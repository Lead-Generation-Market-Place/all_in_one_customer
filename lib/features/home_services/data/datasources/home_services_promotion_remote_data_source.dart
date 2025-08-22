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
      "serviceProviders": "20",
    },
    {
      "id": "2",
      "serviceName": "Home Cleaning",
      "promotionName": "40% Discount on First Hire",
      "serviceProviders": "100",
    },
    {
      "id": "1",
      "serviceName": "Junk Removal",
      "promotionName": "Free Truck Expense",
      "serviceProviders": "34",
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
