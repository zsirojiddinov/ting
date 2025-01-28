import 'package:flutter/widgets.dart';

import '../../../utils/errors.dart';

@immutable
abstract class ProductState {}

class SuccessState extends ProductState {}

class ProgressState extends ProductState {}

class ErrorState extends ProductState {
  Failure failure;

  ErrorState({
    required this.failure,
  });
}
