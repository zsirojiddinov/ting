import 'package:flutter/material.dart';

class L10n {
  static final all = [
    uz(),
    ru(),
  ];

  static Locale uz() {
    return const Locale('uz', 'UZ');
  }

  static Locale ru() {
    return const Locale('ru', 'RU');
  }
}
