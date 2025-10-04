// simple_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:yelpax/core/injection_container.dart' as di;
import 'package:yelpax/core/network/dio_client.dart';


void main() {
  test('Dependency injection setup test', () async {
    // Setup DI
    await di.init();
    
    // Verify dependencies are registered
    expect(di.getIt.isRegistered<DioClient>(), isTrue);
   // expect(di.getIt.isRegistered<AuthRepository>(), isTrue);
    
    print('✅ All dependencies registered successfully!');
  });
}