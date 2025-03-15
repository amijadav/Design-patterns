// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension type UserToken(String value) {}
extension type Username(String value) {}

enum UserRole {
  admin,
  user,
}

abstract class UserAuthState<T> {
  T toSignedIn();
  T toSignedOut();
}

class UserSignedIn implements UserAuthState<UserAuthState> {
  @override
  UserAuthState toSignedIn() => this;

  @override
  UserAuthState toSignedOut() => UserSignedOut();
}

class UserSignedOut implements UserAuthState<UserAuthState> {
  @override
  UserAuthState toSignedIn() => UserSignedIn();

  @override
  UserAuthState toSignedOut() => this;
}

class UserModel implements UserAuthState<UserModel> {
  final UserToken token;
  final Username username;
  final UserRole role;
  final UserAuthState state;

  UserModel({
    required this.token,
    required this.username,
    required this.role,
    required this.state,
  });

  bool get isSignedIn => state is UserSignedIn;

  UserModel copyWith({
    required UserToken? token,
    required Username? username,
    required UserRole? role,
    required UserAuthState? state,
  }) =>
      UserModel(
        token: token ?? this.token,
        username: username ?? this.username,
        role: role ?? this.role,
        state: state ?? this.state,
      );

  @override
  UserModel toSignedIn() => UserModel(
        token: token,
        username: username,
        role: role,
        state: state.toSignedIn(),
      );

  @override
  UserModel toSignedOut() => UserModel(
        token: token,
        username: username,
        role: role,
        state: state.toSignedOut(),
      );
}

final authenticationProvider = NotifierProvider<UserModel?, >{}

final _usernameController = StateProvider<TextEditingController>(
    (ref) => TextEditingController(text: ''));
final _passwordController = StateProvider<TextEditingController>(
    (ref) => TextEditingController(text: ''));

class InvalidFormStateException implements Exception {
  final FormState? formState;

  InvalidFormStateException(this.formState);

  @override
  String toString() => 'The form state of ${formState} was not found';
}

abstract class LoginScreenController {
  GlobalKey<FormState> get formKey;
  TextEditingController get usernameController;
  TextEditingController get passwordController;

  Future<void> onLoginButtonPressed(WidgetRef ref);
}

abstract class DialogManager {
  Future<void> showUserMessage(WidgetRef ref);
}

class LoginScreenControllerImpl implements LoginScreenController {

  @override
  final formKey = GlobalKey<FormState>();

  @override
  final usernameController = TextEditingController();

  @override
  final passwordController = TextEditingController();

  @override
  Future<void> onLoginButtonPressed(WidgetRef ref) async {
    final formState = ref.read(formKey.notifier).state.currentState;
    if (formState == null) {
      throw InvalidFormStateException(formState);
    }

    if (!formState.validate()) return;

    AuthManager authManager = ref.read();
    DialogManager dialogManager = ref.read();
    RouterManger routerManger = ref.read();

    final success = await LoadingManager().showLoading(
      ref.context,
      () async {
        return await authManager.login(
          ref.read(_usernameController).text,
          ref.read(_passwordController).text,
          ref,
        );
      },
    );

    if (success) {
      await routerManger.goToHomeScreen(ref);
    } else {
      await dialogManager.showUserMessage(
        ref,
      );
    }
  }
}

abstract class AuthenticationApi {
  static final AuthenticationApi _apiInstance =
      AuthenticationApiImpl(loadingManager: LoadingManager());
  factory AuthenticationApi() => _apiInstance;

  Future<Map<String, String>> signinUser({
    required String username,
    required String password,
    required String role,
    required WidgetRef ref,
  });

  Future<void> signOutUser({
    required WidgetRef ref,
  });
}

class AuthManagerImpl implements AuthManager {
  final AuthenticationApi authenticationApi;

  AuthManagerImpl({
    required this.authenticationApi,
  });

  @override
  Future<bool> login(String username, String password, WidgetRef ref) async {
    try {
      final apiResponse = await authenticationApi.signinUser(
          username: username, password: password, role: "user", ref: ref);

      ref.read(isLoggedInProvider.notifier).state = true;
      ref.read(userTokenProvider.notifier).state = apiResponse['token'] ?? '';
      ref.read(usernameProvider.notifier).state = apiResponse['username'] ?? '';
      ref.read(userRoleProvider.notifier).state = apiResponse['role'] ?? '';
      return true;
    } catch (e) {
      debugPrint('$e    eeeeeeeeeee');
      return false;
    }
  }

  @override
  Future<bool> logout(WidgetRef ref) async {
    try {
      await authenticationApi.signOutUser(ref: ref);
      return true;
    } catch (e) {
      return false;
    }
  }
}

class AuthenticationApiImpl implements AuthenticationApi {
  final LoadingManager loadingManager;

  AuthenticationApiImpl({required this.loadingManager});

  @override
  Future<void> signOutUser({required WidgetRef ref}) async {
    await Future.delayed(const Duration(seconds: 1));
    ref.read(isLoggedInProvider.notifier).state = false;
    ref.read(userTokenProvider.notifier).state = '';
    ref.read(usernameProvider.notifier).state = '';
    ref.read(userRoleProvider.notifier).state = '';
    ref.read(_usernameController.notifier).state =
        TextEditingController(text: '');
    ref.read(_passwordController.notifier).state =
        TextEditingController(text: '');
  }

  @override
  Future<Map<String, String>> signinUser({
    required String username,
    required String role,
    required String password,
    required WidgetRef ref,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    return {
      'token': 'jwt_token_${DateTime.now().millisecondsSinceEpoch}',
      'username': username,
      'role': role,
      'password': password
    };
  }
}

class LoadingManagerImpl implements LoadingManager {
  @override
  Future<R> showLoading<R>(
      BuildContext context, Future<R> Function() process) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    return process()
      ..catchError((e) => errorLoading(context, e))
      ..then((_) => Navigator.pop(context));
  }

  @override
  void errorLoading(BuildContext context, dynamic error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(error.toString()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class StatePatternLoginScreen extends ConsumerStatefulWidget {
  const StatePatternLoginScreen({super.key});

  @override
  ConsumerState<StatePatternLoginScreen> createState() =>
      _StatePatternLoginScreenState();
}

class _StatePatternLoginScreenState
    extends ConsumerState<StatePatternLoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: ref.watch(_usernameController),
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter username' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: ref.read(_passwordController),
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter password' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    ref.read(_usernameController).dispose();
    ref.read(_passwordController).dispose();
    super.dispose();
  }
}

class StatePatternHomeScreen extends ConsumerWidget {
  const StatePatternHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final username = ref.watch(usernameProvider);
    final userRole = ref.watch(userRoleProvider);
    final userToken = ref.watch(userTokenProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              LoadingManager().showLoading(context, () async {
                return await AuthManager(api: AuthenticationApi()).logout(ref);
              }).then((_) => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StatePatternLoginScreen()),
                    (route) => false,
                  ));
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome $username!'),
            Text('Role: $userRole'),
            Text('Token: $userToken'),
          ],
        ),
      ),
    );
  }
}
