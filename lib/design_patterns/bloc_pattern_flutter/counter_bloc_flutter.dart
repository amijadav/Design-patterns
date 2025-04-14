import 'package:design_patterns/design_patterns/bloc_pattern_flutter/counter_event_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<IncrementEvent>((event, emit) => _increment(emit));
    on<DecrementEvent>((event, emit) => _decrement(emit));
    on<ResetEvent>((event, emit) => _reset(emit));
  }

  void _increment(Emitter<int> emit) {
    if (state >= 10) return emit(state + 2);
    emit(state + 1);
  }

  void _decrement(Emitter<int> emit) {
    if (state > 10) return emit(state - 2);
    if (state > 0) return emit(state - 1);
    emit(0);
  }

  void _reset(Emitter<int> emit) => emit(0);
}
