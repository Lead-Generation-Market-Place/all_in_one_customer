import 'package:flutter/material.dart';

class ItHomeController extends ChangeNotifier{

  bool _isLoading=false;
  bool get isLoading=>_isLoading;

  List _itServices=[];
  List get itServices=>_itServices;

  String _errorMessage='';
  String get errorMessage=>_errorMessage;
  


   Future<void> openCategory(Map categoryDetails, BuildContext context) async {
    print(categoryDetails);
    // Navigator.pushNamed(
    //   context,
    //   AppRouter.serviceProfessionalsScreen,
    //   arguments: categoryDetails,
    // );
  }

  void clearResult() {
   _itServices=[];
    notifyListeners();
  }
}