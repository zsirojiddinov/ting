import 'package:flutter/widgets.dart';

import '../../../utils/errors.dart';

@immutable
abstract class LoginState {}

class SuccessState extends LoginState {}

class ProgressState extends LoginState {}

class SendServerState extends LoginState {}

class ErrorState extends LoginState {
  Failure failure;

  ErrorState({
    required this.failure,
  });
}
