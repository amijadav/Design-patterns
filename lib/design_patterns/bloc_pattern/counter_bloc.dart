import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';

import 'counter_event.dart';

abstract class StatePattern<S> {
  final S state;

  StatePattern(this.state);
}

abstract class BlocEvent {}

abstract class Bloc<Input extends BlocEvent, Output extends StatePattern> {
  Output currentState;

  Bloc({required Output initialState}) : currentState = initialState {
    _inputController.stream.listen(inputEvents);
    notifyListeners();
  }

  void fireEvent(Input event) {
    _inputController.add(event);
  }

  void inputEvents(Input event);

  @mustCallSuper
  void outputEvents(Output newValue) {
    currentState = newValue;
    notifyListeners();
  }

  void notifyListeners() {
    outputController.sink.add(currentState);
  }

  final outputController = StreamController<Output>();
  final _inputController = StreamController<Input>();

  Stream<Output> get counterStream => outputController.stream;
  Sink<Input> get counterEventSink => _inputController.sink;

  @mustCallSuper
  void dispose() {
    outputController.close();
    _inputController.close();
  }
}

class NewCounterBloc extends Bloc<CounterEvent, CounterState> {
  NewCounterBloc() : super(initialState: ZeroState());

  @override
  void inputEvents(CounterEvent event) {
    outputEvents(switch (event) {
      IncrementEvent() => currentState.incrementAction(),
      DecrementEvent() => currentState.decrementAction(),
      ResetEvent() => currentState.resetAction(),
      _ => throw UnimplementedError(),
    });
  }
}

abstract class CounterState extends StatePattern<int> {
  CounterState(super.state);

  CounterState incrementAction();
  CounterState decrementAction();
  CounterState resetAction();
}

class ZeroState extends CounterState {
  ZeroState() : super(0);

  @override
  CounterState decrementAction() {
    return this;
  }

  @override
  CounterState incrementAction() {
    return HasValueState(1);
  }

  @override
  CounterState resetAction() {
    return this;
  }
}

class HasValueState extends CounterState {
  HasValueState(super.state)
      : assert(state < 10 && state > 0,
            "Has value must contains values between 1 and 9");

  @override
  CounterState decrementAction() {
    return state > 1 ? HasValueState(state - 1) : ZeroState();
  }

  @override
  CounterState incrementAction() {
    final newState = state + 1;
    return newState >= 10 ? OverTen(newState) : HasValueState(newState);
  }

  @override
  CounterState resetAction() {
    return ZeroState();
  }
}

class OverTen extends CounterState {
  OverTen(super.state)
      : assert(state >= 10,
            "Over ten must contains values greater or equal to 10");

  @override
  CounterState decrementAction() {
    if (state == 10) return HasValueState(9);
    final newState = state - 2;
    return newState >= 10 ? OverTen(newState) : HasValueState(9);
  }

  @override
  CounterState incrementAction() {
    return OverTen(state + 2);
  }

  @override
  CounterState resetAction() {
    return ZeroState();
  }
}
