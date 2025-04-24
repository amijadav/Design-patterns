import 'dart:async';
import 'dart:math';

import 'package:flutter/services.dart';

import 'game_layers.dart';
import 'keyboard_listeners.dart';

class GameDrawerLayer extends GameLayer {
  final List<KeyboardEventListener> _keyDrawers = [];

  final Map<LogicalKeyboardKey, StreamController<KeyboardEvent<Color?>>>
      _colorEventListeners = {};

  GameDrawerLayer({
    required super.initialKey,
    required super.amountOfKeys,
  });

  Stream<KeyboardEvent<Color?>> getColorStream(LogicalKeyboardKey key) {
    return _colorEventListeners
        .putIfAbsent(key, () => StreamController.broadcast())
        .stream;
  }

  Color _getRandomColor() {
    final random = Random();
    return Color.fromARGB(
      255, // Full opacity
      100 + random.nextInt(156),
      100 + random.nextInt(156),
      100 + random.nextInt(156),
    );
  }

  @override
  initialize() {
    for (int i = 0; i < amountOfKeys; i++) {
      final key = LogicalKeyboardKey(initialKey.keyId + i);
      final randomColor = _getRandomColor();

      _keyDrawers.add(
        KeyboardEventListener(
            key: key,
            onKeyPressed: (event) {
              final listeners = _colorEventListeners[key];
              if (listeners == null) return;
              listeners.add((
                key: event.key,
                value: event.value ? randomColor : null,
              ));
            }),
      );
    }
    return super.initialize();
  }

  @override
  dispose() {
    for (final listener in _keyDrawers) {
      listener.dispose();
    }
    return super.dispose();
  }
}
