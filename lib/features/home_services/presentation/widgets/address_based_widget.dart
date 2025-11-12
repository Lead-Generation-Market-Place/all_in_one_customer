import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yelpax/core/constants/asset_constants.dart';
import 'package:yelpax/features/home_services/presentation/widgets/section_title_widget.dart';
import 'package:yelpax/features/home_services/presentation/widgets/wishlist_heart_widget.dart';

import '../../../../core/constants/height.dart';
import '../../../../core/constants/width.dart';
import '../../../../shared/widgets/custom_shimmer.dart';
import '../../domain/entities/home_services_entity.dart';
import '../controllers/home_services_controller.dart';

class AddressBasedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeServicesController>(
      builder: (context, controller, _) {
        if (controller.isNearbyServicesLoading) {
          return const CustomShimmer(
            layoutType: ShimmerLayoutType.horizontalList,
          );
        }

        if (controller.nearbyHomeServices.isEmpty &&
            controller.isNearbyServicesLoading == false) {
          return _buildEmptyNearbyWidget(controller);
        }

        if (controller.nearbyHomeServicesError.isNotEmpty &&
            controller.isNearbyServicesLoading == false) {
          return _buildErrorWidget();
        }

        return _buildHorizontalCategoryList(
          'Services Near You',
          controller.nearbyHomeServices,
          context,
        );
      },
    );
  }
}

Widget _buildHorizontalCategoryList(
  String sectionTitle,
  List<HomeServicesEntity> services,

  BuildContext context,
) {
  return Card(
    child: Column(
      children: [
        SectionTitleWidget(title: sectionTitle),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          width: width(context),
          height: height(context) / 6,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: services.length + 1,
            itemBuilder: (context, index) {
              if (index == services.length) {
                return _buildCategoryItem(
                  context,
                  'See All',
                  AssetConstants.SeeAllServicesPic,
                  'dummy_id',
                );
              }
              final service = services[index];
              return _buildCategoryItem(
                context,
                service.name,
                AssetConstants.AssetApi + service.image_url,
                service.id,
              );
            },
          ),
        ),
      ],
    ),
  );
}

//static widgets
Widget _buildCategoryItem(
  BuildContext context,
  String name,
  String imageUrl,
  String id,
  
) {
  final controller = context.read<HomeServicesController>();
  return InkWell(
    onTap: () {
      controller.openService({
        'name': name,
        'imageUrl': imageUrl,
        'id': id,
        'zipCode': '',
      });
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CachedNetworkImage(
              height: height(context),
              width: width(context) / 1.8,
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => _buildErrorWidget(),
              progressIndicatorBuilder: (context, url, progress) => SizedBox(
                child: LinearProgressIndicator(value: progress.progress),
              ),
            ),
         id!="dummy_id"?   Positioned(
              top: 8,
              right: 8,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: WishlistHeartWidget(
                  service: HomeServicesEntity(
                    id: id,
                    name: name,
                    image_url: imageUrl,
                    description: '',
                    is_active: true,
                    created_at: '',
                    updated_at: '',
                    slug: '',
                    subcategory_id: '',
                  ),
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ):SizedBox.shrink(),
            Container(
              width: width(context) / 1.8,
              color: Colors.black.withOpacity(0.4),
              padding: const EdgeInsets.all(6),
              child: Text(
                name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildErrorWidget() {
  return Container(
    child: const Icon(Icons.error_outline_outlined, color: Colors.red),
  );
}

Widget _buildEmptyNearbyWidget(HomeServicesController controller) {
  return Container(
    decoration: BoxDecoration(
      border: BoxBorder.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(7),
    ),
    child: Column(
      children: [
        Center(
          child: Text(
            "No Services Available In Your Current Area",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
        SizedBox(height: 8),
        InkWell(
          child: Icon(Icons.refresh, color: Colors.cyan),
          onTap: () => controller.fetchNearbyHomeServices(),
        ),
      ],
    ),
  );
}
