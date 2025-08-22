import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yelpax/core/constants/height.dart';
import 'package:yelpax/core/constants/width.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_promotion_entity.dart';
import 'package:yelpax/features/home_services/get_promotions_di.dart';
import 'package:yelpax/features/home_services/presentation/controllers/home_services_promotion_controller.dart';
import 'package:yelpax/shared/widgets/custom_shimmer.dart';

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
    return Consumer<HomeServicesPromotionController>(
      builder: (context, value, child) {
        if (value.isPromotionLoading) {
          return _buildPromotionLoading();
        }
        if (value.failure.isNotEmpty) {
          return _buildErrorPromotion(value.failure);
        }
        if (value.isPromotionLoading == false && value.promotions.isEmpty) {
          return _buildEmptyPromotion();
        }
        return _buildPromotionWidget(value.promotions);
      },
    );
  }

  Widget _buildPromotionWidget(List data) {
    return PromotionBannerWidget(
      items: List.generate(
        data.length,
        (index) => _buildPromotionCard(data[index]),
      ),
    );
  }

  Widget _buildPromotionCard(HomeServicesPromotionEntity entity) {
    return Container(
      child: Container(
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),

                borderRadius: BorderRadius.circular(7),
              ),
              child: Text(
                entity.serviceName,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: Colors.white),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(2),

              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),

                borderRadius: BorderRadius.circular(7),
              ),
              child: Text(
                entity.promotionName,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(2),

              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),

                borderRadius: BorderRadius.circular(7),
              ),
              child: Text(
                entity.serviceProviders,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.blue,
        image: DecorationImage(
          image: AssetImage(entity.promotionImage),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildPromotionLoading() {
    return Container(
      width: width(context),
      height: height(context) / 6,
      child: CustomShimmer(layoutType: ShimmerLayoutType.single),
    );
  }

  Widget _buildEmptyPromotion() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
      width: width(context),
      height: height(context) / 6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => print('retrying...'),
            icon: Icon(Icons.refresh_outlined),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorPromotion(String message) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
      width: width(context),
      height: height(context) / 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message, style: TextStyle(color: Colors.red)),
          IconButton(
            onPressed: () => print('Error...'),
            icon: Icon(Icons.error_outline, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
