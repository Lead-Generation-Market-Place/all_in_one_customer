import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_fetch_professionals_entity.dart';
import 'package:yelpax/features/home_services/domain/usecases/home_services_findpros_usecase.dart';

import '../../../../../config/routes/router.dart';

class HomeServicesFindprosController extends ChangeNotifier {
  HomeServicesFindprosUsecase usecase;

  bool _professionalsLoading = false;
  List<HomeServicesFetchProfessionalsEntity> _professionals = [];
  String _error="";

  bool get professionalsLoading => _professionalsLoading;
  List<HomeServicesFetchProfessionalsEntity> get professionals => _professionals;
  String get error=>_error;

  final Map serviceDetails;

  HomeServicesFindprosController(this.serviceDetails, {required this.usecase}) {
    getProfessionals("68e6a87684148bc537ccf97b");
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

  Future<void> retry() async {
    print('Retrying....');
    // try {
    //   _professionalsLoading = true;
    //   notifyListeners();

    //   await Future.delayed(const Duration(seconds: 2));

    //   _professionals = [
    //     {
    //       'name': 'Brand Construction Company',
    //       'ratings': 4.9,
    //       'isActive': false,
    //       'timesHired': 84,
    //       'estimatedPrice': '97\$ - \$113/hour',
    //       'response': '~ 56',
    //       'starsCount': 33,
    //       'lastReviewText':
    //           "lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum",
    //     },
    //     {
    //       'name': 'Seven Guys Construction',
    //       'ratings': 3.8,
    //       'isActive': true,
    //       'timesHired': 20,
    //       'estimatedPrice': '47\$ - \$113/hour',
    //       'response': '~ 43',
    //       'starsCount': 32,

    //       'lastReviewText':
    //           "lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum",
    //     },
    //     {
    //       'name': 'New Construction Company',
    //       'ratings': 2.0,
    //       'isActive': true,
    //       'timesHired': 4,
    //       'estimatedPrice': '37\$ - \$13/hour',
    //       'response': '~ 22',
    //       'starsCount': 50,

    //       'lastReviewText':
    //           "lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum",
    //     },
    //   ];
    // } catch (e) {
    //   debugPrint('Error on retry : $e');
    // } finally {
    //   _professionalsLoading = false;
    //   notifyListeners();
    // }
  }

  Future<void> openCategory(Map categoryDetails, BuildContext context) async {
    print(categoryDetails);
    Navigator.pushNamed(
      context,
      AppRouter.singleServiceProfessionalScreen,
      arguments: categoryDetails,
    );
  }

  Future<void> openQuestionFlow(String questionId, BuildContext context) async {
    Navigator.pushNamed(context, AppRouter.questionFlowScreen);
  }

  @override
  void dispose() {
    _professionals = [];
    super.dispose(); // important!
  }
}
