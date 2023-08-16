import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/src/domain/services/auth_validation_services.dart';


void main() {
  group('AuthService', () {
    final authService = AuthService();

    test('Email validation - valid email', () {
      expect(authService.isValidEmail('test@example.com'), true);
    });

    test('Email validation - invalid email', () {
      expect(authService.isValidEmail('invalidemail'), false);
    });
  });
}
