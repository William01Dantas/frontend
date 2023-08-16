import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/src/adapters/api.dart';
import 'package:frontend/src/domain/services/auth_validation_services.dart';
import 'package:frontend/src/ui/login_screen/login_screen.dart';


void main() {
  group('LoginForm', () {
    testWidgets('Email and password validation', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: LoginForm(authService: AuthService(), auth: Auth(),)),
        ),
      );

      final Finder emailField = find.byKey(const ValueKey('emailField'));
      final Finder passwordField = find.byKey(const ValueKey('passwordField'));
      final Finder loginButton = find.byKey(const ValueKey('loginButton'));

      // Enter invalid email and password
      await tester.enterText(emailField, 'invalidemail');
      await tester.enterText(passwordField, 'short');
      await tester.tap(loginButton);
      await tester.pump();

      expect(find.text('Email inválido'), findsOneWidget);
      expect(find.text('Senha deve conter pelo menos 7 caracteres'), findsOneWidget);

      // Enter valid email and password
      await tester.enterText(emailField, 'test@example.com');
      await tester.enterText(passwordField, 'validpassword');
      await tester.tap(loginButton);
      await tester.pump();

      expect(find.text('Email inválido'), findsNothing);
      expect(find.text('Senha deve conter pelo menos 7 caracteres'), findsNothing);
    });
  });
}
