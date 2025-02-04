import 'package:barcode_newland_flutter/newland_scan_result.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class SearchEvent {}

// ignore: must_be_immutable
class SettingsEvent extends SearchEvent {}

class InitializationEvent extends SearchEvent {}
class CheckingUtillAggregateEvent extends SearchEvent {}
class SendUtilizationEvent extends SearchEvent {}

class AddBarcodeEvent extends SearchEvent {
  NewlandScanResult data;

  AddBarcodeEvent(this.data);
}

class TickEvent extends SearchEvent {}