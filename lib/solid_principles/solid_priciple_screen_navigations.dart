import 'package:flutter/material.dart';

import '../app_routes/route_paths.dart';

class SolidPrincipleScreenNavigations extends StatelessWidget {
  const SolidPrincipleScreenNavigations({super.key});

  void singleResponsibilityScreen(BuildContext context) {
    navigateToScreen(context, path: RoutePaths.singleResponsibilityScreen);
  }

  void openCloseScreen(BuildContext context) {
    navigateToScreen(context, path: RoutePaths.openCloseScreen);
  }

  void liskovSubstitutionScreen(BuildContext context) {
    navigateToScreen(context, path: RoutePaths.liskovSubstitutionScreen);
  }

  void interfaceSegregationScreen(BuildContext context) {
    navigateToScreen(context, path: RoutePaths.interfaceSegregationScreen);
  }

  void dependencyInversionScreen(BuildContext context) {
    navigateToScreen(context, path: RoutePaths.dependencyInversionScreen);
  }

  void navigateToScreen(BuildContext context, {required ScreenPath path}) {
    Navigator.pushNamed(context, path.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Solid principle page")),
      body: Center(
        child: Wrap(
          direction: Axis.vertical,
          spacing: 20,
          children: [
            ElevatedButton(
              onPressed: () => singleResponsibilityScreen(context),
              child: const Text("Single Responsibility Example"),
            ),
            ElevatedButton(
              onPressed: () => openCloseScreen(context),
              child: const Text("Open Close Example"),
            ),
            ElevatedButton(
              onPressed: () => liskovSubstitutionScreen(context),
              child: const Text("Liskov Substitution Example"),
            ),
            ElevatedButton(
              onPressed: () => interfaceSegregationScreen(context),
              child: const Text("Interface Segregation  Example"),
            ),
            ElevatedButton(
              onPressed: () => dependencyInversionScreen(context),
              child: const Text("Dependency Inversion Example"),
            ),
          ],
        ),
      ),
    );
  }
}
