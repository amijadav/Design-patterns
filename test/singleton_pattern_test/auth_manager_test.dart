import 'package:design_patterns/design_patterns/singleton_pattern_example.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mocks.mocks.dart';

void main() {
  late AuthManagerImpl authManager;
  late MockAuthenticationApi mockAuthApi;
  late UserState userState;
  setUp(() {
    mockAuthApi = MockAuthenticationApi();
    authManager = AuthManagerImpl(
      authenticationApi: mockAuthApi,
    );
    userState = authManager.userState;
  });

  group('AuthManager Tests', () {
    test('User should be able to login successfully', () async {
      when(mockAuthApi.signinUser(
        username: anyNamed('username'),
        password: anyNamed('password'),
        role: anyNamed('role'),
        userState: anyNamed('userState'),
      )).thenAnswer((_) async =>
          {'token': 'mock_token', 'username': 'test_user', 'role': 'user'});

      final authManager = AuthManager(api: mockAuthApi);
      final result = await authManager.login('username', 'password');

      expect(result, true, reason: 'The user was not successfully logged in');
    });

    test('User should be able to logout successfully', () async {
      when(mockAuthApi.signOutUser()).thenAnswer((_) async {
        return;
      });

      final authManager = AuthManager(api: mockAuthApi);
      final result = await authManager.logout();

      expect(result, true, reason: 'The user was not successfully logged out');
      expect(userState.isLoggedIn, false,
          reason: 'User is still marked as logged in');
      expect(userState.userToken, '', reason: 'User token was not cleared');
      // expect(userState.username, '', reason: 'Username was not cleared');
      expect(userState.userRole, '', reason: 'User role was not cleared');
    });
  });
}

class MockBuildContext extends Mock implements BuildContext {}
