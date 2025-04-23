import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef KeyboardEvent<T> = ({LogicalKeyboardKey key, T value});

class KeyboardController {
  late final StreamSubscription subscription;
  final LogicalKeyboardKey key;
  final Color color;

  KeyboardController({required this.key, required this.color}) {
    subscription = Observer().subscribeToKeyEvents(key, _onNewKeyboardEvent);
  }

  void _onNewKeyboardEvent(KeyboardEvent<bool> event) {
    final isDown = event.value;
    Observer().addNewColorEvent((key: key, value: isDown ? color : null));
  }
}

class Observer {
  static Observer? _instance;

  factory Observer() => _instance ??= Observer._internal();
  Observer._internal();

  final Map<LogicalKeyboardKey, StreamController<KeyboardEvent<bool>>>
      keyListeners = {};

  final Map<LogicalKeyboardKey, StreamController<KeyboardEvent<Color?>>>
      colorListeners = {};

  StreamSubscription subscribeToKeyEvents(
      LogicalKeyboardKey key, Function(KeyboardEvent<bool>) listener) {
    return keyListeners
        .putIfAbsent(key, () => StreamController.broadcast())
        .stream
        .listen(listener);
  }

  getColorStream(LogicalKeyboardKey key) {
    return colorListeners
        .putIfAbsent(key, () => StreamController.broadcast())
        .stream;
  }

  void addNewKeyEvent(KeyEvent event) {
    final key = event.logicalKey;
    final listeners = keyListeners[key];
    if (listeners == null) return;

    final isDown = event is KeyDownEvent;
    listeners.add((key: key, value: isDown));
  }

  void addNewColorEvent(KeyboardEvent<Color?> event) {
    final coloredKey = event.key;
    final addNewColorListeners = colorListeners[coloredKey];
    if (addNewColorListeners == null) return;
    addNewColorListeners.add(event);
  }
}
//Colors.primaries[Random().nextInt(Colors.primaries.length)]

class ObserverScreenExample extends StatefulWidget {
  const ObserverScreenExample({super.key});

  @override
  State<ObserverScreenExample> createState() => _ObserverScreenExampleState();
}

class _ObserverScreenExampleState extends State<ObserverScreenExample> {
  // Flutter handles raw key events here
  void _onNewKeyEvent(KeyEvent event) => Observer().addNewKeyEvent(event);

  final List<KeyboardController> listeners = [];
  final Map<LogicalKeyboardKey, Color?> keyStates = {};
  final Random _random = Random();

  Color _getRandomColor() {
    return Color.fromARGB(
      255,
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
    );
  }

  void setupKeyboardControllers() {
    for (int count = 0; count < 26; count++) {
      final key = LogicalKeyboardKey(LogicalKeyboardKey.keyA.keyId + count);
      final color = _getRandomColor();
      keyStates[key] = color;
      listeners.add(KeyboardController(key: key, color: color));
    }
  }

  @override
  void initState() {
    super.initState();
    setupKeyboardControllers();
  }

  @override
  void dispose() {
    listeners.clear();
    super.dispose();
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
          child: Wrap(
            children: List.generate(27, (count) {
              LogicalKeyboardKey currentKey =
                  LogicalKeyboardKey(LogicalKeyboardKey.keyA.keyId + count);
              return StreamBuilder<KeyboardEvent<Color?>>(
                  stream: Observer().getColorStream(currentKey),
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
