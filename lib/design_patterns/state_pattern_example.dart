// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isLoggedInProvider = StateProvider<bool>((ref) => false);
final userTokenProvider = StateProvider<String>((ref) => '');
final usernameProvider = StateProvider<String>((ref) => '');
final userRoleProvider = StateProvider<String>((ref) => '');
final _usernameController =
    StateProvider<TextEditingController>((ref) => TextEditingController(text: ''));
final _passwordController =
    StateProvider<TextEditingController>((ref) => TextEditingController(text: ''));


void main(){
  runApp();
}


abstract class LoadingManager {
  static final LoadingManager _loadingInstance = LoadingManagerImpl();
  factory LoadingManager() => _loadingInstance;

  Future<R> showLoading<R>(BuildContext context, Future<R> Function() process);
  void errorLoading(BuildContext context, dynamic error);
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

abstract class AuthManager implementsProvider {
  static AuthManager? _instance;
  factory AuthManager({required AuthenticationApi api}) => _instance ??= AuthManagerImpl(
        authenticationApi: api,
      );

  Future<bool> login(String username, String password, WidgetRef ref);
  Future<bool> logout(WidgetRef ref);
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
    try {
      await Future.delayed(const Duration(seconds: 1));
      ref.read(isLoggedInProvider.notifier).state = false;
      ref.read(userTokenProvider.notifier).state = '';
      ref.read(usernameProvider.notifier).state = '';
      ref.read(userRoleProvider.notifier).state = '';
      ref.read(_usernameController.notifier).state = TextEditingController(text: '');
      ref.read(_passwordController.notifier).state = TextEditingController(text: '');
    } catch (e) {
      debugPrint('$e    eeeeeeeeeee');
    }
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
  Future<R> showLoading<R>(BuildContext context, Future<R> Function() process) async {
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
  const StatePatternLoginScreen({super.key, required this.authManager,});

  final AuthManager authManager;

  @override
  ConsumerState<StatePatternLoginScreen> createState() => _StatePatternLoginScreenState();
}

abstract class LoginScreenController{
  final formKey=
}


class _StatePatternLoginScreenState extends ConsumerState<StatePatternLoginScreen> {
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
                validator: (value) => value!.isEmpty ? 'Please enter username' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: ref.read(_passwordController),
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) => value!.isEmpty ? 'Please enter password' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    LoadingManager().showLoading(
                      context,
                      () async {
                        return await .login(
                          ref.read(_usernameController).text,
                          ref.read(_passwordController).text,
                          ref,
                        );
                      },
                    ).then((isLoggedIn) {
                      if (!isLoggedIn) return;
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const StatePatternHomeScreen()),
                        (route) => false,
                      );
                    });
                  }
                },
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
  const StatePatternHomeScreen({super.key, required this.authManager,});

  final AuthManager authManager;

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
                    MaterialPageRoute(builder: (context) => StatePatternLoginScreen(authManager: authManager)),
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
