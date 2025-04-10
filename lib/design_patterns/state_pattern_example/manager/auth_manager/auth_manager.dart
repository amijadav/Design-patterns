import 'package:design_patterns/design_patterns/state_pattern_example/manager/auth_manager/auth_manager_impl.dart';
import 'package:design_patterns/design_patterns/state_pattern_example/service/authentication_api_service.dart';
import 'package:design_patterns/design_patterns/state_pattern_example/states/user_state/user_state.dart';

abstract class AuthManager {
  static AuthManager? _instance;

  factory AuthManager({required AuthenticationApi api}) =>
      _instance ??= AuthManagerImpl(authenticationApi: api);

  AuthenticationApi get authenticationApi;
  UserState get currentState;

  Future<bool> login(UserName username, String password, [String role = 'user']);
  Future<bool> logout();
}
