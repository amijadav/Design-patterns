import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class LoadingManager {
  Future<R> showLoading<R>(WidgetRef ref, Future<R> Function() process);
  void errorLoading(WidgetRef ref, dynamic error);
}
