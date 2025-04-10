import 'dart:developer';

import 'package:design_patterns/design_patterns/state_pattern_example/manager/auth_manager/auth_manager.dart';
import 'package:design_patterns/design_patterns/state_pattern_example/service/authentication_api_service.dart';
import 'package:design_patterns/design_patterns/state_pattern_example/utils/string_utils.dart';
import 'package:design_patterns/design_patterns/state_pattern_example/states/user_state/user_state.dart';
import 'package:flutter/material.dart';

import '../../states/user_state/exceptions.dart';
import '../../states/user_state/logout_state.dart';

class AuthManagerImpl implements AuthManager {
  @override
  final AuthenticationApi authenticationApi;

  @override
  UserState currentState = LoggedOutState();

  AuthManagerImpl({required this.authenticationApi});

  @override
  Future<bool> login(UserName username, String password, [String role = 'user']) async {
    try {
      final apiResponse = await authenticationApi.signinUser(
        username: username,
        password: password,
        role: UserRole(role),
      );
      log('${apiResponse['token']}', name: "apiResponse['token']");
      log('${apiResponse['username']}', name: "apiResponse['token']");
      log(role, name: "role");
      String? token = apiResponse['token'];
      String? userName = apiResponse['username'];

      if (token == null || token.isEmpty || StringUtils.isStringEmptyOrWhiteSpaced(token)) {
        throw InvalidTokenException();
      }

      if (userName == null) {
        throw InvalidNameException();
      }

      currentState = await currentState.loginAction(
        UserName(userName),
        UserToken(token),
        UserRole(role),
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
