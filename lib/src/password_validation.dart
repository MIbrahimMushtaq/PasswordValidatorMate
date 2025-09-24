import 'package:flutter/material.dart';
import 'password_rule.dart';
import 'password_validators.dart';

class PasswordValidation extends StatelessWidget {
  final String password;
  final List<PasswordRule>? rules;
  final Widget Function(bool isPassed, String description)? itemBuilder;
  final TextStyle descriptionStyle;
  final Widget? divider;

  // 🔹 Global-level defaults
  final Widget? passWidget;
  final Widget? failedWidget;
  final Color? passColor;
  final Color? failedColor;

  // 🔹 Description colors
  final Color? passDescriptionColor;
  final Color? failedDescriptionColor;

  // 🔹 Callback when validation changes
  final void Function(bool allPassed, Map<String, bool> results)? onValidationChanged;

  const PasswordValidation({
    super.key,
    required this.password,
    this.rules,
    this.itemBuilder,
    this.descriptionStyle = const TextStyle(color: Colors.grey),
    this.divider,
    this.passWidget,
    this.failedWidget,
    this.passColor,
    this.failedColor,
    this.passDescriptionColor,
    this.failedDescriptionColor,
    this.onValidationChanged,
  });

  List<PasswordRule> get _rules {
    if (rules == null || rules!.isEmpty) {
      return PasswordValidators.defaultRules();
    }
    return rules!;
  }

  @override
  Widget build(BuildContext context) {
    final results = {
      for (var rule in _rules) rule.description: rule.validator(password),
    };
    final allPassed = results.values.every((r) => r);

    // 🔹 Trigger callback
    if (onValidationChanged != null) {
      onValidationChanged!(allPassed, results);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _rules.map((rule) {
        final isPassed = results[rule.description]!;

        if (itemBuilder != null) {
          return itemBuilder!(isPassed, rule.description);
        }

        // 🔹 Icon widget: Rule → Global → Built-in fallback
        final widgetToShow = isPassed
            ? (rule.passedWidget ??
            passWidget ??
            Icon(Icons.check, color: rule.passedColor ?? passColor ?? Colors.green))
            : (rule.failedWidget ??
            failedWidget ??
            Icon(Icons.close, color: rule.failedColor ?? failedColor ?? Colors.red));

        // 🔹 Description color: Rule → Global → descriptionStyle
        final effectiveDescriptionStyle = descriptionStyle.copyWith(
          color: isPassed
              ? (rule.passedColor ?? passDescriptionColor ?? descriptionStyle.color)
              : (rule.failedColor ?? failedDescriptionColor ?? descriptionStyle.color),
        );

        return Column(
          children: [
            Row(
              children: [
                widgetToShow,
                const SizedBox(width: 6),
                Expanded(
                  child: Text(rule.description, style: effectiveDescriptionStyle),
                ),
              ],
            ),
            divider ?? const SizedBox(height: 10),
          ],
        );
      }).toList(),
    );
  }
}
