import 'package:flutter/material.dart';
import 'package:password_validator_mate/password_validator_mate.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PasswordValidationScreen(),
    );
  }
}

class PasswordValidationScreen extends StatefulWidget {
  const PasswordValidationScreen({super.key});

  @override
  State<PasswordValidationScreen> createState() =>
      _PasswordValidationScreenState();
}

class _PasswordValidationScreenState extends State<PasswordValidationScreen> {
  final TextEditingController _controller = TextEditingController();
  bool isPasswordValid = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Password Validator Example")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Enter Password',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {}); // Rebuild to update PasswordValidation
              },
            ),
            const SizedBox(height: 20),
            PasswordValidation(
              password: _controller.text,
              passWidget: Icon(Icons.check, color: Colors.green),
              failedWidget: Icon(Icons.close, color: Colors.red),
              onValidationChanged: (allPassed, results) {
                isPasswordValid = allPassed;  // ✅ store status
                print("All passed: $allPassed");
                print(results); // {Must be at least 8 characters: true, At least one number: false}
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isPasswordValid ? (){
                print('Registering user with password: ${_controller.text}');
              } : null,
              child: Text("Register"),
            )
          ],
        ),
      ),
    );
  }
}
