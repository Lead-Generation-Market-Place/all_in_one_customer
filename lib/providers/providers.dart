import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:yelpax/features/home_services/presentation/controllers/home_services_controller.dart';
import 'package:yelpax/features/onboarding/onboarding_di.dart';
import 'package:yelpax/features/promotion/presentation/controllers/promotion_controller.dart';
import 'package:yelpax/features/signin/auth_di.dart';

import '../config/localization/locale_provider.dart';
import '../config/themes/theme_provider.dart';

List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider(create: (_) => ThemeProvider()),
  ChangeNotifierProvider(create: (_) => LocaleProvider()),
  ChangeNotifierProvider(create: (_) => createSignInController()),
  ChangeNotifierProvider(create: (_) => createOnboardingController()),
  ChangeNotifierProvider(create: (_) => PromotionController()),
  ChangeNotifierProvider(create: (_) => HomeServicesController()),
];
