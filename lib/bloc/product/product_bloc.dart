import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ting/model/invoice/invoice_full_model.dart';
import 'package:ting/repository/invoice_repository.dart';
import 'package:ting/utils/errors.dart';

import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(SuccessState()) {
    on<GetProductDataEvent>(getData);
  }

  var productModel = InvoiceFullModel();

  FutureOr<void> getData(GetProductDataEvent event,
      Emitter<ProductState> emit) async {
    emit(ProgressState());
    var repository = InvoiceRepository();
    var baseModel = await repository.getProduct(event.model.id.toString());
    emit(SuccessState());
    if (baseModel.code == 200) {
      productModel = baseModel.response as InvoiceFullModel;
      emit(SuccessState());
      return;
    }
    emit(ErrorState(failure: ServerFailure(message: baseModel.message)));
  }
}
