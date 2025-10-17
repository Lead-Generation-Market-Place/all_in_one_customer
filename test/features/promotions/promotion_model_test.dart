
import 'package:flutter_test/flutter_test.dart';
import 'package:yelpax/features/home_services/data/models/home_service_promotion_model.dart';

void main(){
  
      

    test("From the above sample creating a reliable home services promotion model", () async{
      final Map<String, dynamic> jsonData =
       {
      "_id": "68e7cc3b6221f7d51ad2e7bc",
      "title": "Summer Discount",
      "description": " Home Summer Discount Arrived",
      "discount_type": "fixed",
      "discount_value": 123,
      "service_id": {
    
        "name": "Lawn triming",
       "image_url": "service_1760023096742.png",
        "is_active": true,
      },
      "valid_from": "2025-10-08T19:30:00.000Z",
      "valid_to": "2025-10-19T19:30:00.000Z",
      "is_active": true,
      "promo_code": "sdfsge4445",
    
    };
    
    
   //   final HomeServicePromotionModel model=new HomeServicePromotionModel.fromJson(jsonData);
   final HomeServicePromotionModel model=new HomeServicePromotionModel.fromJson(jsonData);
 //    expect(model.id, "68e7cc3b6221f7d51ad2e7bc");
     expect(model.title, "Summer Discount");
     expect(model.description, " Home Summer Discount Arrived");
      expect(model.promo_code, "sdfsge4445");
      expect(model.is_active, true);
  //    expect(model.servicesEntity.id, "68e6a8a984148bc537ccf97e");
      expect(model.servicesEntity.is_active, true);
      
    },);
  
}