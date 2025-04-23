import 'package:flutter/services.dart';

class InvalidGameStateException implements Exception {}

abstract class GameState {
  final LogicalKeyboardKey initialKey = LogicalKeyboardKey.keyA;
  final int amountOfKeys = 26;

  int get keysPressed => 0;
  Duration get elapsedTime => Duration.zero;

  GameState onNewKeyDownEvent(LogicalKeyboardKey keyPressed);

  GameState startGameAction();
  GameState resetGameAction();
  GameState completeGameAction();
  GameState setGameOverAction();
}

class WaitForStartState extends GameState {
  @override
  GameState onNewKeyDownEvent(LogicalKeyboardKey keyPressed) {
    if (keyPressed == initialKey) {
      return startGameAction();
    }
    return this;
  }

  @override
  GameState completeGameAction() {
    throw InvalidGameStateException();
  }

  @override
  GameState resetGameAction() {
    return this;
  }

  @override
  GameState setGameOverAction() {
    throw InvalidGameStateException();
  }

  @override
  GameState startGameAction() {
    return PlayingState();
  }
}

class PlayingState extends GameState {
  late int _nextKeyId;
  late int _currentIndex;
  final Stopwatch _stopwatch = Stopwatch();

  PlayingState() {
    _currentIndex = 1;
    _nextKeyId = initialKey.keyId + _currentIndex;
    _stopwatch.start();
  }

  @override
  int get keysPressed => _currentIndex;

  @override
  Duration get elapsedTime => _stopwatch.elapsed;

  @override
  GameState onNewKeyDownEvent(LogicalKeyboardKey keyPressed) {
    if (keyPressed.keyId != _nextKeyId) {
      return setGameOverAction();
    }

    _recordPoint();

    if (_currentIndex >= amountOfKeys) {
      return completeGameAction();
    }

    return this;
  }

  void _recordPoint() {
    _currentIndex++;
    _nextKeyId++;
  }

  @override
  GameState completeGameAction() {
    _stopwatch.stop();
    return GameCompleteState(
      elapsedTime: elapsedTime,
      keysPressed: keysPressed,
    );
  }

  @override
  GameState resetGameAction() {
    _stopwatch.stop();
    return WaitForStartState();
  }

  @override
  GameState setGameOverAction() {
    _stopwatch.stop();
    return GameOverState(
      elapsedTime: elapsedTime,
      keysPressed: keysPressed,
    );
  }

  @override
  GameState startGameAction() {
    throw InvalidGameStateException();
  }
}

class GameCompleteState extends GameState {
  @override
  final Duration elapsedTime;

  @override
  final int keysPressed;

  GameCompleteState({
    required this.keysPressed,
    required this.elapsedTime,
  });

  @override
  GameState onNewKeyDownEvent(LogicalKeyboardKey keyPressed) {
    if (keyPressed == initialKey) {
      return resetGameAction();
    }
    return this;
  }

  @override
  GameState completeGameAction() {
    return this;
  }

  @override
  GameState resetGameAction() {
    return WaitForStartState();
  }

  @override
  GameState setGameOverAction() {
    return this;
  }

  @override
  GameState startGameAction() {
    throw InvalidGameStateException();
  }
}

class GameOverState extends GameState {
  @override
  final Duration elapsedTime;

  @override
  final int keysPressed;

  GameOverState({
    required this.keysPressed,
    required this.elapsedTime,
  });

  @override
  GameState onNewKeyDownEvent(LogicalKeyboardKey keyPressed) {
    if (keyPressed == initialKey) {
      return resetGameAction();
    }
    return this;
  }

  @override
  GameState completeGameAction() {
    return this;
  }

  @override
  GameState resetGameAction() {
    return WaitForStartState();
  }

  @override
  GameState setGameOverAction() {
    return this;
  }

  @override
  GameState startGameAction() {
    throw InvalidGameStateException();
  }
}
