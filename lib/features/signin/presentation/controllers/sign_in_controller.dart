import 'package:flutter/material.dart';
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

    try {
      var uu = await signInUseCase.call(email, password);
      print('user logged in successfully');
    } catch (e) {
      error = e.toString();
      print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
