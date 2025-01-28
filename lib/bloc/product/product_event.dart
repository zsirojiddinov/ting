import 'package:flutter/widgets.dart';
import 'package:ting/model/invoice/invoice_model.dart';

@immutable
abstract class ProductEvent {}

class GetProductDataEvent extends ProductEvent {
  InvoiceModel model;

  GetProductDataEvent(this.model);
}
