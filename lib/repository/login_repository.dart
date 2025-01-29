import 'package:dio/dio.dart';
import 'package:ting/model/auth/role_model.dart';

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
      if (response?.statusCode != 200) {
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
      } else if (response?.data['result'] != 0) {
        return BaseModel(
          code: response?.data['result'],
          message: response?.data['result_message'],
        );
      } else {

        var loginModel = LoginModel(
          access_token: response?.data['result_message'] ?? "",
          roles: response?.data['roles'] != null
              ? response!.data['roles'].map<RoleModel>((e) => RoleModel.fromJson(e)).toList()
              : [],
        );
        return BaseModel(
          code: 200,
          response: loginModel,
        );
      }
    } on Exception {
      return SERVER_NOT_WORKING;
    }
  }


}
