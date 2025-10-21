import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_entity.dart';

import '../../../../core/constants/height.dart';
import '../controllers/home_services_controller.dart';
import '../widgets/app_bar_widget.dart';

class SeeAllServicesScreen extends StatefulWidget {
  SeeAllServicesScreen({super.key});

  @override
  State<SeeAllServicesScreen> createState() => _SeeAllServicesScreenState();
}

class _SeeAllServicesScreenState extends State<SeeAllServicesScreen> {


  Future<void> initialize()async{
    final controller = Provider.of<HomeServicesController>(context, listen: false);
    await controller.fetchAllHomeServices();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBarWidget(title: Text("All Services")),
        preferredSize: Size.fromHeight(height(context) / 15),
      ),
      body: Consumer(builder: (context, value, child) {
        final controller = Provider.of<HomeServicesController>(context);
        if (controller.isLoading) {
          return _buildLoadingWidget();
        } else if (controller.error != null) {
          return _buildErrorWidget(controller.error!);
        } else {
          return _buildSuccessWidget(controller.homeServices);
        }
      }),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(color: Colors.red, fontSize: 16),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildSuccessWidget(List<HomeServicesEntity> services) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: services.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 items per row
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 3 / 2, // adjust height vs width
      ),
      itemBuilder: (context, index) {
        final service = services[index];
        return _buildServiceCard(context, service.name, service.image_url);
      },
    );
  }

  Widget _buildServiceCard(BuildContext context, String name, String imageUrl) {
    return InkWell(
      onTap: () {
        // TODO: Navigate to service detail screen
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Selected: $name")));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorWidget: (context, url, error) =>
                  const Icon(Icons.error_outline),
              progressIndicatorBuilder: (context, url, progress) =>
                  LinearProgressIndicator(value: progress.progress),
            ),
            Container(
              width: double.infinity,
              color: Colors.black.withOpacity(0.5),
              padding: const EdgeInsets.all(6),
              child: Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
