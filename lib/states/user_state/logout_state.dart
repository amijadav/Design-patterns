import 'package:design_patterns/states/user_state/user_state.dart';

import '../../state_pattern_example/utils/string_utils.dart';
import 'exceptions.dart';
import 'login_state.dart';

class LoggedOutState extends UserState {
  @override
  bool get isLoggedIn => false;

  @override
  String get userToken => '';

  @override
  String get username => '';

  @override
  String get userRole => '';

  @override
  Future<UserState> loginAction(
    String? username,
    String? token,
    String? role,
  ) async {
    if (token == null || token.isEmpty || StringUtils().isStringEmptyOrWhiteSpaced(token)) {
      throw InvalidTokenException();
    }

    if (username == null) {
      throw InvalidTokenException();
    }

    if (role == null) {
      throw InvalidTokenException();
    }

    return LoggedInState(
      token: token,
      username: username,
      role: role,
    );
  }

  @override
  Future<UserState> logoutAction() async {
    throw InvalidActionException();
  }
}
