import 'password_rule.dart';

class PasswordValidators {
  static List<PasswordRule> defaultRules() {
    return [
      minMaxLength(),
      hasUpperCase(),
      hasLowerCase(),
      hasNumber(),
      noSpacesOrSymbols(),
      caseSensitiveInfo(),
    ];
  }

  static PasswordRule minMaxLength({int min = 8, int max = 16}) {
    return PasswordRule(
      minLength: min,
      maxLength: max,
      description: "Must be between $min–$max characters",
      validator: (p) => p.length >= min && p.length <= max,
    );
  }

  static PasswordRule hasUpperCase() {
    return PasswordRule(
      description: "At least 1 uppercase letter",
      validator: (p) => p.contains(RegExp(r'[A-Z]')),
    );
  }

  static PasswordRule hasLowerCase() {
    return PasswordRule(
      description: "At least 1 lowercase letter",
      validator: (p) => p.contains(RegExp(r'[a-z]')),
    );
  }

  static PasswordRule hasNumber() {
    return PasswordRule(
      description: "At least 1 number",
      validator: (p) => p.contains(RegExp(r'[0-9]')),
    );
  }

  static PasswordRule noSpacesOrSymbols({String disallowed = r".,\-|/=_"}) {
    return PasswordRule(
      disallowedSymbols: disallowed,
      description: "No spaces or $disallowed",
      validator: (p) => !p.contains(RegExp('[ $disallowed]')),
    );
  }

  static PasswordRule caseSensitiveInfo() {
    return PasswordRule(
      description: "Passwords are case sensitive",
      validator: (_) => true,
    );
  }
}
