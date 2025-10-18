import 'package:flutter/material.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_fetch_professionals_entity.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_question_entity.dart';
import 'package:yelpax/features/home_services/domain/usecases/home_services_findpros_usecase.dart';

import '../../../../../config/routes/router.dart';

class HomeServicesFindprosController extends ChangeNotifier {
  HomeServicesFindprosUsecase usecase;
  bool _professionalsLoading = false;
  List<HomeServicesFetchProfessionalsEntity> _professionals = [];
  String _error = "";

  bool get professionalsLoading => _professionalsLoading;
  List<HomeServicesFetchProfessionalsEntity> get professionals =>
      _professionals;
  String get error => _error;

  HomeServicesFindprosController({required this.usecase});

  Future<void> wrapper(String query, String zipCode) async {
    if (zipCode.isNotEmpty) {
      await getProfessionalByIdAndZip(query, zipCode);
    } else {
      await getProfessionals(query);
    }
  }

  Future<void> getProfessionals(String query) async {
    _professionalsLoading = true;
    notifyListeners();
    var response = await usecase.call(query);
    response.fold(
      (problem) {
        _error = problem.message;
        _professionalsLoading = false;
        notifyListeners();
      },
      (success) {
        _professionals = success;
        _professionalsLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> getProfessionalByIdAndZip(
    String serviceId,
    String zipCode,
  ) async {
    _professionalsLoading = true;
    notifyListeners();
    final result = await usecase.callByServiceIdZipCode(serviceId, zipCode);
    result.fold(
      (problem) {
        _error = problem.message;
        _professionalsLoading = false;
        notifyListeners();
      },
      (success) {
        _professionals = success;
        _professionalsLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> retry() async {
    print('Retrying....');
  
  }

  Future<void> openCategory(Map categoryDetails, BuildContext context) async {
    print(categoryDetails);
    Navigator.pushNamed(
      context,
      AppRouter.singleServiceProfessionalScreen,
      arguments: categoryDetails,
    );
  }

  Future<void> openQuestionFlow(
    List<HomeServicesQuestionEntity> questions,
    BuildContext context,
  ) async {
    Navigator.pushNamed(
      context,
      AppRouter.questionFlowScreen,
      arguments: questions,
    );
  }

  @override
  void dispose() {
    _professionals = [];
    super.dispose(); // important!
  }
}
