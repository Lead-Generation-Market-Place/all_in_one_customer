// test/features/auth/domain/usecases/sign_in_usecase_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yelpax/features/signin/domain/entities/signin_entity.dart';
import 'package:yelpax/features/signin/domain/repositories/auth_repository.dart';
import 'package:yelpax/features/signin/domain/usecases/sign_in_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late SignInUseCase signInUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    signInUseCase = SignInUseCase(repository: mockAuthRepository);
    
    // Register fallback values for null safety
    registerFallbackValue(SigninEntity(token: '', email: ''));
  });

 test('should call repository signIn method with correct parameters', () async {
  print('🧪 Test started...');
  
  // Arrange
  const email = 'esmat@gmail.com';
  const password = '123456';
  final expectedEntity = SigninEntity(token: 'test_token', email: email);
  
  when(() => mockAuthRepository.signIn(email, password))
      .thenAnswer((_) async {
    print('✅ Mock repository called with: $email, $password');
    return expectedEntity;
  });

  // Act
  print('🎯 Calling usecase...');
  final result = await signInUseCase.call(email, password);
  print('📦 Result received: ${result.token}, ${result.email}');

  // Assert
  verify(() => mockAuthRepository.signIn(email, password)).called(1);
  expect(result, expectedEntity);
  
  print('🎉 Test completed successfully!');
});
}