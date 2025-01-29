import 'dart:convert';

import 'package:ting/services/preference_service.dart';

import '../model/base_model.dart';

final BaseModel SERVER_NOT_WORKING = BaseModel(
  code: -123,
  message:
      "Ma'lumotlarni to'g'riligiga ishonch xosil qilib, qaytadan urinib ko'ring!",
);

basicToken() async {
  var baseRes =
      "${PreferenceService().getLogin()}:${PreferenceService().getPassword()}";
  Codec<String, String> stringToBase64 = utf8.fuse(base64);
  String encoded = stringToBase64.encode(baseRes);

  return 'Basic $encoded';
}
