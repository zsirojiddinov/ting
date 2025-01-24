import 'package:flutter/widgets.dart';

import '../../../utils/errors.dart';

@immutable
abstract class HomeState {}

class SuccessState extends HomeState {}

class ProgressState extends HomeState {}

class ErrorState extends HomeState {
  Failure failure;

  ErrorState({
    required this.failure,
  });
}
