import 'package:dio/dio.dart';
import 'package:ting/model/cis_model.dart';

import '../model/base_model.dart';
import '../model/util_aggregate_response.dart';
import '../model/utilization_aggregation_request.dart';
import '../services/api_constanta.dart';
import '../services/api_service.dart';
import '../services/preference_service.dart';
import 'repo.dart';

class CisRepository {
  late ApiService apiService;

  CisRepository() {
    apiService = ApiService(ApiConstanta.BASE_URL_TING);
  }

  Future<BaseModel> cisStatus(String cis) async {
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
      "cis": cis,
    };

    var url = ApiConstanta.CIS_STATUS;
    Response? response;
    try {
      response = await apiService.getPostData(data, headers, url);
      if (response?.statusCode == 200 && response?.data['result'] == 0) {
        return BaseModel(
          code: 200,
          response: CisModel.fromJson(response?.data['response']),
        );
      } else {
        return BaseModel(
          code: response?.data['result'],
          message: response?.data['result_message'],
        );
      }
    } on Exception {
      return SERVER_NOT_WORKING;
    }
  }

  Future<BaseModel> sendUtilAggregation(
    UtilizationAggregationRequest request,
  ) async {
    var service = PreferenceService();
    final token = await basicToken();

    var headers = {
      'Content-type': 'application/json',
      'Content': 'application/json',
      'Accept-Language': service.getLanguage(),
      'Accept-Encoding': 'UTF-8',
      'Authorization': '$token',
    };

    var url = ApiConstanta.UTILIZATION_AGGREGATION;
    Response? response;
    try {
      response = await apiService.getPostData(request.toJson(), headers, url);
      if (response?.statusCode == 200 && response?.data['result'] == 0) {
        return BaseModel(
          code: 200,
          response: UtilAggregateResponse.fromJson(response?.data['response']),
        );
      } else {
        return BaseModel(
          code: response?.data['result'],
          message: response?.data['result_message'],
        );
      }
    } on Exception {
      return SERVER_NOT_WORKING;
    }
  }

  Future<BaseModel> checkingAggregation(
    String utilId,
  ) async {
    var service = PreferenceService();
    final token = await basicToken();

    var data = {
      "utilId": utilId,
    };

    var headers = {
      'Content-type': 'application/json',
      'Content': 'application/json',
      'Accept-Language': service.getLanguage(),
      'Accept-Encoding': 'UTF-8',
      'Authorization': '$token',
    };

    var url = ApiConstanta.CHECKING_UTILIZATION_AGGREGATION;
    Response? response;
    try {
      response = await apiService.getPostData(data, headers, url);
      if (response?.statusCode == 200 && response?.data['result'] == 0) {
        return BaseModel(
          code: 200,
          response: UtilAggregateResponse.fromJson(response?.data['response']),
        );
      } else {
        return BaseModel(
          code: response?.data['result'],
          message: response?.data['result_message'],
        );
      }
    } on Exception {
      return SERVER_NOT_WORKING;
    }
  }
}
