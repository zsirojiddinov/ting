import 'package:flutter/widgets.dart';

@immutable
abstract class ProductEvent {}

class GetProductDataEvent extends ProductEvent {}
