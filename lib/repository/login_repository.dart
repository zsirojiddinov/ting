import 'package:dio/dio.dart';

import '../model/auth/login_model.dart';
import '../model/base_model.dart';
import '../services/api_constanta.dart';
import '../services/api_service.dart';
import '../services/preference_service.dart';
import 'repo.dart';

class LoginRepository {
  late ApiService apiService;

  LoginRepository() {
    apiService = ApiService(ApiConstanta.BASE_URL_TING);
  }


  Future<BaseModel> login(String login, String password) async {
    var service = PreferenceService();
    var headers = {
      'Content-type': 'application/json',
      'Content': 'application/json',
      'Accept-Language': service.getLanguage(),
      'Accept-Encoding': 'UTF-8',
    };

    var data = {
      "login": login,
      "password": password,
    };

    var url = ApiConstanta.LOGIN;
    Response? response;
    try {
      response = await apiService.getPostData(data, headers, url);
      if (response?.data['status'] != 200) {
        String? message = "";

        try {
          if (response?.data['response']['password'] != "") {
            message = response?.data['response']['password'];
          }
        } catch (e) {
          message = response!.data['message'];
        }

        return BaseModel(
          code: response?.statusCode,
          message: message,
        );
      } else {
        return BaseModel(
          code: 200,
          response: LoginModel.fromJson(response?.data['response']),
        );
      }
    } on Exception {
      return SERVER_NOT_WORKING;
    }
  }


}
