
import 'package:design_patterns/state_pattern_example/manager/loading_manager/loading_manager_impl.dart';
import 'package:flutter/material.dart';


abstract class LoadingManager {
  static final LoadingManager _loadingInstance = LoadingManagerImpl();
  factory LoadingManager() => _loadingInstance;

  Future<R> showLoading<R>(BuildContext context, Future<R> Function() process);
  void errorLoading(BuildContext context, dynamic error);
}

