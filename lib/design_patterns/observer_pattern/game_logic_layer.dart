import 'package:flutter/services.dart';

import 'game_layers.dart';
import 'game_states.dart';
import 'keyboard_listeners.dart';

class GameLogicLayer extends GameLayer {
  final List<KeyboardEventListener> _keyTrackers = [];

  final VoidCallback onGameComplete;
  final VoidCallback onGameReset;

  GameState currentGameState = WaitForStartState();

  GameLogicLayer({
    required super.initialKey,
    required super.amountOfKeys,
    required this.onGameComplete,
    required this.onGameReset,
  });

  int get keysPressed => currentGameState.keysPressed;
  Duration get elapsedTime => currentGameState.elapsedTime;

  @override
  initialize() {
    for (int i = 0; i < amountOfKeys; i++) {
      final key = LogicalKeyboardKey(initialKey.keyId + i);

      _keyTrackers.add(
        KeyboardEventListener(
          key: key,
          onKeyPressed: onNewKeyEvent,
        ),
      );
    }
    super.initialize();
  }

  void onNewKeyEvent(KeyboardEvent event) {
    if (!event.value) return;
    currentGameState = currentGameState.onNewKeyDownEvent(event.key);
    if (currentGameState is GameCompleteState) {
      onGameComplete();
    } else if (currentGameState is WaitForStartState) {
      onGameReset();
    }
  }

  @override
  dispose() {
    for (final listener in _keyTrackers) {
      listener.dispose();
    }
    return super.dispose();
  }
}
