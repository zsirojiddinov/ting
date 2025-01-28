import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(SuccessState()) {
    on<GetProductDataEvent>(getData);
  }

  FutureOr<void> getData(
      GetProductDataEvent event, Emitter<ProductState> emit) async {}
}
