import 'package:flutter/widgets.dart';

import '../../../utils/errors.dart';

@immutable
abstract class SearchState {}

class SuccessState extends SearchState {}

class ProgressState extends SearchState {}

class ErrorState extends SearchState {
  Failure failure;

  ErrorState({
    required this.failure,
  });
}
class RunningState extends SearchState {
  final int duration;

  RunningState(this.duration);
}
