import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LocalizedMessage {
  String getLocalizedMessage(BuildContext context);
}

abstract class Failure extends Equatable implements LocalizedMessage {
  Failure();

  @override
  List<Object> get props => [];
}

class InputLoginFailure extends Failure {
  InputLoginFailure() : super();

  @override
  String getLocalizedMessage(BuildContext context) =>
      "input_phone_errors";
}

class InputPasswordFailure extends Failure {
  InputPasswordFailure() : super();

  @override
  String getLocalizedMessage(BuildContext context) =>
      "input_password_errors";
}

class NotGroupCodeFailure extends Failure {
  NotGroupCodeFailure() : super();

  @override
  String getLocalizedMessage(BuildContext context) =>
      "Siz urgan qrcode group emas, iltimos qaytadan urinib ko'ring";
}

class NotUnitCodeFailure extends Failure {
  NotUnitCodeFailure() : super();

  @override
  String getLocalizedMessage(BuildContext context) =>
      "Siz urgan qrcode unit emas, iltimos qaytadan urinib ko'ring";
}

// ignore: must_be_immutable
class ServerFailure extends Failure {
  String? message;

  ServerFailure({this.message = ""}) : super();

  @override
  String getLocalizedMessage(BuildContext context) => message!;
}
