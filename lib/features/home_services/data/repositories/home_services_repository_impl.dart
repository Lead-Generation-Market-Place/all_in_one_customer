import 'package:dartz/dartz.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yelpax/core/network/network_info.dart';
import 'package:yelpax/features/home_services/data/datasources/home_services_location_local_data_source.dart';
import 'package:yelpax/features/home_services/data/models/home_service_promotion_model.dart';
import 'package:yelpax/features/home_services/data/models/home_services_CoordinatePoints_model.dart';
import 'package:yelpax/features/home_services/data/models/home_services_coordinates_model.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_entity.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_fetch_professionals_entity.dart';
import 'package:yelpax/features/home_services/domain/entities/home_services_location_entity.dart';
import '../../../../core/error/exceptions/exceptions.dart';
import '../../../../core/error/failures/failure.dart';
import '../datasources/home_services_remote_data_source.dart';
import '../../domain/repositories/home_services_repository.dart';
import '../models/home_services_location_model.dart';

class HomeServicesRepositoryImpl implements HomeServicesRepository {
  final HomeServicesRemoteDataSource remoteDataSource;
  final HomeServicesLocationLocalDataSource locationLocalDataSource;
  final NetworkInfo networkInfo;
  HomeServicesRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.locationLocalDataSource,
  });

  @override
  Future<Either<Failure, List<HomeServicesEntity>>> fetchServicesQuery(
    String query,
  ) async {
    try {
      final result = await remoteDataSource.fetchServicesQuery(query);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(GenericFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<HomeServicesEntity>>> getHomeServices() async {
    try {
      final models = await remoteDataSource.fetchHomeServices();
      if (!await networkInfo.isConnected) {
        return Left(NoInternetFailure('No Internet Connection'));
      }
      return Right(models);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on CustomDioException catch (e) {
      return Left(DioFailure(e.message));
    } catch (e) {
      return Left(GenericFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<HomeServicePromotionModel>>>
  getPromotions() async {
    try {
      final models = await remoteDataSource.fetchPromotions();
      if (!await networkInfo.isConnected) {
        return Left(NoInternetFailure('No Internet Connection'));
      }
      return Right(models);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on CustomDioException catch (e) {
      return Left(DioFailure(e.message));
    } catch (e) {
      return Left(GenericFailure(e.toString()));
    }
  }

   

  @override
  Future<Either<Failure, List<HomeServicesFetchProfessionalsEntity>>> fetchPros(String query) async{
      try {
      final models = await remoteDataSource.findPros(query);
      if (!await networkInfo.isConnected) {
        return Left(NoInternetFailure('No Internet Connection'));
      }
      return Right(models);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on CustomDioException catch (e) {
      return Left(DioFailure(e.message));
    } catch (e) {
      return Left(GenericFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, List<HomeServicesFetchProfessionalsEntity>>> fetchProsByServiceIdAndZip(String serviceId, String zipCode) async{
      try {
      final models = await remoteDataSource.fetchProsByServiceAndZip(serviceId,zipCode);
      if (!await networkInfo.isConnected) {
        return Left(NoInternetFailure('No Internet Connection'));
      }
      return Right(models);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on CustomDioException catch (e) {
      return Left(DioFailure(e.message));
    } catch (e) {
      return Left(GenericFailure(e.toString()));
    }
  }


  @override
  Future<Either<Failure, HomeServicesLocationEntity>> getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Left(LocationFailure('Location services are disabled. Please enable them.'));
      }

      // Check permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Left(PermissionFailure('Location permissions are denied.'));
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Left(PermissionFailure('Location permissions are permanently denied. Please enable them in app settings.'));
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 15),
      );

      // Get address from coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isEmpty) {
        return Left(LocationFailure('Could not retrieve address information.'));
      }

      Placemark placemark = placemarks.first;

      // Create location entity from device location
      final locationEntity = HomeServicesLocationModel(
        id: 'current_location_${DateTime.now().millisecondsSinceEpoch}',
        type: 'current_device_location',
        country: placemark.country ?? 'Unknown',
        state: placemark.administrativeArea ?? 'Unknown',
        city: placemark.locality ?? 'Unknown',
        zipCode: placemark.postalCode ?? 'Unknown',
        addressLine: _buildAddressLine(placemark),
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
        coordinates: HomeServicesCoordinatesModel(
          type: 'Point',
          geoPoints: HomeServicesCoordinatePointsModel(
            longitude: position.longitude,
            latitude: position.latitude,
          ),
        ),
      );

      return Right(locationEntity);

    } on LocationServiceDisabledException {
      return Left(LocationFailure('Location services are disabled.'));
    } on PermissionDeniedException {
      return Left(PermissionFailure('Location permission denied.'));
    } on TimeoutException {
      return Left(LocationFailure('Location request timed out.'));
    } catch (e) {
      return Left(GenericFailure('Failed to get location: ${e.toString()}'));
    }
  }

  String _buildAddressLine(Placemark placemark) {
    List<String> addressParts = [];
    
    if (placemark.street != null && placemark.street!.isNotEmpty) {
      addressParts.add(placemark.street!);
    }
    if (placemark.subLocality != null && placemark.subLocality!.isNotEmpty) {
      addressParts.add(placemark.subLocality!);
    }
    if (placemark.locality != null && placemark.locality!.isNotEmpty) {
      addressParts.add(placemark.locality!);
    }
    
    return addressParts.isNotEmpty ? addressParts.join(', ') : 'Location information not available';
  }
  
  

}
