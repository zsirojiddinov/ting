import 'package:flutter/material.dart';

@immutable
abstract class SplashState {}

class SuccessState extends SplashState {}

// ignore: must_be_immutable
class ProgressState extends SplashState {
  String text;

  ProgressState(this.text);
}
