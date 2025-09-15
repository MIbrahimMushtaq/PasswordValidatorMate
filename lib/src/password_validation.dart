import 'package:flutter/material.dart';
import 'password_rule.dart';
import 'password_validators.dart';

class PasswordValidation extends StatelessWidget {
  final String password;
  final List<PasswordRule>? rules;
  final Widget Function(bool isPassed, String description)? itemBuilder;
  final TextStyle descriptionStyle;
  final Widget? divider;

  const PasswordValidation({
    super.key,
    required this.password,
    this.rules,
    this.itemBuilder,
    this.descriptionStyle = const TextStyle(color: Colors.grey),
    this.divider,
  });

  List<PasswordRule> get _rules {
    if (rules == null || rules!.isEmpty) {
      return PasswordValidators.defaultRules();
    }
    return rules!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _rules.map((rule) {
        final isPassed = rule.validator(password);

        if (itemBuilder != null) {
          return itemBuilder!(isPassed, rule.description);
        }

        final widgetToShow = isPassed
            ? (rule.passedWidget ?? Icon(Icons.check, color: rule.passedColor))
            : (rule.failedWidget ?? Icon(Icons.close, color: rule.failedColor));

        return Column(
          children: [
            Row(
              children: [
                widgetToShow,
                const SizedBox(width: 6),
                Expanded(
                  child: Text(rule.description, style: descriptionStyle),
                ),
              ],
            ),
            SizedBox(height: 10)
          ],
        );
      }).toList(),
    );
  }
}
