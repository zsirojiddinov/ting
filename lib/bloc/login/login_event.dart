import 'package:flutter/widgets.dart';

@immutable
abstract class LoginEvent {}

// ignore: must_be_immutable
class SigninEvent extends LoginEvent {}

class ChangePasswordShowEvent extends LoginEvent {}
