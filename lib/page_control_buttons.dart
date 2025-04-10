import 'package:flutter/material.dart';

import 'app_routes/route_paths.dart';

class PageControlButtons extends StatelessWidget {
  const PageControlButtons({super.key});

  void modelViewPattern(BuildContext context) {
    Navigator.pushNamed(context, RoutePaths.modelViewPattern);
  }

  void factoryPattern(BuildContext context) {
    Navigator.pushNamed(context, RoutePaths.factoryPattern);
  }

  void mvvmPattern(BuildContext context) {
    Navigator.pushNamed(context, RoutePaths.mvvmPattern);
  }

  void decoratorPattern(BuildContext context) {
    Navigator.pushNamed(context, RoutePaths.decoratorPattern);
  }

  void statePattern(BuildContext context) {
    Navigator.pushNamed(context, RoutePaths.login);
  }

  void compositePattern(BuildContext context) {
    Navigator.pushNamed(context, RoutePaths.compositePattern);
  }

  void blocPattern(BuildContext context) {
    Navigator.pushNamed(context, RoutePaths.blocPattern);
  }

  void blocPatternFlutter(BuildContext context) {
    Navigator.pushNamed(context, RoutePaths.blocPatternFlutter);
  }

  void builderPattern(BuildContext context) {
    Navigator.pushNamed(context, RoutePaths.builderPattern);
  }

  void singletonPattern(BuildContext context) {
    Navigator.pushNamed(context, RoutePaths.singletonPattern);
  }

  void abstractFactoryExample(BuildContext context) {
    Navigator.pushNamed(context, RoutePaths.abstractFactoryPattern);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Main page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
          ],
        ),
      ),
    );
  }
}
