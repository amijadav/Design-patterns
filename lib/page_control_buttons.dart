import 'package:flutter/material.dart';

import 'app_routes/route_paths.dart';

class PageControlButtons extends StatelessWidget {
  const PageControlButtons({super.key});

  void modelViewPattern(BuildContext context) {
    navigateToScreen(context, path: RoutePaths.modelViewPattern);
  }

  void factoryPattern(BuildContext context) {
    navigateToScreen(context, path: RoutePaths.factoryPattern);
  }

  void mvvmPattern(BuildContext context) {
    navigateToScreen(context, path: RoutePaths.mvvmPattern);
  }

  void decoratorPattern(BuildContext context) {
    navigateToScreen(context, path: RoutePaths.decoratorPattern);
  }

  void statePattern(BuildContext context) {
    navigateToScreen(context, path: RoutePaths.login);
  }

  void compositePattern(BuildContext context) {
    navigateToScreen(context, path: RoutePaths.compositePattern);
  }

  void blocPattern(BuildContext context) {
    navigateToScreen(context, path: RoutePaths.blocPattern);
  }

  void blocPatternFlutter(BuildContext context) {
    navigateToScreen(context, path: RoutePaths.blocPatternFlutter);
  }

  void builderPattern(BuildContext context) {
    navigateToScreen(context, path: RoutePaths.builderPattern);
  }

  void singletonPattern(BuildContext context) {
    navigateToScreen(context, path: RoutePaths.singletonPattern);
  }

  void abstractFactoryExample(BuildContext context) {
    navigateToScreen(context, path: RoutePaths.abstractFactoryPattern);
  }

  void observerExample(BuildContext context) {
    navigateToScreen(context, path: RoutePaths.observerPattern);
  }

  void navigateToScreen(BuildContext context, {required ScreenPath path}) {
    Navigator.pushNamed(context, path.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Main page")),
      body: Center(
        child: Wrap(
          direction: Axis.vertical,
          spacing: 20,
          children: [
            ElevatedButton(
              onPressed: () => modelViewPattern(context),
              child: const Text("MVC pattern Example"),
            ),
            ElevatedButton(
              onPressed: () => mvvmPattern(context),
              child: const Text("MVVM pattern"),
            ),
            ElevatedButton(
              onPressed: () => decoratorPattern(context),
              child: const Text("Decorator pattern Example"),
            ),
            ElevatedButton(
              onPressed: () => statePattern(context),
              child: const Text("State pattern Example"),
            ),
            ElevatedButton(
              onPressed: () => compositePattern(context),
              child: const Text("Composite pattern Example"),
            ),
            ElevatedButton(
              onPressed: () => builderPattern(context),
              child: const Text("Builder pattern"),
            ),
            ElevatedButton(
              onPressed: () => singletonPattern(context),
              child: const Text("Singleton pattern"),
            ),
            ElevatedButton(
              onPressed: () => blocPattern(context),
              child: const Text("BLOC pattern"),
            ),
            ElevatedButton(
              onPressed: () => blocPatternFlutter(context),
              child: const Text("BLOC pattern Flutter"),
            ),
            ElevatedButton(
              onPressed: () => factoryPattern(context),
              child: const Text("Factory Pattern"),
            ),
            ElevatedButton(
              onPressed: () => abstractFactoryExample(context),
              child: const Text("Abstract Factory pattern"),
            ),
            ElevatedButton(
              onPressed: () => observerExample(context),
              child: const Text("Observer pattern"),
            ),
          ],
        ),
      ),
    );
  }
}
