import 'package:flutter/material.dart';
import 'password_rule.dart';
import 'password_validators.dart';

class PasswordValidation extends StatelessWidget {
  final String password;
  final List<PasswordRule>? rules;

  // 🔧 FIX: itemBuilder now builds ONE widget
  final Widget Function(
      bool allPassed,
      Map<String, bool> results,
      )? itemBuilder;

  final TextStyle descriptionStyle;
  final Widget? divider;

  final Widget? passWidget;
  final Widget? failedWidget;
  final Color? passColor;
  final Color? failedColor;

  final Color? passDescriptionColor;
  final Color? failedDescriptionColor;

  final void Function(bool allPassed, Map<String, bool> results)?
  onValidationChanged;

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

    // 🔹 Trigger callback (UNCHANGED)
    if (onValidationChanged != null) {
      onValidationChanged!(allPassed, results);
    }

    // ✅ ONLY FIX: return ONE widget
    if (itemBuilder != null) {
      return itemBuilder!(allPassed, results);
    }

    // ❌ BELOW CODE IS 100% UNCHANGED
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _rules.map((rule) {
        final isPassed = results[rule.description]!;

        final widgetToShow = isPassed
            ? (rule.passedWidget ??
            passWidget ??
            Icon(Icons.check,
                color: rule.passedColor ?? passColor ?? Colors.green))
            : (rule.failedWidget ??
            failedWidget ??
            Icon(Icons.close,
                color: rule.failedColor ?? failedColor ?? Colors.red));

        final effectiveDescriptionStyle = descriptionStyle.copyWith(
          color: isPassed
              ? (rule.passedColor ??
              passDescriptionColor ??
              descriptionStyle.color)
              : (rule.failedColor ??
              failedDescriptionColor ??
              descriptionStyle.color),
        );

        return Column(
          children: [
            Row(
              children: [
                widgetToShow,
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    rule.description,
                    style: effectiveDescriptionStyle,
                  ),
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
