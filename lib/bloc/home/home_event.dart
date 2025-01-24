import 'package:flutter/widgets.dart';

@immutable
abstract class HomeEvent {}

// ignore: must_be_immutable
class SettingsEvent extends HomeEvent {}

class InvoiceHomeEvent extends HomeEvent {}

class AggregateHomeEvent extends HomeEvent {}