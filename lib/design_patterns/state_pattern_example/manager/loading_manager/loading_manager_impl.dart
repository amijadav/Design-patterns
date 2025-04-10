
import 'package:design_patterns/design_patterns/state_pattern_example/manager/loading_manager/loading_manager.dart';
import 'package:flutter/material.dart';

class LoadingManagerImpl implements LoadingManager {
  @override
  Future<R> showLoading<R>(BuildContext context, Future<R> Function() process) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final result = await process();
      if (context.mounted) Navigator.pop(context);
      return result;
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        errorLoading(context, e);
      }
      rethrow;
    }
  }

  @override
  void errorLoading(BuildContext context, dynamic error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(error.toString()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
