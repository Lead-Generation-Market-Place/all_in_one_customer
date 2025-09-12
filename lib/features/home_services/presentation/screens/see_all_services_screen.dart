import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SeeAllServicesScreen extends StatelessWidget {
  var  services;

   SeeAllServicesScreen({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Services"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: services.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 items per row
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 3 / 2, // adjust height vs width
        ),
        itemBuilder: (context, index) {
         final service=services[index];
          return _buildServiceCard(context, service["name"]!, service["imageUrl"]!);
        },
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, String name, String imageUrl) {
    return InkWell(
      onTap: () {
        // TODO: Navigate to service detail screen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Selected: $name")),
        );
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
                    color: Colors.white, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
