import 'package:design_patterns/state_pattern_example/manager/auth_manager/auth_manager.dart';
import 'package:design_patterns/state_pattern_example/service/authentication_api_service.dart';
import 'package:design_patterns/states/user_state/user_state.dart';
import 'package:flutter/material.dart';

import '../../../states/user_state/exceptions.dart';
import '../../../states/user_state/logout_state.dart';





class AuthManagerImpl implements AuthManager {
  @override
  final AuthenticationApi authenticationApi;

  @override
  UserState currentState = LoggedOutState();

  AuthManagerImpl({required this.authenticationApi});

  @override
  Future<bool> login(String username, String password, [String role = 'user']) async {
    try {
      final apiResponse = await authenticationApi.signinUser(
        username: username,
        password: password,
        role: role,
      );

      currentState = await currentState.loginAction(
        apiResponse['username'],
        apiResponse['token'],
        role,
      );
      return true;
    } on AuthException catch (e) {
      switch (e) {
        case InvalidActionException():
          debugPrint(e.toString());
        default:
          break;
      }

      return false;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      currentState = await currentState.logoutAction();
      return true;
    } on AuthException catch (e) {
      switch (e) {
        case InvalidActionException():
          debugPrint(e.toString());
        default:
          break;
      }

      return false;
    }
  }
}
