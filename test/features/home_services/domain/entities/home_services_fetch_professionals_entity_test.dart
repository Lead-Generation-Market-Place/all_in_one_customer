import 'package:flutter_test/flutter_test.dart';
import 'package:yelpax/features/home_services/data/models/home_services_fetch_professional_model.dart';

void main() {
  Map<String,dynamic> apiResponse= {
      "_id": "68e7d00bb0735d6e372e439a",
      "professional_id": {
        "_id": "68e69e797e4abae95a8fc544",
        "user_id": {
          "_id": "68e68776e5690430fb1cf2ee",
          "email": "amazon@gmail.com",
          "username": "Amazon"
        },
        "business_name": "Amazon.com",
        "introduction": "We provide top-notch plumbing solutions.",
        "business_type": "company",
        "profile_image": "http://localhost:4000/uploads/profile.jpg"
      },
      "service_id": {
        "service_status": true,
        "_id": "68e6a87684148bc537ccf97b"
      },
      "service_name": "Carpet Cleaning",
      "location_ids": [
        {
          "coordinates": {
            "type": "Point",
            "coordinates": [-71.0589, 42.3601]
          },
          "_id": "68e6aa4be36571be8f7cc6e1",
          "type": "service",
          "service_id": "653a1f3b7e8b2c00123abcda",
          "country": "USA",
          "state": "Massachusetts",
          "city": "Boston",
          "zipcode": "02108",
          "address_line": "246 Beacon St",
          "createdAt": "2025-10-08T18:15:39.713Z",
          "updatedAt": "2025-10-08T18:15:39.713Z"
        }
      ],
      "maximum_price": 520,
      "minimum_price": 105,
      "service_status": true,
      "description": "Professional carpet cleaning and maintenance services.",
      "pricing_type": "per_project",
      "completed_tasks": 32,
      "question_ids": [
        {
          "_id": "68d802dfe24fe8191d4813bc",
          "service_id": "68d3ef2f766db03b5acf76ef",
          "question_name": "How do you do a job?",
          "form_type": "checkbox",
          "options": [
            "Red",
            "Green",
            "Blue"
          ],
          "required": true,
          "order": 1,
          "active": true,
          "createdAt": "2025-09-27T15:29:35.311Z",
          "updatedAt": "2025-09-27T15:29:35.311Z"
        }
      ],
      "createdAt": "2025-10-09T15:08:59.049Z",
      "updatedAt": "2025-10-09T15:08:59.049Z"
    };
  
  test("Matching Response with the model if works or not", () {
      //Arrange
   var obj=   HomeServicesFetchProfessionalModel.fromJson(apiResponse);

      //Assert
      print(obj.locations[0].coordinates.geoPoints.latitude);

      //Act
  },);
}