import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef KeyboardEvent<T> = ({LogicalKeyboardKey key, T value});

final instance = KeyboardController();

class KeyboardController {
  late final StreamSubscription subscription;

  // Map to track which keys are currently pressed
  final Map<LogicalKeyboardKey, Color?> keyStates = {
    for (int count = 0; count < 26; count++)
      LogicalKeyboardKey(LogicalKeyboardKey.keyA.keyId + count): null
  };

  KeyboardController() {
    subscription = Observer.subscribeToKeyEvents(setKeyState);
  }

  void _onNewColorEvent(LogicalKeyboardKey key, bool isDown, Color? color) {
    Observer.addNewColorEvent((key: key, value: isDown ? color : null));
  }

  // Call this on key press/release
  void setKeyState(KeyEvent event) {
    final key = event.logicalKey;
    final isDown = event is KeyDownEvent;
    if (keyStates.containsKey(key)) {
      if (key == LogicalKeyboardKey.keyA) {
        _onNewColorEvent(key, isDown, Colors.greenAccent);
        return;
      }
      if (key == LogicalKeyboardKey.keyS) {
        _onNewColorEvent(key, isDown, Colors.blue);
        return;
      }
      if (key == LogicalKeyboardKey.keyD) {
        _onNewColorEvent(key, isDown, Colors.amber);
        return;
      }
      if (key == LogicalKeyboardKey.keyF) {
        _onNewColorEvent(key, isDown, Colors.brown);
        return;
      }
      if (key == LogicalKeyboardKey.keyU) {
        _onNewColorEvent(key, isDown, Colors.deepOrange);
        return;
      }
      if (key == LogicalKeyboardKey.keyT) {
        _onNewColorEvent(key, isDown, Colors.pink);
        return;
      }
      if (key == LogicalKeyboardKey.keyN) {
        _onNewColorEvent(key, isDown, Colors.blueGrey);
        return;
      }
    }
  }
}

class Observer {
  static final keyStream = StreamController<KeyEvent>.broadcast();

  static StreamSubscription subscribeToKeyEvents(Function(KeyEvent) listener) {
    return keyStream.stream.listen(listener);
  }

  static StreamSubscription subscribeToColorEvents(
      Function(KeyboardEvent<Color?>) listener) {
    return colorStream.stream.listen(listener);
  }

  static void addNewKeyEvent(KeyEvent event) {
    keyStream.add(event);
  }

  static final colorStream =
      StreamController<KeyboardEvent<Color?>>.broadcast();

  static void addNewColorEvent(KeyboardEvent<Color?> event) {
    colorStream.add(event);
  }
}

class ObserverScreenExample extends StatefulWidget {
  const ObserverScreenExample({super.key});

  @override
  State<ObserverScreenExample> createState() => _ObserverScreenExampleState();
}

class _ObserverScreenExampleState extends State<ObserverScreenExample> {
  // Flutter handles raw key events here
  void _onNewKeyEvent(KeyEvent event) => Observer.addNewKeyEvent(event);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Virtual Keyboard')),
      body: KeyboardListener(
        focusNode: FocusNode()..requestFocus(),
        autofocus: true,
        onKeyEvent: _onNewKeyEvent,
        child: Center(
          child: Wrap(
            children: List.generate(27, (count) {
              LogicalKeyboardKey currentKey =
                  LogicalKeyboardKey(LogicalKeyboardKey.keyA.keyId + count);
              return StreamBuilder<KeyboardEvent<Color?>>(
                  stream: Observer.colorStream.stream,
                  builder: (context, snapshot) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        width: 60,
                        height: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: snapshot.data?.value ?? Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Text(
                          currentKey.keyLabel.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  });
            }),
          ),
        ),
      ),
    );
  }
}
