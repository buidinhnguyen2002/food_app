import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _currentLocale = Locale('vi');
  Map<int, Locale> _locales = {
    1: Locale('en'),
    2: Locale('vi'),
  };
  Map<int, Locale> get locale {
    return _locales;
  }

  Locale get currentLocale => _currentLocale;

  void changeLocale(Locale newLocale) {
    _currentLocale = newLocale;
    notifyListeners();
  }

  // void changeLocale(int value) {
  //   _currentLocale = _locales[value]!;
  //   notifyListeners();
  // }
}
