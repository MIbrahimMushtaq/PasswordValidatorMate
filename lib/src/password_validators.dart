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

  static PasswordRule minMaxLength({int min = 8, int? max}) {
    return PasswordRule(
      minLength: min,
      maxLength: max,
      description: max == null
          ? "Must be at least $min characters"
          : "Must be between $min–$max characters",
      validator: (p) {
        if (max == null) {
          return p.length >= min;
        }
        return p.length >= min && p.length <= max;
      },
    );
  }


  static PasswordRule hasUpperCase({String? descriptionForUpperCase}) {
    return PasswordRule(
      description: descriptionForUpperCase ?? "At least One uppercase letter",
      validator: (p) => p.contains(RegExp(r'[A-Z]')),
    );
  }

  static PasswordRule hasLowerCase({String? descriptionForLowerCase}) {
    return PasswordRule(
      description: descriptionForLowerCase ?? "At least One lowercase letter",
      validator: (p) => p.contains(RegExp(r'[a-z]')),
    );
  }

  static PasswordRule hasNumber({String? descriptionForNumber}) {
    return PasswordRule(
      description: descriptionForNumber ?? "At least One number",
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
