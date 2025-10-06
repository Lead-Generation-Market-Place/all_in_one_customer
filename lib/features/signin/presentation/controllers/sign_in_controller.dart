import 'package:flutter/material.dart';
import 'package:yelpax/config/routes/router.dart';
import 'package:yelpax/core/constants/app_constants.dart';
import '../../domain/entities/signin_entity.dart';
import '../../domain/usecases/sign_in_usecase.dart';

class SignInController extends ChangeNotifier {
  final SignInUseCase signInUseCase;

  SignInController({required this.signInUseCase});

  bool isLoading = false;
  String? error;
  SigninEntity? user;

  Future<void> signIn(String email, String password) async {
    isLoading = true;
    error = null;
    notifyListeners();
  try{
var result = await signInUseCase.call(email, password);
    result.fold(
      (ee) {
        error = ee.message;
        isLoading = false;
        notifyListeners();
      },
      (ss) {
        user = ss;
        _navigateToHome();
        isLoading = false;
        notifyListeners();
      },
    );
  }catch(e){
    print('Error occured $e');
  }
    
  }

  _navigateToHome() {
    AppConstants.navigateKeyword.currentState?.pushNamed(AppRouter.home);
  }
}
