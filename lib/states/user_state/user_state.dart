abstract class UserState<S> {
  bool get isLoggedIn;
  String get userToken;
  String get username;
  String get userRole;

  Future<S> loginAction(String? username, String? token, String? role);
  Future<S> logoutAction();
}
