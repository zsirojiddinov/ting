import 'package:flutter/widgets.dart';

@immutable
abstract class AggregateEvent {}

// ignore: must_be_immutable
class SettingsEvent extends AggregateEvent {}