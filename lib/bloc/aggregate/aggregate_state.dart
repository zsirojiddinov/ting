import 'package:flutter/widgets.dart';

import '../../../utils/errors.dart';

@immutable
abstract class AggregateState {}

class SuccessState extends AggregateState {}

class ProgressState extends AggregateState {}

class ErrorState extends AggregateState {
  Failure failure;

  ErrorState({
    required this.failure,
  });
}
class RunningState extends AggregateState {
  final int duration;

  RunningState(this.duration);
}
