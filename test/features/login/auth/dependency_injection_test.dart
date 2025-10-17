// test/dependency_injection_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:yelpax/core/auth/auth_manager.dart';
import 'package:yelpax/core/injection_container.dart' as di;
import 'package:yelpax/core/network/dio_client.dart';
import 'package:yelpax/core/storage/secure_storage_service.dart';
import 'package:yelpax/features/signin/domain/repositories/auth_repository.dart';

void main() {
  test('Dependency injection should initialize without circular dependencies', () async {
    // This should not throw any errors
    await di.init();
    
    // Verify all dependencies are registered
    expect(di.getIt.isRegistered<DioClient>(), isTrue);
    expect(di.getIt.isRegistered<AuthManager>(), isTrue);
    expect(di.getIt.isRegistered<AuthRepository>(), isTrue);
    expect(di.getIt.isRegistered<LocalStorageService>(), isTrue);
    
    print('✅ All dependencies registered successfully!');
  });
}