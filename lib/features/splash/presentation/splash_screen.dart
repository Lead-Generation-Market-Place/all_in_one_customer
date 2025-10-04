// lib/features/splash/presentation/splash_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yelpax/core/init/app_initializer.dart';
import 'package:yelpax/features/onboarding/presentation/controllers/onboarding_controller.dart';

import '../../../config/routes/router.dart';
import '../../../core/auth/auth_manager.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await AppInitializer.initializeApp();
    if (!mounted) return;
    await _boot();
  }

  Future<void> _boot() async {
    final controller = Provider.of<OnboardingController>(
      context,
      listen: false,
    );
    final aauth=Provider.of<AuthManager>(context,listen: false);
    await Future.wait([
      controller.ensureOnboardingCompleted(),
      aauth.checkAuthStatus(),
    ]);
    if (!mounted) return;

  if(!await controller.ensureOnboardingCompleted()){
  Navigator.pushReplacementNamed(context, AppRouter.onboarding);
  }else if(aauth.isLoggedIn){
     Navigator.pushReplacementNamed(context, AppRouter.home);
  }else{
    Navigator.pushReplacementNamed(context, AppRouter.signIn);
  }
    
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
          CircularProgressIndicator.adaptive(),
          SizedBox(height: 30,),
          Consumer<AuthManager>(builder: (context, value, child) {
            if(value.isLoading){
              return Text("Checking Authentication....");
            }
            return Text("Loading...");
          },)
      ],
    ));
  }
}
