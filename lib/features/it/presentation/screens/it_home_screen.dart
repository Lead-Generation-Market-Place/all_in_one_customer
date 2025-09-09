import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/presentation/shell/widgets/custom_bottom_nav.dart';
import '../../../../config/themes/theme_mode_type.dart';
import '../../../../config/themes/theme_provider.dart';
import '../../../../core/constants/height.dart';
import '../../../home_services/presentation/widgets/app_bar_widget.dart';

class ItHomeScreen extends StatefulWidget {
  const ItHomeScreen({super.key});

  @override
  State<ItHomeScreen> createState() => _ItHomeScreenState();
}

class _ItHomeScreenState extends State<ItHomeScreen> {

  void _initializeData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final theme = Provider.of<ThemeProvider>(context, listen: false);
      // final controller = Provider.of<HomeServicesController>(
      //   context,
      //   listen: false,
      // );

      theme.setTheme(ThemeModeType.it);
 //     controller.getCategories();
    });
  }

@override
  void initState() {
   _initializeData();
    // TODO: implement initState
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBarWidget(),
        preferredSize: Size.fromHeight(height(context) / 15),
      ),
      drawer: Drawer(),
      backgroundColor: Colors.white,
      body: Center(child: Text('IT Services')),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
        onTap: (value) => print(value),
      ),
    );
  }
}
