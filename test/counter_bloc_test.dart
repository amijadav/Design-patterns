import 'dart:async';

import 'package:design_patterns/design_patterns/bloc_pattern/counter_bloc.dart';
import 'package:design_patterns/design_patterns/bloc_pattern/counter_event.dart';
import 'package:flutter_test/flutter_test.dart';

class DefaultClass extends CounterEvent {}

void main() {
  group('Counter Application Tests', () {
    late NewCounterBloc bloc;

    setUp(() {
      bloc = NewCounterBloc();
    });

    tearDown(() {
      bloc.dispose();
    });

    group('Stream Tests', () {
      test('counterStream emits initial state', () async {
        final stateValue = await bloc.counterStream.first;

        expect(stateValue, isA<ZeroState>());
        expect(bloc.currentState.state, equals(0));
      });
      test('increment then decrement emits correct states', () async {
        final emittedStates = <CounterState>[];
        bloc.counterStream.listen(emittedStates.add);

        bloc.fireEvent(IncrementEvent());
        await Future.delayed(Duration.zero);
        expect(emittedStates.last, isA<HasValueState>());
        expect(bloc.currentState.state, equals(1));

        bloc.fireEvent(IncrementEvent());
        await Future.delayed(Duration.zero);
        expect(emittedStates.last, isA<HasValueState>());
        expect(bloc.currentState.state, equals(2));

        bloc.fireEvent(IncrementEvent());
        await Future.delayed(Duration.zero);
        expect(emittedStates.last, isA<HasValueState>());
        expect(bloc.currentState.state, equals(3));

        bloc.fireEvent(DecrementEvent());
        await Future.delayed(Duration.zero);
        expect(emittedStates.last, isA<HasValueState>());
        expect(bloc.currentState.state, equals(2));

        bloc.fireEvent(DecrementEvent());
        await Future.delayed(Duration.zero);
        expect(emittedStates.last, isA<HasValueState>());
        expect(bloc.currentState.state, equals(1));

        bloc.fireEvent(ResetEvent());
        await Future.delayed(Duration.zero);
        expect(emittedStates.last, isA<ZeroState>());
        expect(bloc.currentState.state, equals(0));

        expect(emittedStates.length, equals(7));
      });
    });
    group('Event Check', () {
      test('Event is reset', () async {
        expect(() => bloc.inputEvents(ResetEvent()), returnsNormally);
      });

      test('Event is increment', () async {
        expect(() => bloc.inputEvents(IncrementEvent()), returnsNormally);
      });

      test('Event is decrement', () async {
        expect(() => bloc.inputEvents(DecrementEvent()), returnsNormally);
      });

      test('Event is unimplemented', () async {
        expect(() => bloc.inputEvents(DefaultClass()),
            throwsA(isA<UnimplementedError>()));
      });
    });

    group('Starting from zero', () {
      test('The counter should display 0 when the application is launched', () {
        expect(bloc.currentState, isA<ZeroState>());
        expect(bloc.currentState.state, equals(0));
      });

      test('After pressing "+" once, the number becomes 1', () async {
        bloc.fireEvent(IncrementEvent());
        await Future.delayed(Duration.zero);

        expect(bloc.currentState, isA<HasValueState>());
        expect(bloc.currentState.state, equals(1));
      });

      test('Pressing "-" while at 0 keeps the number at 0', () async {
        bloc.fireEvent(DecrementEvent());
        await Future.delayed(Duration.zero);

        expect(bloc.currentState, isA<ZeroState>());
        expect(bloc.currentState.state, equals(0));
      });

      test('Pressing "Reset" while at 0 keeps it at 0', () async {
        bloc.fireEvent(ResetEvent());
        await Future.delayed(Duration.zero);

        expect(bloc.currentState, isA<ZeroState>());
        expect(bloc.currentState.state, equals(0));
      });
    });

    group('Working with regular numbers', () {
      setUp(() async {
        bloc.currentState = HasValueState(1);
      });

      test('Counting up increases the number by one', () async {
        bloc.fireEvent(IncrementEvent());
        await Future.delayed(Duration.zero);

        expect(bloc.currentState, isA<HasValueState>());
        expect(bloc.currentState.state, equals(2));
      });

      test('Counting down decreases the number by one', () async {
        bloc.fireEvent(DecrementEvent());
        await Future.delayed(Duration.zero);

        expect(bloc.currentState, isA<ZeroState>());
        expect(bloc.currentState.state, equals(0));
      });

      test('Resetting returns the counter to zero', () async {
        bloc.fireEvent(ResetEvent());
        await Future.delayed(Duration.zero);

        expect(bloc.currentState, isA<ZeroState>());
        expect(bloc.currentState.state, equals(0));
      });

      test('Counting down to zero shows zero', () async {
        bloc.currentState = HasValueState(9);

        bloc.fireEvent(DecrementEvent());
        await Future.delayed(Duration.zero);
        expect(bloc.currentState.state, equals(8));

        bloc.fireEvent(IncrementEvent());
        bloc.fireEvent(IncrementEvent());
        await Future.delayed(Duration.zero);

        expect(
          bloc.currentState,
          isA<OverTen>(),
          reason:
              "When the counter reaches 10 the state must change to OverTen",
        );
        expect(bloc.currentState.state, equals(10));
      });
    });
    group('Counting beyond ten', () {
      setUp(() async {
        bloc.currentState = OverTen(10);
      });

      test('Counting up increases the number by two', () async {
        bloc.fireEvent(IncrementEvent());
        await Future.delayed(Duration.zero);

        expect(bloc.currentState, isA<OverTen>());
        expect(bloc.currentState.state, equals(12));
      });

      test('Counting down below ten shows 9', () async {
        bloc.currentState = OverTen(10);

        bloc.fireEvent(DecrementEvent());
        await Future.delayed(Duration.zero);

        expect(bloc.currentState, isA<HasValueState>());
        expect(bloc.currentState.state, equals(9));
      });

      test('Counting down below 12 shows 10', () async {
        bloc.currentState = OverTen(12);

        bloc.fireEvent(DecrementEvent());
        await Future.delayed(Duration.zero);

        expect(bloc.currentState, isA<OverTen>());
        expect(bloc.currentState.state, equals(10));
      });

      test('Resetting returns the counter to zero', () async {
        bloc.fireEvent(ResetEvent());
        await Future.delayed(Duration.zero);

        expect(bloc.currentState, isA<ZeroState>());
        expect(bloc.currentState.state, equals(0));
      });
    });

    group('Multiple button presses', () {
      test('Pressing count up multiple times adds up correctly', () async {
        bloc.fireEvent(IncrementEvent());
        bloc.fireEvent(IncrementEvent());
        bloc.fireEvent(IncrementEvent());
        await Future.delayed(Duration.zero);

        expect(bloc.currentState, isA<HasValueState>());
        expect(bloc.currentState.state, equals(3));
      });

      test('Quickly crossing the count ten jumps to over ten mode', () async {
        bloc.currentState = HasValueState(9);

        bloc.fireEvent(IncrementEvent());
        await Future.delayed(Duration.zero);

        expect(bloc.currentState, isA<OverTen>());
        expect(bloc.currentState.state, equals(10));

        bloc.fireEvent(IncrementEvent());
        await Future.delayed(Duration.zero);

        expect(bloc.currentState, isA<OverTen>());
        expect(bloc.currentState.state, equals(12));
      });

      test('Quickly dropping below ten returns to regular mode', () async {
        bloc.currentState = OverTen(14);

        bloc.fireEvent(DecrementEvent());
        await Future.delayed(Duration.zero);
        expect(bloc.currentState.state, equals(12));

        bloc.fireEvent(DecrementEvent());
        await Future.delayed(Duration.zero);
        expect(bloc.currentState.state, equals(10));

        bloc.fireEvent(DecrementEvent());
        await Future.delayed(Duration.zero);

        expect(bloc.currentState, isA<HasValueState>());
        expect(bloc.currentState.state, equals(9));
      });
    });
  });
}
