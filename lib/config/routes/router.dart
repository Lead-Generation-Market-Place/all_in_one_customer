import 'package:flutter/material.dart';
import 'package:yelpax/core/constants/app_constants.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_question_entity.dart';
import 'package:yelpax/features/home_services/presentation/screens/see_all_services_screen.dart';
import 'package:yelpax/features/home_services/sub_features/question_flows/screens/question_flow_screen.dart';
import 'package:yelpax/features/homepage/presentation/screens/home_page_screen.dart';
import 'package:yelpax/features/it_services/presentation/screens/it_home_screen.dart';
import 'package:yelpax/features/settings/presentation/screens/settings_screen.dart';
import '../../app/presentation/shell/main_shell_screen.dart';
import '../../core/error/widgets/unknown_route_screen.dart';
import '../../features/grocery/presentation/screens/grocery_screen_homepage.dart';
import '../../features/home_services/domain/entities/home_services_fetch_professionals_entity.dart';
import '../../features/home_services/presentation/screens/home_services_screen.dart.dart';
import '../../features/home_services/presentation/screens/home_services_wishlist_screen.dart';
import '../../features/home_services/sub_features/service_professionals_id_zipcode/screens/service_professionals_screen.dart';
import '../../features/home_services/sub_features/single_service_professional/presentation/screens/single_service_professional_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/signin/presentation/screens/sign_in_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';

class AppRouter {
  static const String splash = '/';
  //  static const String login = '/login';
  static const String signIn = '/SignIn';
  static const String home = '/home'; //test screen
  static const String main_shell_screen = '/mainshellscreen';
  static const String onboarding = '/onboarding';
  static const String featured = '/featured';
  static const String grocery = '/grocery';
  static const String homeServices = '/homeservices';
  static const String seeAllServices = '/seeallservices';
  static const String unknownRouteScreen = '/unknownRouteScreen';
  static const String serviceProfessionalsScreen =
      '/serviceProfessionalsScreen';
  static const String singleServiceProfessionalScreen =
      '/singleServiceProfessionalScreen';
  static const String questionFlowScreen = '/questionFlowScreen';
  static const String itHomeScreen = '/itHomeScreen';
  static const String settingsScreen = '/settingsScreen';
  static const String wishlistScreen = '/wishlistScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case featured:
        return MaterialPageRoute(builder: (_) => const HomePageScreen());
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
      case seeAllServices:
        return MaterialPageRoute(builder: (_) => SeeAllServicesScreen());
      case serviceProfessionalsScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => ServiceProfessionalsScreen(
            serviceId: args['serviceId'] ?? "",
            serviceName: args['serviceName'] ?? "",
            zipCode: args['zipCode'] ?? "",
          ),
        );
      case singleServiceProfessionalScreen:
         String proId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => SingleServiceProfessionalScreen(proId: proId),
        );
      case unknownRouteScreen:
        return MaterialPageRoute(
          builder: (_) =>
              const UnknowRouteScreen(message: 'Unknown Route Screen'),
        );
     case questionFlowScreen:
  final List<HomeServicesQuestionEntity> questions =
      (settings.arguments as List<HomeServicesQuestionEntity>?) ?? [];
  return MaterialPageRoute(
    builder: (_) => QuestionFlowScreen(entities: questions),
  );
      case itHomeScreen:
        return MaterialPageRoute(builder: (_) => const ItHomeScreen());
      case settingsScreen:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case wishlistScreen:
        return MaterialPageRoute(
            builder: (_) => const HomeServicesWishlistScreen());
      default:
        return unknownRoute(settings);
    }
  }

  //when going to unknown routes
  static Route<dynamic> unknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => UnknowRouteScreen(
        message: 'Screen not found: ${settings}',
        onRetry: () => onRetry(),
      ),
    );
  }

  static onRetry() {
    return AppConstants.navigateKeyword.currentState?.pushNamedAndRemoveUntil(
      AppRouter.splash,
      (route) => false,
    );
  }
}
