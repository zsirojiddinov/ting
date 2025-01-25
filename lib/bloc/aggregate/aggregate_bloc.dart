import 'dart:async';

import 'package:barcode_newland_flutter/newland_scan_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ting/ui/widget/scan_result.dart';
import 'package:ting/utils/errors.dart';

import '../../model/cis_model.dart';
import 'aggregate_event.dart';
import 'aggregate_state.dart';

class AggregateBloc extends Bloc<AggregateEvent, AggregateState>
    implements OnScannerResult {
  bool get isHasGroupData {
    return groupModel.code != "";
  }

  var groupModel = CisModel();
  var listCis = <CisModel>[
    CisModel(),
    CisModel(),
    CisModel(),
    CisModel(),
    CisModel(),
    CisModel(),
    CisModel(),
    CisModel(),
    CisModel(),
    CisModel(),
  ];

  AggregateBloc() : super(SuccessState()) {
    on<SettingsEvent>(settings);
    on<AddBarcodeEvent>(addBarcode);
  }

  FutureOr<void> settings(
      SettingsEvent event, Emitter<AggregateState> emit) async {
    // Get.to(() => ProfilePage());
    return;
  }

  FutureOr<void> addBarcode(
      AddBarcodeEvent event, Emitter<AggregateState> emit) async {
    print("result");
    print(event.data.barcodeData);
    print(event.data.barcodeType);

    if (groupModel.code == "") {
      groupModel.code = event.data.barcodeData;
      emit(SuccessState());
      return;
    }

    for (var item in listCis) {
      if (item.code == "") {
        item.code = event.data.barcodeData;
        emit(SuccessState());
        return;
      }
    }

    emit(ErrorState(failure: ServerFailure(message: "scaner tugatilsin")));
  }

  @override
  result(NewlandScanResult result) {
    print("result");
    print(result.barcodeData);
    print(result.barcodeType);

    if (groupModel.code == "") {
      groupModel.code = result.barcodeData;
      emit(SuccessState());
      return;
    }

    for (var item in listCis) {
      if (item.code == "") {
        item.code == result.barcodeData;
        emit(SuccessState());
        return;
      }
    }

    emit(ErrorState(failure: ServerFailure(message: "scaner tugatilsin")));

    // if(result.barcodeData.startsWith(0))
  }
}
