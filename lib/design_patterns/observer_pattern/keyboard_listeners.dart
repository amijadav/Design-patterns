import 'package:flutter/services.dart';

typedef KeyboardEvent<T> = ({LogicalKeyboardKey key, T value});

class KeyboardEventListener {
  final LogicalKeyboardKey key;
  final void Function(KeyboardEvent<bool>) onKeyPressed;

  KeyboardEventListener({required this.key, required this.onKeyPressed}) {
    HardwareKeyboard.instance.addHandler(onNewKeyEvent);
  }

  bool onNewKeyEvent(KeyEvent event) {
    if (key == event.logicalKey) {
      onKeyPressed((key: event.logicalKey, value: event is KeyDownEvent));
    }
    return true;
  }

  void dispose() {
    HardwareKeyboard.instance.removeHandler(onNewKeyEvent);
  }
}
