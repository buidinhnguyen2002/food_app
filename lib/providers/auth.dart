import 'dart:convert';

import 'package:final_project/models/http_exception.dart';
import 'package:final_project/utils/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  bool _isLogin = false;
  int _idCart = 0;
  int _id = 0;
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
      } else {
        _isLogin = false;
      }
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
