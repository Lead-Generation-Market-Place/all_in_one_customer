import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yelpax/core/constants/asset_constants.dart';
import 'package:yelpax/features/home_services/presentation/widgets/section_title_widget.dart';

import '../../../../core/constants/height.dart';
import '../../../../core/constants/width.dart';
import '../../../../shared/widgets/custom_shimmer.dart';
import '../../domain/entities/home_services_entity.dart';
import '../controllers/home_services_controller.dart';

class PopularCategoriesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeServicesController>(
      builder: (context, controller, _) {
        if (controller.isLoading) {
          return const CustomShimmer(
            layoutType: ShimmerLayoutType.horizontalList,
          );
        }

        if (controller.homeServices.isEmpty) {
          return InkWell(
            onTap: () => controller.getCategories(),
            child: const Icon(Icons.refresh),
          );
        }

        return _buildHorizontalCategoryList(
          'Popular on Yelpax',
          controller.homeServices,
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
                service.service_name,
                service.subcategory_id,
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
    onTap: () =>
        controller.openService({'name': name, 'imageUrl': imageUrl, 'id': id}),
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
