import 'package:design_patterns/design_patterns/state_pattern_example/utils/string_utils.dart';
import 'package:design_patterns/design_patterns/state_pattern_example/states/user_state/user_state.dart';

import 'exceptions.dart';
import 'login_state.dart';

class LoggedOutState extends UserState {
  @override
  IsLoggedIn get isLoggedIn => IsLoggedIn(false);

  @override
  UserToken get userToken => UserToken('');

  @override
  UserName get username => UserName('');

  @override
  UserRole get userRole => UserRole('');

  @override
  Future<UserState> loginAction(
    UserName? username,
    UserToken? token,
    UserRole? role,
  ) async {
    if (token == null ||
        token.userToken.isEmpty ||
        StringUtils.isStringEmptyOrWhiteSpaced(token.userToken)) {
      throw InvalidTokenException();
    }

    if (username == null) {
      throw InvalidNameException();
    }

    if (role == null) {
      throw InvalidRoleException();
    }

    return LoggedInState(
      token: userToken,
      username: username,
      role: userRole,
    );
  }

  @override
  Future<UserState> logoutAction() async {
    throw InvalidActionException();
  }
}
