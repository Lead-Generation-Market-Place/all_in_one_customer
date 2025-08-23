import 'package:flutter/material.dart';

import '../../../../../../config/routes/router.dart';

class ServiceProfessionalsController extends ChangeNotifier {
  bool _professionalsLoading = false;
  List<Map<String, dynamic>> _professionals = [];

  bool get professionalsLoading => _professionalsLoading;
  List<Map> get professionals => _professionals;

  final Map serviceDetails;

  ServiceProfessionalsController(this.serviceDetails) {
    getProfessionals();
  }

  Future<void> getProfessionals() async {
    try {
      _professionalsLoading = true;
      notifyListeners();

      await Future.delayed(const Duration(seconds: 2)); // simulate loading

      // _professionals = [
      //   {
      //     'name': 'alex',
      //     'ratings': '5',
      //     'isActive': false,
      //     'timesHired': 84,
      //     'estimatedPrice': '97\$ - \$113/hour',
      //   },
      // ];
    } catch (e) {
      debugPrint('Error getting professionals: $e');
    } finally {
      _professionalsLoading = false;
      notifyListeners();
    }
  }

  Future<void> retry() async {
    try {
      _professionalsLoading = true;
      notifyListeners();

      await Future.delayed(const Duration(seconds: 2));

      _professionals = [
        {
          'name': 'Brand Construction Company',
          'ratings': 4.9,
          'isActive': false,
          'timesHired': 84,
          'estimatedPrice': '97\$ - \$113/hour',
          'response': '~ 56',
          'starsCount': 33,
          'lastReviewText':
              "lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum",
        },
        {
          'name': 'Seven Guys Construction',
          'ratings': 3.8,
          'isActive': true,
          'timesHired': 20,
          'estimatedPrice': '47\$ - \$113/hour',
          'response': '~ 43',
          'starsCount': 32,

          'lastReviewText':
              "lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum",
        },
        {
          'name': 'New Construction Company',
          'ratings': 2.0,
          'isActive': true,
          'timesHired': 4,
          'estimatedPrice': '37\$ - \$13/hour',
          'response': '~ 22',
          'starsCount': 50,

          'lastReviewText':
              "lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum",
        },
      ];
    } catch (e) {
      debugPrint('Error on retry : $e');
    } finally {
      _professionalsLoading = false;
      notifyListeners();
    }
  }

  Future<void> openCategory(Map categoryDetails, BuildContext context) async {
    print(categoryDetails);
    Navigator.pushNamed(
      context,
      AppRouter.singleServiceProfessionalScreen,
      arguments: categoryDetails,
    );
  }

  @override
  void dispose() {
    _professionals = [];
    super.dispose(); // important!
  }
}
