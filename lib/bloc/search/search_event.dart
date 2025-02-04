import 'package:barcode_newland_flutter/newland_scan_result.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class SearchEvent {}

// ignore: must_be_immutable
class AddBarcodeEvent extends SearchEvent {
  NewlandScanResult data;

  AddBarcodeEvent(this.data);
}

class ClearDataEvent extends SearchEvent {}