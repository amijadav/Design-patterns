import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'game_drawing_layer.dart';
import 'game_logic_layer.dart';
import 'game_states.dart';
import 'keyboard_listeners.dart';

class ObserverScreenExample extends StatefulWidget {
  const ObserverScreenExample({super.key});

  @override
  State<ObserverScreenExample> createState() => _ObserverScreenExampleState();
}

class _ObserverScreenExampleState extends State<ObserverScreenExample> {
  final game = AZTypingGame(
    initialKey: LogicalKeyboardKey.keyA,
    amountOfKeys: 26,
    onGameComplete: () {},
    onGameReset: () {},
  );

  late Timer _updateTimer;
  late Duration _elapsed;
  late int _pressed;

  @override
  void initState() {
    super.initState();
    game.initialize();
    _elapsed = Duration.zero;
    _pressed = 0;

    // Update UI every 100ms
    _updateTimer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      setState(() {
        _elapsed = game.elapsedTime;
        _pressed = game.keysPressed;
      });
    });
  }

  @override
  void dispose() {
    game.dispose();
    _updateTimer.cancel();
    super.dispose();
  }

  String getGameMessage(GameState state) {
    if (state is WaitForStartState) return 'Press A to start!';
    if (state is PlayingState) return 'Type the alphabet in order!';
    if (state is GameCompleteState) return '🎉 Finished! Great job!';
    if (state is GameOverState) return '❌ Oops! Try again.';
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Virtual Keyboard')),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500, maxHeight: 800),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                getGameMessage(game.currentGameState),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Time: ${(_elapsed.inMilliseconds / 1000).toStringAsFixed(2)}s',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Text(
                'Keys Pressed: $_pressed / ${game.amountOfKeys}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 24),
              Wrap(
                children: List.generate(
                  game.amountOfKeys,
                  (count) {
                    LogicalKeyboardKey currentKey =
                        LogicalKeyboardKey(game.initialKey.keyId + count);
                    return StreamBuilder<KeyboardEvent<Color?>>(
                      stream: game.getColorStream(currentKey),
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
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AZTypingGame {
  final GameDrawerLayer drawerLayer;
  final GameLogicLayer logicLayer;

  GameState get currentGameState => logicLayer.currentGameState;
  int get amountOfKeys => logicLayer.amountOfKeys;
  LogicalKeyboardKey get initialKey => logicLayer.initialKey;

  int get keysPressed => logicLayer.keysPressed;
  Duration get elapsedTime => logicLayer.elapsedTime;

  AZTypingGame({
    required LogicalKeyboardKey initialKey,
    required int amountOfKeys,
    required VoidCallback onGameComplete,
    required VoidCallback onGameReset,
  })  : drawerLayer = GameDrawerLayer(
          initialKey: initialKey,
          amountOfKeys: amountOfKeys,
        ),
        logicLayer = GameLogicLayer(
          initialKey: initialKey,
          amountOfKeys: amountOfKeys,
          onGameComplete: onGameComplete,
          onGameReset: onGameReset,
        );

  void initialize() {
    drawerLayer.initialize();
    logicLayer.initialize();
  }

  Stream<KeyboardEvent<Color?>> getColorStream(LogicalKeyboardKey key) =>
      drawerLayer.getColorStream(key);

  void dispose() {
    drawerLayer.dispose();
    logicLayer.dispose();
  }
}
