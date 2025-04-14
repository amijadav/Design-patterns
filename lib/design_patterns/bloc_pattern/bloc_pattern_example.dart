import 'package:design_patterns/design_patterns/bloc_pattern/counter_event.dart';
import 'package:flutter/material.dart';

import '../../general_widgets/circle_btn_widget.dart';
import 'counter_bloc.dart';

class BlocPatternExample extends StatefulWidget {
  const BlocPatternExample({super.key});

  @override
  _BlocPatternExampleState createState() => _BlocPatternExampleState();
}

class _BlocPatternExampleState extends State<BlocPatternExample> {
  final NewCounterBloc _bloc = NewCounterBloc();

  void onAddTap() => _bloc.fireEvent(IncrementEvent());

  void onRemoveTap() => _bloc.fireEvent(DecrementEvent());

  void onResetTap() => _bloc.fireEvent(ResetEvent());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BLoC Pattern Example'),
      ),
      body: Flexible(
        child: StreamBuilder<CounterState>(
          stream: _bloc.counterStream,
          initialData: ZeroState(),
          builder: (context, snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Counter: ${snapshot.data?.state}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  'State: ${snapshot.data}',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleButton(
                      onPressed: onAddTap,
                      icon: Icons.add,
                    ),
                    const SizedBox(width: 10),
                    CircleButton(
                      onPressed: snapshot.data is ZeroState ? null : onResetTap,
                      icon: Icons.refresh,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 10),
                    CircleButton(
                      onPressed: onRemoveTap,
                      icon: Icons.remove,
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
