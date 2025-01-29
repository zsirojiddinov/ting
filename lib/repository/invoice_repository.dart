import 'package:dio/dio.dart';
import 'package:ting/model/invoice/add_cis_response.dart';
import 'package:ting/model/invoice/invoice_full_model.dart';

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

  Future<BaseModel> getProduct(String productId) async {
    var service = PreferenceService();
    final token = await basicToken();
    var headers = {
      'Content-type': 'application/json',
      'Content': 'application/json',
      'Accept-Language': service.getLanguage(),
      'Accept-Encoding': 'UTF-8',
      'Authorization': '$token',
    };

    var url = ApiConstanta.GET_INVOICE_PRODUCT;
    url = "$url/$productId";
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
          return BaseModel(
            code: 200,
            response: InvoiceFullModel.fromJson(response.data['response']),
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

  Future<BaseModel> add_cis(String factureId, String groupCis) async {
    var service = PreferenceService();
    final token = await basicToken();
    var headers = {
      'Content-type': 'application/json',
      'Content': 'application/json',
      'Accept-Language': service.getLanguage(),
      'Accept-Encoding': 'UTF-8',
      'Authorization': '$token',
    };

    var data = {
      'facturaId': factureId,
      'groupCis': groupCis,
    };

    var url = ApiConstanta.ADD_CIS;
    Response? response;
    try {
      response = await apiService.getPostData(data, headers, url);
      if (response!.statusCode != 200) {
        return BaseModel(
          code: response.statusCode,
          message: response.data['message'],
        );
      } else {
        if (response.data['result'] == 0) {
          return BaseModel(
            code: 200,
            response: AddCisResponse.fromJson(response.data['response']),
          );
        } else {
          return BaseModel(
            code: response.data['result'],
            message: response.data['result_message'],
          );
        }
      }
    } on Exception {
      return SERVER_NOT_WORKING;
    }
  }
}
