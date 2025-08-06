import 'package:flutter/material.dart';
import 'package:yelpax/app/presentation/shell/main_shell_screen.dart';
import 'package:yelpax/core/error/widgets/unknown_route_screen.dart';
import 'package:yelpax/features/grocery/presentation/screens/grocery_screen_homepage.dart';
import 'package:yelpax/features/home_services/presentation/screens/home_services_screen.dart.dart';
import 'package:yelpax/features/home_services/sub_features/service_professionals/presentation/screens/service_professionals_screen.dart';
import 'package:yelpax/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:yelpax/features/signin/presentation/screens/sign_in_screen.dart';
import '../../features/promotion/presentation/screens/promotion_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String signIn = '/SignIn';
  static const String home = '/home'; //test screen
  static const String main_shell_screen = '/mainshellscreen';
  static const String onboarding = '/onboarding';
  static const String featured = '/featured';
  static const String grocery = '/grocery';
  static const String homeServices = '/homeservices';
  static const String unknownRouteScreen = '/unknownRouteScreen';
  static const String serviceProfessionalsScreen =
      '/serviceProfessionalsScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case featured:
        return MaterialPageRoute(builder: (_) => const PromotionScreen());
      // case login:
      //   return MaterialPageRoute(builder: (_) => const LoginScreen());
      case signIn:
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const MainShellScreen());
      case grocery:
        return MaterialPageRoute(builder: (_) => const GroceryScreenHomepage());
      case homeServices:
        return MaterialPageRoute(builder: (_) => const HomeServicesScreen());
      case serviceProfessionalsScreen:
        final arg = settings.arguments ?? {};
        return MaterialPageRoute(
          builder: (context) => ServiceProfessionalsScreen(serviceDetails: arg),
        );
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
