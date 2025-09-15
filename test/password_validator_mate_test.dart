import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:password_validator_mate/password_validator_mate.dart';

void main() {
  group('PasswordRule Validator Tests', () {
    test('minMaxLength validator works correctly', () {
      final rule = PasswordValidators.minMaxLength(min: 6, max: 12);

      expect(rule.validator("abc"), false);      // too short
      expect(rule.validator("abcdefgh"), true);   // valid
      expect(rule.validator("abcdefghijklmnop"), false); // too long
    });

    test('hasUpperCase validator works correctly', () {
      final rule = PasswordValidators.hasUpperCase();

      expect(rule.validator("abc"), false);
      expect(rule.validator("Abc"), true);
    });

    test('hasNumber validator works correctly', () {
      final rule = PasswordValidators.hasNumber();

      expect(rule.validator("abc"), false);
      expect(rule.validator("abc1"), true);
    });

    test('noSpacesOrSymbols validator works correctly', () {
      final rule = PasswordValidators.noSpacesOrSymbols();

      expect(rule.validator("abc"), true);
      expect(rule.validator("a b c"), false); // contains space
      expect(rule.validator("a,b.c"), false); // contains symbols
    });
  });

  group('PasswordValidation widget test', () {
    testWidgets('renders all rules by default', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PasswordValidation(password: 'Abc123!'),
          ),
        ),
      );

      // Check if text widgets for rules exist
      expect(find.textContaining('Must be between'), findsOneWidget);
      expect(find.textContaining('At least 1 uppercase'), findsOneWidget);
      expect(find.textContaining('At least 1 lowercase'), findsOneWidget);
      expect(find.textContaining('At least 1 number'), findsOneWidget);
      expect(find.textContaining('No spaces or'), findsOneWidget);
      expect(find.textContaining('Passwords are case sensitive'), findsOneWidget);
    });
  });
}
