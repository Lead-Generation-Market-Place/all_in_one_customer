import 'package:dartz/dartz.dart';
import 'package:yelpax/core/error/failures/failure.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_lead_entity.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_location_entity.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_user_entity.dart';
import 'package:yelpax/features/home_services/domain/repositories/home_services_repository.dart';

class HomeServicesLeadUsecase {
  final HomeServicesRepository repository;
  HomeServicesLeadUsecase({required this.repository});

  Future<Either<Failure, HomeServicesLeadEntity>> call(
    CreateLeadParams params,
  ) async {
    return await repository.createLead(
      serviceId: params.serviceId,
      responses: params.responses,
      userInfo: params.userInfo,
      userLocation: params.userLocation,
      sendOption: params.sendOption,
      professionalId: params.professionalId,
      professionalIds: params.professionalIds,
      filePaths: params.filePaths,
    );
  }
}

class CreateLeadParams {
  final String serviceId;
  final Map<String, dynamic> responses;
  final HomeServicesUserEntity userInfo;
  final HomeServicesLocationEntity userLocation;
  final String sendOption;
  final String? professionalId;
  final List<String>? professionalIds;
  final List<String>? filePaths;

  CreateLeadParams({
    required this.serviceId,
    required this.responses,
    required this.userInfo,
    required this.userLocation,
    required this.sendOption,
    this.professionalId,
    this.professionalIds,
    this.filePaths,
  });
}
