extension type IsLoggedIn(bool value) {}
extension type UserToken(String userToken) {}
extension type UserName(String userName) {}
extension type UserRole(String userRole) {}

abstract class UserState<S> {
  IsLoggedIn get isLoggedIn;
  UserToken get userToken;
  UserName get username;
  UserRole get userRole;

  Future<S> loginAction(UserName? username, UserToken? token, UserRole? role);
  Future<S> logoutAction();
}
