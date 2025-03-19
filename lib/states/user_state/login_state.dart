import 'package:design_patterns/states/user_state/user_state.dart';

import 'exceptions.dart';
import 'logout_state.dart';

class LoggedInState extends UserState<UserState> {
  final String _userToken;
  final String _username;
  final String _userRole;

  LoggedInState({
    required String token,
    required String username,
    required String role,
  })  : _userToken = token,
        _username = username,
        _userRole = role;

  @override
  bool get isLoggedIn => true;

  @override
  String get userToken => _userToken;

  @override
  String get username => _username;

  @override
  String get userRole => _userRole;

  @override
  Future<UserState> loginAction(String? username, String? token, String? role) async {
    throw InvalidActionException();
  }

  @override
  Future<UserState> logoutAction() async {
    return LoggedOutState();
  }
}
