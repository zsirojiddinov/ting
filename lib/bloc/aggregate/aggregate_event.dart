import 'package:barcode_newland_flutter/newland_scan_result.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class AggregateEvent {}

// ignore: must_be_immutable
class SettingsEvent extends AggregateEvent {}

class InitializationEvent extends AggregateEvent {}
class CheckingUtillAggregateEvent extends AggregateEvent {}

class AddBarcodeEvent extends AggregateEvent {
  NewlandScanResult data;

  AddBarcodeEvent(this.data);
}