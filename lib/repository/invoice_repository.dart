import 'package:dio/dio.dart';

import '../model/base_model.dart';
import '../model/invoice/invoice_model.dart';
import '../services/api_constanta.dart';
import '../services/api_service.dart';
import '../services/preference_service.dart';
import 'repo.dart';

class InvoiceRepository {
  late ApiService apiService;

  InvoiceRepository() {
    apiService = ApiService(ApiConstanta.BASE_URL_TING);
  }

  Future<BaseModel> getInvoices() async {
    var service = PreferenceService();
    final token = await basicToken();
    var headers = {
      'Content-type': 'application/json',
      'Content': 'application/json',
      'Accept-Language': service.getLanguage(),
      'Accept-Encoding': 'UTF-8',
      'Authorization': '$token',
    };

    var url = ApiConstanta.GET_INVOICE_LIST;
    Response? response;
    try {
      response = await apiService.getGetData(headers, url);
      if (response!.statusCode != 200) {
        return BaseModel(
          code: response.statusCode,
          message: response.data['message'],
        );
      } else {
        if (response.data['result'] == 0) {
          List<InvoiceModel> list = [];
          response.data['response']
              .map((e) => list.add(InvoiceModel.fromJson(e)))
              .toList();
          return BaseModel(
            code: 200,
            response: list,
          );
        } else {
          return BaseModel(
            code: response.statusCode,
            message: response.data['message'],
          );
        }
      }
    } on Exception {
      return SERVER_NOT_WORKING;
    }
  }
}
