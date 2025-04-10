import 'package:design_patterns/design_patterns/state_pattern_example/manager/loading_manager/loading_manager.dart';
import 'package:design_patterns/design_patterns/state_pattern_example/states/user_state/user_state.dart';
import 'package:flutter/material.dart';

abstract class AuthenticationApi {
  static final AuthenticationApi _apiInstance =
      AuthenticationApiImpl(loadingManager: LoadingManager());
  factory AuthenticationApi() => _apiInstance;

  Future<Map<String, String>> signinUser({
    required UserName username,
    required String password,
    required UserRole role,
  });

  Future<void> signOutUser();
}

class AuthenticationApiImpl implements AuthenticationApi {
  final LoadingManager loadingManager;

  AuthenticationApiImpl({required this.loadingManager});

  @override
  Future<void> signOutUser() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      debugPrint('Signout error: $e');
      rethrow;
    }
  }

  @override
  Future<Map<String, String>> signinUser({
    required UserName username,
    required String password,
    required UserRole role,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      return {
        'token': 'jwt_token_${DateTime.now().millisecondsSinceEpoch}',
        'username': username.userName,
        'role': role.userRole,
      };
    } catch (e) {
      debugPrint('Signin error: $e');
      rethrow;
    }
  }
}
