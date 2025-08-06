import 'package:flutter/material.dart';
import 'package:logger/web.dart';

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
          'ratings': '5',
          'isActive': false,
          'timesHired': 84,
          'estimatedPrice': '97\$ - \$113/hour',
        },
        {
          'name': 'pablo',
          'ratings': '3',
          'isActive': true,
          'timesHired': 20,
          'estimatedPrice': '47\$ - \$113/hour',
        },
        {
          'name': 'yameen',
          'ratings': '2',
          'isActive': true,
          'timesHired': 4,
          'estimatedPrice': '37\$ - \$13/hour',
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
