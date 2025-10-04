import 'package:flutter/material.dart';
import 'package:yelpax/config/themes/schemes/it_theme.dart';
import 'schemes/grocery_theme.dart';

import 'schemes/food_theme.dart';
import 'theme_mode_type.dart';
import 'schemes/light_theme.dart';
import 'schemes/dark_theme.dart';
import 'schemes/home_services_theme.dart';

class AppTheme {
  static ThemeData getThemeByType(ThemeModeType type) {
    switch (type) {
      case ThemeModeType.dark:
        return darkTheme;
      case ThemeModeType.homeServices:
        return homeServicesTheme;
      case ThemeModeType.food:
        return foodTheme;
      case ThemeModeType.light:
        return lightTheme;
      case ThemeModeType.grocery:
        return groceryTheme;
      case ThemeModeType.it:
        return itServicesTheme;
    }
  }
}
