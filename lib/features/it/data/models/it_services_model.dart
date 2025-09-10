import 'package:yelpax/features/it/domain/entities/it_services_entity.dart';

class ItServicesModel extends ItServicesEntity {
  ItServicesModel({
    required super.id,
    required super.name,
    required super.imageUrl,
  });


factory ItServicesModel.fromMap(Map<String,dynamic> map){
    return ItServicesModel(
     id: map['id'],
      name: map['name'],
      imageUrl: map['imageUrl']);
  }
}
