import 'package:design_patterns/state_pattern_example/app_routes/route_paths.dart';
import 'package:design_patterns/state_pattern_example/manager/auth_manager/auth_manager.dart';
import 'package:design_patterns/state_pattern_example/manager/loading_manager/loading_manager.dart';
import 'package:design_patterns/state_pattern_example/service/authentication_api_service.dart';
import 'package:flutter/material.dart';

class StatePatternHomeScreen extends StatelessWidget {
  StatePatternHomeScreen({super.key});
  final authManager = AuthManager(api: AuthenticationApi());

  void handleLogout(BuildContext context) {
    LoadingManager().showLoading(context, () async {
      return await authManager.logoutAction();
    }).then((_) {
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(context, RoutePaths.login, (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userState = authManager.currentState;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              handleLogout(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome ${userState.username}!'),
            Text('Role: ${userState.userRole}'),
            Text('Token: ${userState.userToken}'),
            Text('Logged in: ${userState.isLoggedIn}'),
          ],
        ),
      ),
    );
  }
}
