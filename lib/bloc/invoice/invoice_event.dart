import 'package:flutter/widgets.dart';

@immutable
abstract class InvoiceEvent {}

// ignore: must_be_immutable
class SettingsEvent extends InvoiceEvent {}