import 'package:design_patterns/design_patterns/singleton_pattern_example.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AuthManager authManager;
  late UserState userState;
  late AuthenticationApi api;

  setUp(() {
    api = AuthenticationApi();
    authManager = AuthManager(api: api);
    userState = authManager.userState;
  });

  group('login logout Tests', () {
    test('User should start in a logged-out state with no saved details', () {
      expect(userState.isLoggedIn, false);
      expect(userState.userToken, '');
      expect(userState.username, '');
      expect(userState.userRole, '');
    });

    test('Login updates user state with valid credentials', () async {
      final result = await authManager.login('valid_username', 'valid_password');
      expect(result, true);
      expect(userState.isLoggedIn, true);
      expect(userState.username, 'valid_username');
      expect(userState.userToken.isNotEmpty, true);
    });

    test('Logout clears user state', () async {
      await authManager.login('valid_username', 'valid_password');
      expect(userState.isLoggedIn, true);
      await authManager.logout();
      expect(userState.isLoggedIn, false);
      expect(userState.userToken, '');
    });
  });

  group('UserState Tests', () {
    test('resets all properties', () {
      userState
        ..isLoggedIn = true
        ..userToken = 'token123'
        ..username = 'test_user'
        ..userRole = 'admin';
      userState.clear();
      expect(userState.isLoggedIn, false);
      expect(userState.userToken, '');
    });
  });

  group('Loading feedback Test', () {
    test('Loading should provide valid feedback to user', () {
      expect(identical(LoadingManager(), LoadingManager()), true);
    });
  });

  group('User signin Tests', () {
    test('signinUser returns valid token and user info', () async {
      final result = await api.signinUser(
        username: 'test_user',
        password: 'password123',
        role: 'user',
        userState: userState,
      );
      expect(result['token']!.isNotEmpty, true);
      expect(result['username'], 'test_user');
    });

    test('signOutUser completes without exception', () async {
      expect(api.signOutUser(), completes);
    });
  });

  group('Authentication Flow Tests', () {
    test('User should log in and out successfully', () async {
      expect(await authManager.login('test_user', 'password123'), true);
      expect(userState.isLoggedIn, true);
      expect(await authManager.logout(), true);
      // expect(userState.isLoggedIn, false);
    });
  });
}
