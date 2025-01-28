import 'package:flutter/widgets.dart';
import 'package:ting/model/invoice/invoice_model.dart';

@immutable
abstract class InvoiceEvent {}

// ignore: must_be_immutable
class SettingsEvent extends InvoiceEvent {}

class GetInvoiceDataEvent extends InvoiceEvent {}

class OpenInvoiceEvent extends InvoiceEvent {
  InvoiceModel model;

  OpenInvoiceEvent(this.model);
}