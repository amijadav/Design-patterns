import 'package:design_patterns/state_pattern_example/manager/loading_manager/loading_manager.dart';
import 'package:flutter/material.dart';

abstract class AuthenticationApi {
  static final AuthenticationApi _apiInstance =
      AuthenticationApiImpl(loadingManager: LoadingManager());
  factory AuthenticationApi() => _apiInstance;

  Future<Map<String, String>> signinUser({
    required String username,
    required String password,
    required String role,
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
    required String username,
    required String password,
    required String role,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      return {
        'token': 'jwt_token_${DateTime.now().millisecondsSinceEpoch}',
        'username': username,
        'role': role,
      };
    } catch (e) {
      debugPrint('Signin error: $e');
      rethrow;
    }
  }
}
