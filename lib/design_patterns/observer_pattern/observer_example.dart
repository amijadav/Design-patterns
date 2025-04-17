import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ObserverScreenExample extends StatefulWidget {
  const ObserverScreenExample({super.key});

  @override
  State<ObserverScreenExample> createState() => _ObserverScreenExampleState();
}

class _ObserverScreenExampleState extends State<ObserverScreenExample> {
  // Map to track which keys are currently pressed
  final Map<LogicalKeyboardKey, bool> _keyStates = {
    LogicalKeyboardKey.keyA: false,
    LogicalKeyboardKey.keyS: false,
    LogicalKeyboardKey.keyD: false,
    LogicalKeyboardKey.keyF: false,
  };

  // Call this on key press/release
  void setKeyState(LogicalKeyboardKey key, bool isDown) {
    if (_keyStates.containsKey(key)) {
      setState(() {
        _keyStates[key] = isDown;
      });
    }
  }

  // Flutter handles raw key events here
  void _onNewKeyEvent(KeyEvent event) {
    final key = event.logicalKey;
    final isDown = event is KeyDownEvent;
    setKeyState(key, isDown);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Virtual Keyboard')),
      body: KeyboardListener(
        focusNode: FocusNode()..requestFocus(),
        autofocus: true,
        onKeyEvent: _onNewKeyEvent,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _keyStates.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  width: 60,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: entry.value ? Colors.greenAccent : Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Text(
                    entry.key.keyLabel.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
