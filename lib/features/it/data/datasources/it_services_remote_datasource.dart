import 'package:yelpax/core/error/exceptions/exceptions.dart';
import 'package:yelpax/features/it/data/models/it_services_model.dart';
import 'package:yelpax/features/it/domain/entities/it_services_entity.dart';

abstract class ItServicesRemoteDatasource {
  Future<List<ItServicesEntity>> onChanged(String query);
}

class ItServicesRemoteDatasourceImpl implements ItServicesRemoteDatasource {
  List itCategories = [
    {
      "id": "1",
      "name": "Website Development",
      "imageUrl":
          "https://images.pexels.com/photos/1148820/pexels-photo-1148820.jpeg",
    },
    {
      "id": "2",
      "name": "Architecture & Interior",
      "imageUrl":
          "https://images.pexels.com/photos/1148820/pexels-photo-1148820.jpeg",
    },
    {
      "id": "1",
      "name": "UGC Videos",
      "imageUrl":
          "https://images.pexels.com/photos/1148820/pexels-photo-1148820.jpeg",
    },
    {
      "id": "1",
      "name": "Video Editing",
      "imageUrl":
          "https://images.pexels.com/photos/1148820/pexels-photo-1148820.jpeg",
    },
    {
      "id": "3",
      "name": "Voice Artist",
      "imageUrl":
          "https://images.pexels.com/photos/1148820/pexels-photo-1148820.jpeg",
    },
    {
      "id": "4",
      "name": "Native Speakers",
      "imageUrl":
          "https://images.pexels.com/photos/1148820/pexels-photo-1148820.jpeg",
    },
    {
      "id": "5",
      "name": "IT Troublshooting",
      "imageUrl":
          "https://images.pexels.com/photos/1148820/pexels-photo-1148820.jpeg",
    },
  ];
  List filteredList = [];
  @override
  Future<List<ItServicesModel>> onChanged(String query) async {
    filteredList.clear();
    itCategories.forEach((element) {

      if (element['name'].toString().toLowerCase().contains(
        query.toLowerCase(),
      )) {
        filteredList.add(element);
      }
    });
    try {
      final response=await Future.delayed(Duration(seconds: 1),(){
        return filteredList;
      });
      return response.map((e) => ItServicesModel.fromMap(e),).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
