import 'package:design_patterns/example/src/1_constants/routes/auth_routes.dart';
import 'package:design_patterns/example/src/2_adapters/router/router_adapter.dart';
import 'package:design_patterns/example/src/5_managers/router/router_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../1_extensions/route_path.dart';

class RouterManagerImpl implements RouterManger {
  @override
  Future<void> goToHomeScreen(WidgetRef ref) async {
    RouterAdapter routerAdapter = ref.read(provider);
    routerAdapter.clearAllAndGoTo(path: RoutePath(RoutePaths.login));
  }

  Future<void> goToLoginPage(WidgetRef ref) async {
    RouterAdapter routerAdapter = ref.read(provider);
    routerAdapter.clearAllAndGoTo(path: RoutePath(RoutePaths.login));
  }
}
