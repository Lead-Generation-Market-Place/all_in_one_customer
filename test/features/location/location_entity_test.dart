import 'package:flutter_test/flutter_test.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_coordinate_points_entity.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_coordinates_entity.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_location_entity.dart';

void main() {
  group('HomeServicesLocationEntity', () {
    // Test data
    final coordinates = HomeServicesCoordinatesEntity(
      type: 'Point',
      geoPoints: HomeServicesCoordinatePointsEntity(
        longitude: 22.3,
        latitude: 30.23,
      ),
    );

    test('should create entity with correct properties', () {
      // Arrange & Act
      final entity = HomeServicesLocationEntity(
        id: '1',
        type: 'current',
        country: 'USA',
        state: 'CA',
        city: 'San Francisco',
        zipCode: '94102',
        addressLine: '123 Main St',
        createdAt: '2023-01-01',
        updatedAt: '2023-01-01',
        coordinates: coordinates,
      );

      // Assert
      expect(entity.id, '1');
      expect(entity.country, 'USA');
      expect(entity.city, 'San Francisco');
      expect(entity.zipCode, '94102');
      expect(entity.coordinates.type, 'Point');
      expect(entity.coordinates.geoPoints.longitude, 22.3);
      expect(entity.coordinates.geoPoints.latitude, 30.23);
    });

    test('should support value equality', () {
      // Arrange
      final entity1 = HomeServicesLocationEntity(
        id: '1',
        type: 'current',
        country: 'USA',
        state: 'CA',
        city: 'San Francisco',
        zipCode: '94102',
        addressLine: '123 Main St',
        createdAt: '2023-01-01',
        updatedAt: '2023-01-01',
        coordinates: coordinates,
      );

      final entity2 = HomeServicesLocationEntity(
        id: '1',
        type: 'current',
        country: 'USA',
        state: 'CA',
        city: 'San Francisco',
        zipCode: '94102',
        addressLine: '123 Main St',
        createdAt: '2023-01-01',
        updatedAt: '2023-01-01',
        coordinates: coordinates,
      );

      // Assert
      expect(entity1, equals(entity2));
      expect(entity1, equals(entity2));
    });

    test('should not be equal when properties are different', () {
      // Arrange
      final entity1 = HomeServicesLocationEntity(
        id: '1',
        type: 'current',
        country: 'USA',
        state: 'CA',
        city: 'San Francisco',
        zipCode: '94102',
        addressLine: '123 Main St',
        createdAt: '2023-01-01',
        updatedAt: '2023-01-01',
        coordinates: coordinates,
      );

      final entity2 = HomeServicesLocationEntity(
        id: '2', // Different ID
        type: 'current',
        country: 'USA',
        state: 'CA',
        city: 'San Francisco',
        zipCode: '94102',
        addressLine: '123 Main St',
        createdAt: '2023-01-01',
        updatedAt: '2023-01-01',
        coordinates: coordinates,
      );

      // Assert
      expect(entity1, isNot(equals(entity2)));
    });

    test('should not be equal when coordinates are different', () {
      // Arrange
      final coordinates1 = HomeServicesCoordinatesEntity(
        type: 'Point',
        geoPoints: HomeServicesCoordinatePointsEntity(
          longitude: 22.3,
          latitude: 30.23,
        ),
      );

      final coordinates2 = HomeServicesCoordinatesEntity(
        type: 'Point',
        geoPoints: HomeServicesCoordinatePointsEntity(
          longitude: 23.4, // Different longitude
          latitude: 30.23,
        ),
      );

      final entity1 = HomeServicesLocationEntity(
        id: '1',
        type: 'current',
        country: 'USA',
        state: 'CA',
        city: 'San Francisco',
        zipCode: '94102',
        addressLine: '123 Main St',
        createdAt: '2023-01-01',
        updatedAt: '2023-01-01',
        coordinates: coordinates1,
      );

      final entity2 = HomeServicesLocationEntity(
        id: '1',
        type: 'current',
        country: 'USA',
        state: 'CA',
        city: 'San Francisco',
        zipCode: '94102',
        addressLine: '123 Main St',
        createdAt: '2023-01-01',
        updatedAt: '2023-01-01',
        coordinates: coordinates2,
      );

      // Assert
      expect(entity1, isNot(equals(entity2)));
    });
  });

  group('HomeServicesCoordinatePointsEntity', () {
    test('should support value equality', () {
      // Arrange
      final point1 = HomeServicesCoordinatePointsEntity(
        longitude: 22.3,
        latitude: 30.23,
      );

      final point2 = HomeServicesCoordinatePointsEntity(
        longitude: 22.3,
        latitude: 30.23,
      );

      final point3 = HomeServicesCoordinatePointsEntity(
        longitude: 23.4, // Different
        latitude: 30.23,
      );

      // Assert
      expect(point1, equals(point2));
      expect(point1, isNot(equals(point3)));
    });
  });

  group('HomeServicesCoordinatesEntity', () {
    test('should support value equality', () {
      // Arrange
      final geoPoints = HomeServicesCoordinatePointsEntity(
        longitude: 22.3,
        latitude: 30.23,
      );

      final coordinates1 = HomeServicesCoordinatesEntity(
        type: 'Point',
        geoPoints: geoPoints,
      );

      final coordinates2 = HomeServicesCoordinatesEntity(
        type: 'Point',
        geoPoints: geoPoints,
      );

      final coordinates3 = HomeServicesCoordinatesEntity(
        type: 'Circle', // Different type
        geoPoints: geoPoints,
      );

      // Assert
      expect(coordinates1, equals(coordinates2));
      expect(coordinates1, isNot(equals(coordinates3)));
    });
  });
}