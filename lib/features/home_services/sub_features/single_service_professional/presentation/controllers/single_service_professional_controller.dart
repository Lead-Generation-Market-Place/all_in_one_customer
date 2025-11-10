import 'package:flutter/material.dart';
import 'package:yelpax/features/home_services/domain/usecases/home_services_findpros_usecase.dart';

class SingleServiceProfessionalController extends ChangeNotifier {
  HomeServicesFindprosUsecase homeServicesFindprosUsecase;
  String proId;
  bool _proLoading = false;
  bool _disposed = false;
 
 
  bool get proLoading => _proLoading;
 
  SingleServiceProfessionalController({required this.homeServicesFindprosUsecase,required this.proId}) {
    getProCompleteDetails();
  }

  void _safeNotify() {
    if (!_disposed) notifyListeners();
  }

  Future getProCompleteDetails() async {
    try {
      _proLoading = true;
      _safeNotify();
      final result=await homeServicesFindprosUsecase.callProCompleteDetails(proId);
        result.fold((problem){
          print("Error While fetching professional complete details: ${problem.message}");
        }, 
        (success){
          print("Successfully fetched professional complete details: ${success.toString()}");
        });
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      _proLoading = false;
      _safeNotify();
    }
  }

  Future<void> retry() async {
   print("Retrying to fetch professional complete details....");
  }

  // @override
  // void dispose() {
  //   _disposed = true;
  //   // TODO: implement dispose
  //   super.dispose();
  // }
}
