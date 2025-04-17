import 'package:flutter/material.dart';
import '../factory/status_button_factory.dart';
import '../managers/status_selection_manager.dart';

class AbstractFactoryExample extends StatefulWidget {
  const AbstractFactoryExample({super.key});

  @override
  State<AbstractFactoryExample> createState() => _AbstractFactoryExampleState();
}

class _AbstractFactoryExampleState extends State<AbstractFactoryExample> {
  String get _status => StatusSelectionManager().selectedStatus;

  void updateStatus(String status) {
    StatusSelectionManager().selectedStatus = status;
    setState(() {});
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Status changed to $status")));
  }

  @override
  Widget build(BuildContext context) {
    final factory = StatusButtonFactory.getAbstractFactory();
    final availableBtn = factory.createAvailableButton();
    final busyBtn = factory.createBusyButton();
    final offlineBtn = factory.createOfflineButton();

    return Scaffold(
      appBar: AppBar(title: const Text("Abstract Factory Pattern")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Current Status: $_status",
              style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 30),
          Wrap(
            spacing: 10,
            children: [
              availableBtn.build(context, updateStatus),
              busyBtn.build(context, updateStatus),
              offlineBtn.build(context, updateStatus),
            ],
          ),
        ],
      ),
    );
  }
}
