import 'package:flutter/material.dart';
import 'package:password_validator_mate/password_validator_mate.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Password Validator Example")),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: PasswordValidation(
            password: "Abc123!",
            rules: [
              PasswordValidators.minMaxLength(min: 6, max: 12).copyWith(
                passedWidget: const Icon(Icons.thumb_up, color: Colors.green),
                failedWidget: const Icon(Icons.thumb_down, color: Colors.red),
              ),
              PasswordValidators.hasNumber(),
            ],
            divider: const Divider(),
          ),
        ),
      ),
    );
  }
}
