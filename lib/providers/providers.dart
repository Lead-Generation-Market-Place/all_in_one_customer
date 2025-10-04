import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:yelpax/core/injection_container.dart';
import 'package:yelpax/features/signin/presentation/controllers/sign_in_controller.dart';
import '../features/home_services/presentation/controllers/home_services_controller.dart';
import '../features/onboarding/onboarding_di.dart';
import '../features/promotion/presentation/controllers/promotion_controller.dart';


import '../config/localization/locale_provider.dart';
import '../config/themes/theme_provider.dart';

List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider(create: (_) => ThemeProvider()),
  ChangeNotifierProvider(create: (_) => LocaleProvider()),
 // ChangeNotifierProvider(create: (_) => createSignInController()),
 ChangeNotifierProvider(create: (_) => getIt<SignInController>(),),
  ChangeNotifierProvider(create: (_) => createOnboardingController()),
  ChangeNotifierProvider(create: (_) => PromotionController()),
  ChangeNotifierProvider(create: (_) => HomeServicesController()),
];
