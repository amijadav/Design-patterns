import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class RouterManger {
  Future<void> goToHomeScreen(WidgetRef ref);
}
