import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class GameLayer {
  final LogicalKeyboardKey initialKey;
  final int amountOfKeys;

  GameLayer({
    required this.initialKey,
    required this.amountOfKeys,
  });

  @mustCallSuper
  initialize() {}

  @mustCallSuper
  dispose() {}
}
