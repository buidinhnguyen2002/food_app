import 'dart:convert';

import 'package:final_project/models/http_exception.dart';
import 'package:final_project/models/language.dart';
import 'package:final_project/utils/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  bool _isLogin = false;
  int _idCart = 0;
  int _id = 0;
  String _avatar = "";

  String get avatar {
    return _avatar;
  }

  bool get isAuth {
    return _isLogin;
  }

  int get cartId {
    return _idCart;
  }

  int get id {
    return _id;
  }

  Future<void> login(String userName, String password) async {
    try {
      final response = await http.post(
        Uri.parse(API.signIn),
        body: json.encode({
          'user_name': userName,
          'password': password,
        }),
      );
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['status'] == 'error') {
        throw HttpException(responseData['message']);
      }
      if (responseData['status'] == 'success') {
        _isLogin = true;
        final data = responseData['data'];
        _idCart = data['cart_id'];
        _id = data['id'];
        _avatar = data['avatar'];
      } else {
        _isLogin = false;
      }
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> register(String userName, String password, String fullName,
      String phoneNumber) async {
    try {
      final response = await http.post(
        Uri.parse(API.signUp),
        body: json.encode({
          'user_name': userName,
          'password': password,
          'full_name': fullName,
          'phone_number': phoneNumber,
        }),
      );
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['status'] == 'error') {
        throw HttpException(responseData['message']);
      }
      if (responseData['status'] == 'success') {
        notifyListeners();
        return true;
      } else {
        notifyListeners();
        return false;
      }
      // notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Locale _currentLocale = Locale('vi');
  int _selectedLanguage = 1;
  final Map<int, Locale> _locales = {
    1: const Locale('en'),
    2: const Locale('vi'),
  };
  final List<Language> _languages = [
    Language(name: "English", locale: const Locale('en'), value: 1),
    Language(name: "Viet Nam", locale: const Locale('vi'), value: 2),
  ];
  List<Language> get languages {
    return _languages;
  }

  int get selectedLanguage {
    return _selectedLanguage;
  }

  void set selectedLanguage(int value) {
    _selectedLanguage = value;
    notifyListeners();
  }

  Map<int, Locale> get locales {
    return _locales;
  }

  Locale get currentLocale => _languages[_selectedLanguage - 1].locale;

  void changeLocale(Locale newLocale) {
    _currentLocale = newLocale;
    notifyListeners();
  }
}
