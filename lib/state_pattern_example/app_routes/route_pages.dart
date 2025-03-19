import 'package:design_patterns/state_pattern_example/screen/state_pattern_home_screen.dart';
import 'package:design_patterns/state_pattern_example/screen/state_pattern_login_screen.dart';
import 'package:flutter/cupertino.dart';

import 'route_paths.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.home:
        return CupertinoPageRoute(
          builder: (ctx) => StatePatternHomeScreen(),
        );

      case RoutePaths.login:
        return CupertinoPageRoute(builder: (ctx) => StatePatternLoginScreen());

      default:
        return CupertinoPageRoute(builder: (ctx) => StatePatternLoginScreen());
    }
  }
}
