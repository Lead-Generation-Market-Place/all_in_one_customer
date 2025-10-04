import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:logger/web.dart';
import 'package:provider/provider.dart';
import 'config/localization/l10n/l10n.dart';
import 'config/localization/locale_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'config/routes/router.dart';
import 'config/themes/theme_provider.dart';
import 'core/constants/app_constants.dart';
import 'core/utils/app_restart.dart';
import 'providers/providers.dart';
import 'shared/screens/unexpected_error_screen.dart';
import 'shared/screens/unexpected_release_mode_error.dart';
import 'generated/app_localizations.dart';
import 'core/injection_container.dart' as di;


void main() {
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      ErrorWidget.builder = (FlutterErrorDetails details) {
        if (kReleaseMode) {
          return UnexpectedReleaseModeError(message: details.toString());
        }
        return MaterialApp(
          navigatorKey: AppConstants.navigateKeyword,
          home: UnexpectedErrorScreen(message: details.toString()),
        );
      };
      di.init();// injecting the containers for clean architecture
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
      AppConstants.navigateKeyword.currentState!.push(
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

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
      initialRoute: AppRouter.splash,
      navigatorKey: AppConstants.navigateKeyword,
      onGenerateRoute: AppRouter.generateRoute,
      onUnknownRoute: (settings) => AppRouter.unknownRoute(settings),
      locale: provider.locale,
      supportedLocales: L10n.all,
      localizationsDelegates: [
        AppLocalizations.delegate, // <- Generated file to use localization
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      title: AppConstants.app_name,
      theme: themeProvider.themeData,
    );
  }
}
