import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../config/themes/theme_mode_type.dart';
import '../../../../config/themes/theme_provider.dart';

class GroceryScreenHomepage extends StatefulWidget {
  const GroceryScreenHomepage({super.key});

  @override
  State<GroceryScreenHomepage> createState() => _GroceryScreenHomepageState();
}

class _GroceryScreenHomepageState extends State<GroceryScreenHomepage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final theme = Provider.of<ThemeProvider>(context, listen: false);
      theme.setTheme(ThemeModeType.grocery);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => print('On pressd'),
        ),
        body: Container(),
      ),
    );
  }
}
