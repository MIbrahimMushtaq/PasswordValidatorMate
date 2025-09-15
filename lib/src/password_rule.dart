import 'package:flutter/material.dart';

class PasswordRule {
  final String description;
  final bool Function(String password) validator;
  final Widget? passedWidget;
  final Widget? failedWidget;
  final Color passedColor;
  final Color failedColor;
  final int? minLength;
  final int? maxLength;
  final String? disallowedSymbols;

  PasswordRule({
    required this.description,
    required this.validator,
    this.passedWidget,
    this.failedWidget,
    this.passedColor = const Color(0xFF4CAF50),
    this.failedColor = const Color(0xFF9E9E9E),
    this.minLength,
    this.maxLength,
    this.disallowedSymbols,
  });

  PasswordRule copyWith({
    Widget? passedWidget,
    Widget? failedWidget,
    Color? passedColor,
    Color? failedColor,
    int? minLength,
    int? maxLength,
    String? disallowedSymbols,
  }) {
    return PasswordRule(
      description: description,
      validator: validator,
      passedWidget: passedWidget ?? this.passedWidget,
      failedWidget: failedWidget ?? this.failedWidget,
      passedColor: passedColor ?? this.passedColor,
      failedColor: failedColor ?? this.failedColor,
      minLength: minLength ?? this.minLength,
      maxLength: maxLength ?? this.maxLength,
      disallowedSymbols: disallowedSymbols ?? this.disallowedSymbols,
    );
  }
}
