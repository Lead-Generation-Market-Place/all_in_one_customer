import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_location_entity.dart';
import 'package:yelpax/features/home_services/presentation/controllers/home_services_location_controller.dart';

class LocationDisplayWidget extends StatelessWidget {
  const LocationDisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final locationProvider = context.watch<HomeServicesLocationController>();
    
    if (locationProvider.hasLocation) {
      return _buildLocationInfo(locationProvider.currentLocation!);
    }
    
    return const Text('Location not set');
  }

  Widget _buildLocationInfo(HomeServicesLocationEntity location) {
    return Row(
      children: [
        const Icon(Icons.location_on, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            '${location.city}, ${location.state}',
            style: const TextStyle(fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}