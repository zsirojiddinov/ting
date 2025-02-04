import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ting/model/base_model.dart';
import 'package:ting/utils/constanta.dart';
import 'package:ting/utils/errors.dart';

import '../../model/search/search_model.dart';
import '../../repository/cis_repository.dart';
import '../product/product_bloc.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  bool get isEmpty {
    return model.code == "";
  }

  bool get isGroupModel {
    return model.packageType == IConstanta.GROUP;
  }

  var model = SearchModel();

  SearchBloc() : super(SuccessState()) {
    on<AddBarcodeEvent>(addEvent);
    on<ClearDataEvent>(clear);
  }

  clear(ClearDataEvent event, Emitter<SearchState> emit) {
    model = SearchModel();
    emit(SuccessState());
  }

  String newCode = "";

  addEvent(AddBarcodeEvent event, Emitter<SearchState> emit) async {
    if (newCode != "") {
      return;
    }
    newCode = event.data.barcodeData;

    emit(ProgressState());
    BaseModel baseModel = await checkStatus(event.data.barcodeData);
    newCode = "";

    if (baseModel.code != 200) {
      await playMusic();
      emit(ErrorState(failure: ServerFailure(message: baseModel.message!)));
      return;
    }
    model = baseModel.response as SearchModel;
    model.code = event.data.barcodeData;
    emit(SuccessState());
    return;
  }

  checkStatus(String barcode) async {
    var repository = CisRepository();
    var baseModel = await repository.search(barcode);
    return baseModel;
  }

}
