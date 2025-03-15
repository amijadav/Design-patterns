import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AuthManager {
  Future<bool> login(
    WidgetRef ref,
    String username,
    String password,
  );

  Future<bool> logout(
    WidgetRef ref,
  );
}
