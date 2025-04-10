import 'package:design_patterns/design_patterns/state_pattern_example/states/user_state/user_state.dart';

import 'exceptions.dart';
import 'logout_state.dart';

class LoggedInState extends UserState<UserState> {
  final UserToken _userToken;
  final UserName _username;
  final UserRole _userRole;

  LoggedInState({
    required UserToken token,
    required UserName username,
    required UserRole role,
  })  : _userToken = token,
        _username = username,
        _userRole = role;

  @override
  IsLoggedIn get isLoggedIn => IsLoggedIn(true);

  @override
  UserToken get userToken => _userToken;

  @override
  UserName get username => _username;

  @override
  UserRole get userRole => _userRole;

  @override
  Future<UserState> loginAction(UserName? username, UserToken? token, UserRole? role) async {
    throw InvalidActionException();
  }

  @override
  Future<UserState> logoutAction() async {
    return LoggedOutState();
  }
}
