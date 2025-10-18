import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:yelpax/core/error/exceptions/exceptions.dart';
import 'package:yelpax/features/home_services/data/models/home_services_location_model.dart';
import 'package:yelpax/features/home_services/data/models/home_services_coordinates_model.dart';

import '../models/home_services_CoordinatePoints_model.dart';

abstract class HomeServicesLocationLocalDataSource {
  Future<HomeServicesLocationModel> getCurrentLocation();
}

class HomeServicesLocationLocalDataSourceImpl implements HomeServicesLocationLocalDataSource {
  @override
  Future<HomeServicesLocationModel> getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw CacheException('Location services are disabled');
      }

      // Check permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw PermissionException('Location permissions denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw PermissionException('Location permissions permanently denied');
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Get address from coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isEmpty) {
        throw LocationException('Could not retrieve address information');
      }

      Placemark placemark = placemarks.first;

      // Create and return location model
      return HomeServicesLocationModel(
        id: 'current_location', // Since this is not from API
        type: 'current',
        country: placemark.country ?? '',
        state: placemark.administrativeArea ?? '',
        city: placemark.locality ?? '',
        zipCode: placemark.postalCode ?? '',
        addressLine: _buildAddressLine(placemark),
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
        coordinates: HomeServicesCoordinatesModel(
          //longitude: position.longitude,
          //latitude: position.latitude,
           type: '', geoPoints: HomeServicesCoordinatePointsModel.empty(),
        ),
      );
    } catch (e) {
      if (e is LocationException || e is PermissionException) {
        rethrow;
      }
      throw LocationException('Failed to get location: ${e.toString()}');
    }
  }

  String _buildAddressLine(Placemark placemark) {
    List<String> addressParts = [];
    if (placemark.street != null) addressParts.add(placemark.street!);
    if (placemark.subLocality != null) addressParts.add(placemark.subLocality!);
    if (placemark.locality != null) addressParts.add(placemark.locality!);
    
    return addressParts.isNotEmpty ? addressParts.join(', ') : 'Unknown location';
  }
}