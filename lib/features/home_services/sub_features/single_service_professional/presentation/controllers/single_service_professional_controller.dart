import 'package:flutter/material.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_professional_entity.dart';
import 'package:yelpax/features/home_services/domain/usecases/home_services_findpros_usecase.dart';

class SingleServiceProfessionalController extends ChangeNotifier {
  HomeServicesFindprosUsecase homeServicesFindprosUsecase;
  String proId;
  bool _proLoading = false;
  bool _disposed = false;
  late HomeServicesProfessionalEntity _professionalEntity;
  String _errorMessage = '';

  bool get proLoading => _proLoading;
  HomeServicesProfessionalEntity get getProfessionalEntity =>
      _professionalEntity;
  String get errorMessage => _errorMessage;

  SingleServiceProfessionalController({
    required this.homeServicesFindprosUsecase,
    required this.proId,
  }) {
    getProCompleteDetails();
  }

  void _safeNotify() {
    if (!_disposed) notifyListeners();
  }

  Future getProCompleteDetails() async {
    try {
      _proLoading = true;
      _safeNotify();
      final result = await homeServicesFindprosUsecase.callProCompleteDetails(
        proId,
      );
      result.fold(
        (problem) {
          _errorMessage = problem.message;
        },
        (success) {
          _professionalEntity = success;
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _proLoading = false;
      _safeNotify();
    }
  }

  Future<void> retry() async {
    print("Retrying to fetch professional complete details....");
    await getProCompleteDetails();
  }

  // @override
  // void dispose() {
  //   _disposed = true;
  //   // TODO: implement dispose
  //   super.dispose();
  // }
}
