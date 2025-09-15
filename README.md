
````markdown
# Password Validator Mate

A fully customizable **Flutter password validation widget**.  
Supports **default rules**, **custom rules**, **custom icons/widgets**, colors, and flexible validations.
## Screenshots

### Static Screenshot
![Validator Screenshot 1](screenshots/s1.png)

### Another Screenshot
![Validator Screenshot 2](screenshots/s2.png)

---

## Features

- Predefined password validation rules:
  - Minimum/Maximum length
  - At least one uppercase letter
  - At least one lowercase letter
  - At least one number
  - No spaces or disallowed symbols
  - Case sensitivity info
- Custom rules support
- Custom pass/fail icons or widgets
- Custom colors for pass/fail
- Divider and text style customization
- Null-safe and fully customizable
- Ready-to-use widget for any Flutter form

---

## Installation

Add the dependency in your `pubspec.yaml`:

```yaml
dependencies:
  password_validator_mate: ^1.0.0
````

Then run:

```bash
flutter pub get
```

Or if using Git:

```yaml
dependencies:
  password_validator_mate:
    git:
      url: https://github.com/yourusername/password_validator_mate.git
      ref: main
```

---

## Usage

Import the package:

```dart
import 'package:password_validator_mate/password_validator_mate.dart';
```

### Basic Example:

```dart
PasswordValidation(
  password: "Abc123!",
  rules: [
    PasswordValidators.minMaxLength(min: 6, max: 12).copyWith(
      passedWidget: Icon(Icons.thumb_up, color: Colors.green),
      failedWidget: Icon(Icons.thumb_down, color: Colors.red),
    ),
    PasswordValidators.hasNumber(),
  ],
  divider: Divider(),
);
```

### Example with Text Input:

```dart
TextFormField(
  controller: _controller,
  obscureText: true,
  decoration: InputDecoration(
    labelText: 'Enter Password',
    border: OutlineInputBorder(),
  ),
  onChanged: (value) {
    setState(() {}); // Updates PasswordValidation live
  },
),

PasswordValidation(
  password: _controller.text,
  rules: [
    PasswordValidators.minMaxLength(min: 6, max: 12),
    PasswordValidators.hasNumber(),
    PasswordValidators.hasUpperCase(),
    PasswordValidators.hasLowerCase(),
    PasswordValidators.noSpacesOrSymbols(),
  ],
  divider: Divider(),
);
```

---

## Customization

You can customize each rule individually:

```dart
PasswordValidators.minMaxLength(min: 6, max: 12).copyWith(
  passedWidget: Image.asset('assets/tick.png', width: 18, height: 18),
  failedWidget: Image.asset('assets/cross.png', width: 18, height: 18),
  passedColor: Colors.green,
  failedColor: Colors.red,
);
```

**Custom Rules Example:**

```dart
PasswordRule(
  description: "No repeated characters",
  validator: (password) => !RegExp(r'(.)\1').hasMatch(password),
);
```

---

## Default Rules

| Rule              | Description                                             |                     |
| ----------------- | ------------------------------------------------------- | ------------------- |
| Min/Max Length    | Password must be within specified length (default 8–16) |                     |
| Uppercase Letter  | At least 1 uppercase letter                             |                     |
| Lowercase Letter  | At least 1 lowercase letter                             |                     |
| Number            | At least 1 number                                       |                     |
| No Spaces/Symbols | No spaces or \`. , -                                    | / = \_\` by default |
| Case Sensitivity  | Passwords are case sensitive                            |                     |

See [RULES.md](RULES.md) for more details.

---

## Example App

See the `example/` folder for a working demo app using all features of this package.

---

## License

MIT License

