import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yelpax/features/home_services/get_promotions_di.dart';
import 'package:yelpax/features/home_services/presentation/controllers/home_services_promotion_controller.dart';

import '../widgets/promotion_banner_widget.dart';

class HomeServicesPromotionScreen extends StatefulWidget {
  const HomeServicesPromotionScreen({super.key});

  @override
  State<HomeServicesPromotionScreen> createState() =>
      _HomeServicesPromotionScreenState();
}

class _HomeServicesPromotionScreenState
    extends State<HomeServicesPromotionScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeServicesPromotionController>(
      create: (context) => getPromotionDi(),
      child: _buildPromotionSection(),
    );
  }

  Widget _buildPromotionSection() {
    return _buildPromotionWidget();
  }

  Widget _buildPromotionWidget() {
    return PromotionBannerWidget(
      items: [
        Container(color: Colors.amber, width: 50, height: 50),
        Container(color: Colors.pink, width: 50, height: 50),
        Container(color: Colors.orange, width: 50, height: 50),
        Container(color: Colors.red, width: 50, height: 50),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/splash_1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
