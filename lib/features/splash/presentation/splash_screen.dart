// lib/features/splash/presentation/splash_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yelpax/core/init/app_initializer.dart';
import 'package:yelpax/config/routes/router.dart';
import 'package:yelpax/features/onboarding/presentation/controllers/onboarding_controller.dart';

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
    await controller.ensureOnboardingCompleted();
    if (!mounted) return;

    if (controller.isCompleted) {
      Navigator.pushNamed(context, AppRouter.login);
    } else {
      Navigator.pushNamed(context, AppRouter.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
