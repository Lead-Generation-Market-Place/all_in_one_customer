import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:provider/provider.dart';
import 'package:yelpax/config/localization/l10n/l10n.dart';
import 'package:yelpax/config/localization/locale_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:yelpax/config/routes/router.dart';
import 'package:yelpax/config/themes/theme_provider.dart';
import 'package:yelpax/core/utils/app_restart.dart';
import 'package:yelpax/features/splash/presentation/splash_screen.dart';
import 'package:yelpax/providers/providers.dart';
import 'package:yelpax/shared/screens/unexpected_error_screen.dart';
import 'package:yelpax/shared/screens/unexpected_release_mode_error.dart';
import 'generated/app_localizations.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      ErrorWidget.builder = (FlutterErrorDetails details) {
        if (kReleaseMode) {
          return UnexpectedReleaseModeError(message: details.toString());
        }
        return MaterialApp(
          navigatorKey: navigatorKey,
          home: UnexpectedErrorScreen(message: details.toString()),
        );
      };
      runApp(
        RestartWidget(
          child: MultiProvider(providers: appProviders, child: const MyApp()),
        ),
      );
    },
    (error, stack) {
      Logger().log(
        Level.error,
        "Dart Server Error occured on $error on Stack \n $stack",
      );

      navigatorKey.currentState!.push(
        MaterialPageRoute(
          builder: (context) => UnexpectedErrorScreen(message: 'message'),
        ),
      );
      // navigatorKey.currentState!.pushNamed(AppRouter.unknownRouteScreen);
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      initialRoute: AppRouter.splash,
      navigatorKey: navigatorKey,
      onGenerateRoute: AppRouter.generateRoute,
      onUnknownRoute: (settings) => AppRouter.unknownRoute(settings),
      locale: provider.locale,

      supportedLocales: L10n.all,
      localizationsDelegates: [
        AppLocalizations.delegate, // <- Generated

        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      title: 'Flutter Demo',
      theme: themeProvider.themeData,
    );
  }
}
