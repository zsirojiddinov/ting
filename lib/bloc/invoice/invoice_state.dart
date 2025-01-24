import 'package:flutter/widgets.dart';

import '../../../utils/errors.dart';

@immutable
abstract class InvoiceState {}

class SuccessState extends InvoiceState {}

class ProgressState extends InvoiceState {}

class ErrorState extends InvoiceState {
  Failure failure;

  ErrorState({
    required this.failure,
  });
}
