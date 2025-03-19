import 'package:design_patterns/state_pattern_example/app_routes/route_paths.dart';
import 'package:design_patterns/state_pattern_example/manager/auth_manager/auth_manager.dart';
import 'package:design_patterns/state_pattern_example/manager/loading_manager/loading_manager.dart';
import 'package:design_patterns/state_pattern_example/service/authentication_api_service.dart';
import 'package:flutter/material.dart';

class StatePatternLoginScreen extends StatefulWidget {
  const StatePatternLoginScreen({super.key});

  @override
  State<StatePatternLoginScreen> createState() => _StatePatternLoginScreenState();
}

class _StatePatternLoginScreenState extends State<StatePatternLoginScreen> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final authManager = AuthManager(api: AuthenticationApi());

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  void handleLogin(BuildContext context) {
    if (formKey.currentState!.validate()) {
      LoadingManager().showLoading(
        context,
        () async {
          return await authManager.login(
            usernameController.text,
            passwordController.text,
          );
        },
      ).then((isLoggedIn) {
        if (!isLoggedIn) return;
        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(context, RoutePaths.home, (route) => false);
        }
      });
    }
  }

  Widget buildTextField(TextEditingController controller, String label, {bool isPassword = false}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      obscureText: isPassword,
      validator: (value) => value!.isEmpty ? 'Please enter $label' : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTextField(usernameController, 'Username'),
              const SizedBox(height: 16),
              buildTextField(passwordController, 'Password', isPassword: true),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  handleLogin(context);
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
