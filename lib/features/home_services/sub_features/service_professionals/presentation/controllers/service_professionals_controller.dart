import 'package:flutter/material.dart';

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
          'name': 'alex',
          'ratings': 4.9,
          'isActive': false,
          'timesHired': 84,
          'estimatedPrice': '97\$ - \$113/hour',
          'response': '~56',
          'starsCount': 33,
          'lastReviewText':
              "lorem ipsum psdfsdg;asjdgksajd;gjdsa;kgjkdsjgasdkjh;kasdjh;ksdjgjsdfsdkfj;skjdfksdjf",
        },
        {
          'name': 'pablo',
          'ratings': 3.8,
          'isActive': true,
          'timesHired': 20,
          'estimatedPrice': '47\$ - \$113/hour',
          'response': '~43',
          'starsCount': 32,

          'lastReviewText':
              "lorem ipsum psdfsdg;asjdgksajd;gjdsa;kgjkdsjgasdkjh;kasdjh;ksdjgjsdfsdkfj;skjdfksdjf",
        },
        {
          'name': 'yameen',
          'ratings': 2.0,
          'isActive': true,
          'timesHired': 4,
          'estimatedPrice': '37\$ - \$13/hour',
          'response': '~22',
          'starsCount': 50,

          'lastReviewText':
              "lorem ipsum psdfsdg;asjdgksajd;gjdsa;kgjkdsjgasdkjh;kasdjh;ksdjgjsdfsdkfj;skjdfksdjf",
        },
      ];
    } catch (e) {
      debugPrint('Error on retry : $e');
    } finally {
      _professionalsLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _professionals = [];
    super.dispose(); // important!
  }
}
