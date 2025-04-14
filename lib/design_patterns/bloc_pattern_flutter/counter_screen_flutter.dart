import 'package:design_patterns/design_patterns/bloc_pattern_flutter/counter_bloc_flutter.dart';
import 'package:design_patterns/design_patterns/bloc_pattern_flutter/counter_event_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../general_widgets/circle_btn_widget.dart';

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: const CounterPage(),
    );
  }
}

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _bloc = context.read<CounterBloc>();
    void onAddTap() {
      _bloc.add(IncrementEvent());
    }

    void onRemoveTap() {
      _bloc.add(DecrementEvent());
    }

    void onResetTap() {
      _bloc.add(ResetEvent());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter BLoC Counter'),
        centerTitle: true,
      ),
      body: Center(
        child: BlocBuilder<CounterBloc, int>(
          builder: (context, count) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Count: $count',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleButton(
                      icon: Icons.remove,
                      onPressed: onRemoveTap,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    CircleButton(
                      icon: Icons.refresh,
                      onPressed: count != 0 ? onResetTap : null,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    CircleButton(
                      icon: Icons.add,
                      onPressed: onAddTap,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
