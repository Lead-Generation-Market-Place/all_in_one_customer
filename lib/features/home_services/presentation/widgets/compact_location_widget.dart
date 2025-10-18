import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yelpax/features/home_services/presentation/controllers/home_services_location_controller.dart';

import '../../domain/entities/home_services_location_entity.dart';
class CompactLocationWidget extends StatelessWidget {
  const CompactLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeServicesLocationController>(
      builder: (context, locationProvider, child) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Location',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    if (locationProvider.isLoading)
                      const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                
                if (locationProvider.hasLocation && !locationProvider.isLoading)
                  _buildLocationInfo(locationProvider.currentLocation!),
                
                if (!locationProvider.hasLocation && !locationProvider.isLoading)
                  _buildGetLocationButton(context),
                
                if (locationProvider.hasError && !locationProvider.isLoading)
                  _buildErrorInfo(context, locationProvider.error!),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLocationInfo(HomeServicesLocationEntity location) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '📍 ${location.city}, ${location.state}',
          style: const TextStyle(fontSize: 14),
        ),
        Text(
          '📮 ${location.zipCode}',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: () {
            // You can add functionality to change location
          },
          child: const Text('Change Location'),
        ),
      ],
    );
  }

  Widget _buildGetLocationButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => context.read<HomeServicesLocationController>().getCurrentLocation(),
        icon: const Icon(Icons.location_on, size: 16),
        label: const Text('Get Location'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 8),
        ),
      ),
    );
  }

  Widget _buildErrorInfo(BuildContext context, String error) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '❌ $error',
          style: const TextStyle(fontSize: 12, color: Colors.red),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => context.read<HomeServicesLocationController>().getCurrentLocation(),
                child: const Text('Retry'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}