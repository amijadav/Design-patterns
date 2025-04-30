// import 'package:design_patterns/design_patterns/bloc_pattern_flutter/bloc_pattern_flutter.dart';
import 'package:design_patterns/design_patterns/composite_pattern/composite_pattern_example.dart';
import 'package:design_patterns/design_patterns/observer_pattern/observer_example.dart';
import 'package:design_patterns/design_patterns/state_pattern_example/screen/state_pattern_home_screen.dart';
import 'package:design_patterns/design_patterns/state_pattern_example/screen/state_pattern_login_screen.dart';
import 'package:design_patterns/solid_principles/dependency_inversion_principle/dependency_inversion_screen.dart';
import 'package:design_patterns/solid_principles/interface_segregation_principle/interface_segregation_screen.dart';
import 'package:design_patterns/solid_principles/liskov_substitution_principle/liskov_substitution_screen.dart';
import 'package:design_patterns/solid_principles/open_close_principle/open_close_screen.dart';
import 'package:design_patterns/solid_principles/solid_priciple_screen_navigations.dart';
import 'package:flutter/cupertino.dart';

// import '../design_patterns/bloc_pattern/bloc_model.dart';
import '../design_patterns/bloc_pattern/bloc_pattern_example.dart';
import '../design_patterns/bloc_pattern_flutter/counter_screen_flutter.dart';
import '../design_patterns/builder_pattern_example.dart';
import '../design_patterns/decorator_pattern/decorator_pattern.dart';
import '../design_patterns/factory_pattern_and_abstract_factory_pattern/screen/abstract_factory_pattern.dart';
import '../design_patterns/factory_pattern_and_abstract_factory_pattern/screen/factory_pattern.dart';
import '../design_patterns/model_view_controller_pattern/screen/model_view_controller_pattern.dart';
import '../design_patterns/model_view_view_model_pattern/view.dart';
import '../design_patterns/singleton_pattern_example.dart';
import '../page_control_buttons.dart';
import '../solid_principles/single_responsibitlity_principle/single_responsibility_screen.dart';
import 'route_paths.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.home:
        return CupertinoPageRoute(
          builder: (ctx) => StatePatternHomeScreen(),
        );
      case RoutePaths.login:
        return CupertinoPageRoute(
            builder: (ctx) => const StatePatternLoginScreen());
      case RoutePaths.modelViewPattern:
        return CupertinoPageRoute(
            builder: (ctx) => ModelViewControllerPatternExample());
      case RoutePaths.factoryPattern:
        return CupertinoPageRoute(
            builder: (ctx) => const FactoryPatternExample());
      case RoutePaths.mvvmPattern:
        return CupertinoPageRoute(
            builder: (ctx) => ModelViewViewModelExample());
      case RoutePaths.blocPattern:
        return CupertinoPageRoute(builder: (ctx) => const BlocPatternExample());
      case RoutePaths.blocPatternFlutter:
        return CupertinoPageRoute(builder: (ctx) => const CounterApp());
      case RoutePaths.decoratorPattern:
        return CupertinoPageRoute(builder: (ctx) => const CoffeeScreen());
      case RoutePaths.pageControlButtons:
        return CupertinoPageRoute(builder: (ctx) => const PageControlButtons());
      case RoutePaths.observerPattern:
        return CupertinoPageRoute(
            builder: (ctx) => const ObserverScreenExample());
      case RoutePaths.compositePattern:
        return CupertinoPageRoute(
            builder: (ctx) => const CompositePatternExample());
      case RoutePaths.builderPattern:
        return CupertinoPageRoute(
            builder: (ctx) => const BuilderPatternExample());
      case RoutePaths.singletonPattern:
        return CupertinoPageRoute(builder: (ctx) => const LoginScreen());
      case RoutePaths.abstractFactoryPattern:
        return CupertinoPageRoute(
            builder: (ctx) => const AbstractFactoryExample());
      case RoutePaths.solidPrinciple:
        return CupertinoPageRoute(
            builder: (ctx) => const SolidPrincipleScreenNavigations());
      case RoutePaths.singleResponsibilityScreen:
        return CupertinoPageRoute(
            builder: (ctx) => SingleResponsibilityScreen());
      case RoutePaths.openCloseScreen:
        return CupertinoPageRoute(builder: (ctx) => OpenClosedScreen());
      case RoutePaths.liskovSubstitutionScreen:
        return CupertinoPageRoute(builder: (ctx) => LiskovSubstitutionScreen());
      case RoutePaths.interfaceSegregationScreen:
        return CupertinoPageRoute(
            builder: (ctx) => InterfaceSegregationScreen());
      case RoutePaths.dependencyInversionScreen:
        return CupertinoPageRoute(
            builder: (ctx) => DependencyInversionScreen());
      default:
        return CupertinoPageRoute(builder: (ctx) => const PageControlButtons());
    }
  }
}
