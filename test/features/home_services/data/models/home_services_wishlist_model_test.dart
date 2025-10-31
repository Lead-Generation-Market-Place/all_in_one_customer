import 'package:flutter_test/flutter_test.dart';
import 'package:yelpax/features/home_services/data/models/home_services_wishlist_model.dart';

void main() {
  test("Testing the wishlist model", (){
    List sampleData=[{"_id":"6904cca102839fb799f77a71","user_id":"68eaae2a73f142e5115639f0","service_id":{"_id":"68eaad6c73f142e5115639ed","name":"Handyman","description":"Handyman services","image_url":"service_1760023594437.png","is_active":true,"is_featured":true},"createdAt":"2025-10-31T14:50:09.972Z","updatedAt":"2025-10-31T14:50:09.972Z"},{"_id":"6904e01602839fb799f77a79","user_id":"68eaae2a73f142e5115639f0","service_id":{"_id":"68ee8507e3b9ba6360f515f3","name":"Electrical Wiring & Installation","description":"Electrical Wiring & Installation services","image_url":"service_1760464133126.jpg","is_active":true,"is_featured":true},"createdAt":"2025-10-31T16:13:10.889Z","updatedAt":"2025-10-31T16:13:10.889Z"}];

  var res=  HomeServicesWishlistModel.fromJson(sampleData[0]);
  expect("6904cca102839fb799f77a71", res.id);
  });
}