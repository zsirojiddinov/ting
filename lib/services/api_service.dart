import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';


class ApiService {
  late final Dio _dio;
  late Logger logger;

  ApiService(
    String baseUrl,
  ) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(seconds: 30000),
      ),
    );

    logger = Logger(
      filter: null,
      printer: PrettyPrinter(
          methodCount: 2,
          // Number of method calls to be displayed
          errorMethodCount: 8,
          // Number of method calls if stacktrace is provided
          lineLength: 120,
          // Width of the output
          colors: true,
          // Colorful log messages
          printEmojis: true,
          // Print an emoji for each log message
          printTime: false // Should each log print contain a timestamp
          ),
      output: null,
    );
  }

  initializeInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) => {
          debugPrint("onError"),
        },
        onRequest: (options, handler) => {
          debugPrint("onRequest"),
        },
        onResponse: (response, handler) => {
          debugPrint("onResponse"),
        },
      ),
    );
  }

  Future<Response?> getGetData(
    Map<String, dynamic> headers,
    String url,
  ) async {
    Response response;

    try {
      response = await _dio.get(
        url,
        options: Options(
          headers: headers,
        ),
      );
      Map<String, dynamic> myData = {
        'link': url,
        'headers': headers,
        'response': response.data
      };
      logger.t(myData);
    } on DioError catch (e) {
      if (e.response?.statusCode == 422) {
        return e.response;
      }
      if (e.response?.statusCode == 403) {
        return e.response;
      }
      if (e.response?.statusCode == 401) {
        return e.response;
      }
      if (e.response?.statusCode == 503) {
        return e.response;
      }

      if (e.response?.statusCode == 500) {
        return e.response;
      }
      Map<String, dynamic> myData = {
        'link': url,
        'headers': headers,
        'errors': e.message
      };
      logger.t(myData);
      logger.e("Exception", error: e.message);
      throw Exception(e.message);
    }
    return response;
  }

  Future<Response?> getPostData(
    Map<String, dynamic> data,
    Map<String, dynamic> headers,
    String url,
  ) async {
    Response response;
    try {
      response = await _dio.post(
        url,
        options: Options(
          headers: headers,
        ),
        data: data,
      );
      Map<String, dynamic> myData = {
        'link': url,
        'headers': headers,
        'data': data,
        'response': response.data
      };
      logger.t(myData);
    } on DioError catch (e) {
      Map<String, dynamic> myData = {
        'link': url,
        'headers': headers,
        'data': data,
        'errors': "${e.response?.statusCode}\n"
            "${e.response?.toString()}\n"
            "${e.message}\n"
      };
      logger.t(myData);
      if (e.response?.statusCode == 422) {
        return e.response;
      }
      if (e.response?.statusCode == 403) {
        return e.response;
      }
      if (e.response?.statusCode == 401) {
        return e.response;
      }
      if (e.response?.statusCode == 400) {
        return e.response;
      }
      if (e.response?.statusCode == 404) {
        return e.response;
      }
      if (e.response?.statusCode == 503) {
        return e.response;
      }

      if (e.response?.statusCode == 500) {
        logger.t(e.response);
        return e.response;
      }
      throw Exception(e.message);
    }
    return response;
  }
}
