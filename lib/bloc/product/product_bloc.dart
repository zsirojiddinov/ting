import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ting/model/invoice/add_cis_response.dart';
import 'package:ting/model/invoice/invoice_full_model.dart';
import 'package:ting/repository/invoice_repository.dart';
import 'package:ting/utils/errors.dart';

import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(SuccessState()) {
    on<GetProductDataEvent>(getData);
    on<AddBarcodeEvent>(addEvent);
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

  addEvent(AddBarcodeEvent event, Emitter<ProductState> emit) async {
    if (productModel.status == 2) {
      emit(ErrorState(failure: ServerFailure(message: "barchasi yetarli")));
      return;
    }

    if (event.data.barcodeData == "") {
      emit(ErrorState(failure: ServerFailure(message: "empty")));
      return;
    }

    emit(ProgressState());
    var repository = InvoiceRepository();
    var baseResponse = await repository.add_cis(
      productModel.id.toString(),
      event.data.barcodeData,
    );

    if (baseResponse.code != 200) {
      emit(
        ErrorState(
          failure: ServerFailure(message: baseResponse.message),
        ),
      );
      return;
    }

    print(baseResponse.code);

    var addCisResponse = baseResponse.response as AddCisResponse;
    productModel.status = addCisResponse.facturaStatus;

    for (var item in productModel.products!) {
      if (item.productId == addCisResponse.productId) {
        item.cisCount = addCisResponse.cisCount;
        emit(SuccessState());
        return;
      }
    }
  }
}
