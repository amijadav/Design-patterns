// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

class UserState {
  bool isLoggedIn;
  String userToken;
  String username;
  String userRole;

  UserState({
    this.isLoggedIn = false,
    this.userToken = '',
    this.username = '',
    this.userRole = '',
  });

  void clear() {
    isLoggedIn = false;
    userToken = '';
    username = '';
    userRole = '';
  }
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
    required UserState userState,
  });

  Future<void> signOutUser();
}

abstract class AuthManager {
  static AuthManager? _instance;
  factory AuthManager({required AuthenticationApi api}) => _instance ??= AuthManagerImpl(
        authenticationApi: api,
      );

  UserState get userState;

  Future<bool> login(String username, String password);
  Future<bool> logout();
}

class AuthManagerImpl implements AuthManager {
  final AuthenticationApi authenticationApi;
  final UserState _userState = UserState();

  AuthManagerImpl({
    required this.authenticationApi,
  });

  @override
  UserState get userState => _userState;

  @override
  Future<bool> login(String username, String password) async {
    try {
      final apiResponse = await authenticationApi.signinUser(
          username: username, password: password, role: "user", userState: _userState);

      _userState.isLoggedIn = true;
      _userState.userToken = apiResponse['token'] ?? '';
      _userState.username = apiResponse['username'] ?? '';
      _userState.userRole = apiResponse['role'] ?? '';
      return true;
    } catch (e) {
      debugPrint('$e    eeeeeeeeeee');
      return false;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await authenticationApi.signOutUser();
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
  Future<void> signOutUser() async {
    final userState = UserState();

    try {
      await Future.delayed(const Duration(seconds: 1));
      userState.clear();
      userState.isLoggedIn = false;
    } catch (e) {
      debugPrint('$e    eeeeeeeeeee');
    }
  }

  @override
  Future<Map<String, String>> signinUser({
    required String username,
    required String role,
    required String password,
    required UserState userState,
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
        content: Text(error),
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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

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
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Please enter username' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
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
                        return await AuthManager(api: AuthenticationApi()).login(
                          _usernameController.text,
                          _passwordController.text,
                        );
                      },
                    ).then((isLoggedIn) {
                      if (!isLoggedIn) return;
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
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
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthManager(api: AuthenticationApi());
    final userState = auth.userState;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              LoadingManager().showLoading(context, () async {
                auth.logout();
              }).then((isLoggedOut) => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
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
            Text('Welcome ${userState.username}!'),
            Text('Role: ${userState.userRole}'),
            Text('Token: ${userState.userToken}'),
          ],
        ),
      ),
    );
  }
}




/* 

Solve conflict we don't have to use 
static final LoadingManager _loadingInstance = LoadingManagerImpl();
(cause if we are using this method, LoadingManager directly assign to LoadingManagerImpl and we have to assign it's instance which we created for it, not loading manager it self )


  we can use any method from below:


1)   static final LoadingManager _loadingInstance = LoadingManager._internal()
  (using this we assign the instance of loading manager to LoadingManagerImpl file)


2)  static LoadingManager? _loadingInstance;
  factory LoadingManager() => _loadingInstance ??= LoadingManagerImpl();
  using this we can set the null value on initial phase, it will only exists when the factory method is called.



  */

  