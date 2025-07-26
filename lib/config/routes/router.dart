import 'package:flutter/material.dart';
import 'package:yelpax/app/presentation/shell/main_shell_screen.dart';
import 'package:yelpax/core/error/widgets/unknown_route_screen.dart';
import 'package:yelpax/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:yelpax/features/signin/presentation/screens/sign_in_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String signIn = '/SignIn';
  static const String home = '/home';
  static const String onboarding = '/onboarding';
  static const String unknownRouteScreen = '/unknownRouteScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      // case login:
      //   return MaterialPageRoute(builder: (_) => const LoginScreen());
      case signIn:
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const MainShellScreen());
      case unknownRouteScreen:
        return MaterialPageRoute(
          builder: (_) =>
              const UnknowRouteScreen(message: 'Unknown Route Screen'),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const UnknowRouteScreen(message: "Unknown Route!"),
        );
    }
  }

  //when going to unknown routes
  static Route<dynamic> unknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) =>
          UnknowRouteScreen(message: 'Screen not found: ${settings.name}'),
    );
  }
}
