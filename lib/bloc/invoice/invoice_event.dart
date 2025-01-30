import 'package:flutter/widgets.dart';
import 'package:ting/model/invoice/invoice_model.dart';

@immutable
abstract class InvoiceEvent {}

// ignore: must_be_immutable
class SettingsEvent extends InvoiceEvent {}

class GetInvoiceDataEvent extends InvoiceEvent {}

class ChangeFilterEvent extends InvoiceEvent {
  String val;

  ChangeFilterEvent(this.val);
}

class OpenInvoiceEvent extends InvoiceEvent {
  InvoiceModel model;

  OpenInvoiceEvent(this.model);
}

class SelectDateEvent extends InvoiceEvent {
  BuildContext context;
  String val;

  SelectDateEvent(
    this.context,
    this.val,
  );
}

class GoEvent extends InvoiceEvent {}