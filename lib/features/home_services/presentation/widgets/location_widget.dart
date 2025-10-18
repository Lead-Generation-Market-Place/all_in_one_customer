import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yelpax/features/home_services/presentation/controllers/home_services_location_controller.dart';

import '../../domain/entities/home_services_location_entity.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeServicesLocationController>(
      builder: (context, locationProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Location Button
            _buildLocationButton(context, locationProvider),
            
            const SizedBox(height: 16),
            
            // Loading Indicator
            if (locationProvider.isLoading) _buildLoadingIndicator(),
            
            // Location Display
            if (locationProvider.hasLocation && !locationProvider.isLoading)
              _buildLocationCard(locationProvider.currentLocation!),
            
            // Error Display
            if (locationProvider.hasError && !locationProvider.isLoading)
              _buildErrorCard(context, locationProvider.error!),
          ],
        );
      },
    );
  }

  Widget _buildLocationButton(BuildContext context, HomeServicesLocationController provider) {
    return ElevatedButton.icon(
      onPressed: provider.isLoading ? null : () => _onGetLocationPressed(context),
      icon: const Icon(Icons.location_on),
      label: const Text('Get Current Location'),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: Column(
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 8),
          Text('Getting your location...'),
        ],
      ),
    );
  }

  Widget _buildLocationCard(HomeServicesLocationEntity location) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '📍 Current Location',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildInfoRow('Address', location.addressLine),
            _buildInfoRow('City', location.city),
            _buildInfoRow('State', location.state),
            _buildInfoRow('Zip Code', location.zipCode),
            _buildInfoRow('Country', location.country),
            _buildInfoRow('Coordinates', 
                '${location.coordinates.geoPoints.latitude.toStringAsFixed(4)}, '
                '${location.coordinates.geoPoints.longitude.toStringAsFixed(4)}'),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorCard(BuildContext context, String error) {
    return Card(
      color: Colors.red[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.red),
                const SizedBox(width: 8),
                const Text(
                  'Location Error',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(error),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _onGetLocationPressed(context),
                    child: const Text('Try Again'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextButton(
                    onPressed: () => context.read<HomeServicesLocationController>().clearError(),
                    child: const Text('Dismiss'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(value.isEmpty ? 'Not available' : value),
          ),
        ],
      ),
    );
  }

  void _onGetLocationPressed(BuildContext context) {
    context.read<HomeServicesLocationController>().getCurrentLocation();
  }
}