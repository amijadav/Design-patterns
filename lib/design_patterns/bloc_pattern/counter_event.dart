import 'package:design_patterns/design_patterns/bloc_pattern/counter_bloc.dart';

abstract class CounterEvent extends BlocEvent {}

class IncrementEvent extends CounterEvent {}

class DecrementEvent extends CounterEvent {}

class ResetEvent extends CounterEvent {}
