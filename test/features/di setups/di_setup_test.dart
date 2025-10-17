// test/di_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:yelpax/core/injection_container.dart' as di;
import 'package:yelpax/features/home_services/data/datasources/home_services_remote_data_source.dart';
import 'package:yelpax/features/home_services/domain/repositories/home_services_repository.dart';
import 'package:yelpax/features/home_services/domain/usecases/home_services_usecase.dart';
import 'package:yelpax/features/home_services/presentation/controllers/home_services_controller.dart';

void main() {
  test('Dependency injection should work for Home Services', () async {
    await di.init();
    
    // Test all home services dependencies
    expect(di.getIt.isRegistered<HomeServicesRemoteDataSource>(), isTrue);
    expect(di.getIt.isRegistered<HomeServicesRepository>(), isTrue);
    expect(di.getIt.isRegistered<HomeServicesUsecase>(), isTrue);
    expect(di.getIt.isRegistered<HomeServicesController>(), isTrue);
    
    // Verify they can be instantiated
    expect(() => di.getIt<HomeServicesRemoteDataSource>(), returnsNormally);
    expect(() => di.getIt<HomeServicesRepository>(), returnsNormally);
    expect(() => di.getIt<HomeServicesUsecase>(), returnsNormally);
    expect(() => di.getIt<HomeServicesController>(), returnsNormally);
    
    print('✅ All Home Services dependencies registered correctly!');
  });
}