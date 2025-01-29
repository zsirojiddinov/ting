import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ting/model/auth/role_model.dart';

import '../l10n/l10n.dart';
import '../utils/constanta.dart';

class PreferenceService {
  final _box = GetStorage();
  final text_version_uz = 'textVersionUz';
  final text_version_Ru = 'textVersionRu';
  final appLanguageUz = 'appLanguageUz';
  final appLanguageRu = 'appLanguageRu';

  Locale getLang() {
    var lang = _box.read(IConstanta.LANGUAGE) ?? "";
    return lang == ""
        ? L10n.uz()
        : lang == "uz"
            ? L10n.uz()
            : L10n.ru();
  }

  String getLanguage() {
    var lang = _box.read(IConstanta.LANGUAGE) ?? "";
    return lang == ""
        ? IConstanta.LANG_UZ
        : lang == "uz"
            ? IConstanta.LANG_UZ
            : IConstanta.LANG_RU;
  }

  setLang(Locale locale) {
    var languageCode = locale.languageCode;
    _box.write(IConstanta.LANGUAGE, languageCode);
  }

  logout() {
    _box.write(IConstanta.TOKEN, "");
    _box.write(IConstanta.FULL_NAME, "");
    _box.write(IConstanta.PASSWORD, "");
    _box.write(IConstanta.LOGIN, "");
  }

  setToken(String token) {
    _box.write(IConstanta.TOKEN, token);
  }

  setFullName(String name) {
    _box.write(IConstanta.FULL_NAME, name);
  }



  getToken() {
    return _box.read(IConstanta.TOKEN) ?? "";
  }

  String getFullName() {
    return _box.read(IConstanta.FULL_NAME) ?? "";
  }

  setPassword(String phone) {
    _box.write(IConstanta.PASSWORD, phone);
  }
  String getPassword() {
    return _box.read(IConstanta.PASSWORD) ?? "";
  }

  setLogin(String login) {
    _box.write(IConstanta.LOGIN, login);
  }
  String getLogin() {
    return _box.read(IConstanta.LOGIN) ?? "";
  }

  setRoles(List<RoleModel> roles) {
    List<String> roleListJson =
        roles.map((role) => jsonEncode(role.toJson())).toList();
    _box.write(IConstanta.ROLES, roleListJson);
  }

  List<RoleModel> getRoles() {
    List<String> roleListJson = _box.read(IConstanta.ROLES) ?? [];
    return roleListJson
        .map((json) => RoleModel.fromJson(jsonDecode(json)))
        .toList();
  }
}
