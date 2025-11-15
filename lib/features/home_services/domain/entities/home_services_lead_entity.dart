import 'package:yelpax/features/home_services/domain/entities/home_services_answer_entity.dart';
import 'home_services_lead_file_entity.dart';

class HomeServicesLeadEntity {
 final String id;
final  String serviceId;
final String userId;
final String title;
final String note;
final List<HomeServicesAnswerEntity> answers;
final List<HomeServicesLeadFileEntity> files;
final String sendOption;
final DateTime createdAt;

HomeServicesLeadEntity({
  required this.id,
  required this.serviceId,
  required this.userId,
  required this.title,
  required this.note,
  required this.answers,
  required this.files,
  required this.sendOption,
  required this.createdAt,
});



}