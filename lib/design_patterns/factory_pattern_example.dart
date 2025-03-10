import 'package:flutter/material.dart';

//  Factory Constructor Example
class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();

  factory DatabaseService() => _instance;

  DatabaseService._internal();
}

//  Factory Method Example
abstract class Button {
  Widget render();
}

class AndroidButton implements Button {
  @override
  Widget render() {
    return ElevatedButton(
      onPressed: () {},
      child: const Text("Android Button"),
    );
  }
}

class IOSButton implements Button {
  @override
  Widget render() {
    return TextButton(
      onPressed: () {},
      child: const Text("iOS Button"),
    );
  }
}

class ButtonFactory {
  static Button createButton(String platform) {
    return platform == 'android' ? AndroidButton() : IOSButton();
  }
}

class FactoryPatternExample extends StatelessWidget {
  const FactoryPatternExample({super.key});

  @override
  Widget build(BuildContext context) {
    var db1 = DatabaseService();
    var db2 = DatabaseService();
    debugPrint('${db1 == db2}    checkFactoryConstructor');

    Button button = ButtonFactory.createButton('android');

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Factory Pattern in Flutter')),
        body: Center(child: button.render()),
      ),
    );
  }
}
