import 'dart:convert';

import 'package:final_project/models/address.dart';
import 'package:final_project/utils/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddressProvider with ChangeNotifier {
  List<Address> _myAddress = [];
  int id;
  int _selectedAddress = 0;
  String get idAddress {
    return _myAddress[_selectedAddress].id;
  }

  int get selectedAddress {
    return _selectedAddress;
  }

  set selectedAddress(int value) {
    _selectedAddress = value;
  }

  AddressProvider(this._myAddress, this.id);
  List<Address> get address {
    return _myAddress;
  }

  Future<void> fetchAndSetAddress() async {
    try {
      final response = await http.get(Uri.parse("${API.address}?id=$id"));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData['status'] != 'success') return;
      final data = extractedData['data'] as List;
      _myAddress = data.map((address) => Address.fromJson(address)).toList();
      notifyListeners();
    } catch (e) {
      print("Loi $e");
    }
  }

  Address getAddressById(String id) {
    return _myAddress.where((address) => address.id == id).first;
  }

  Future<bool> createAddress(
      {required String name,
      required String district,
      required String ward,
      required String addressDetail,
      required double latitude,
      required double longitude}) async {
    try {
      final response = await http.post(
        Uri.parse(API.address),
        body: json.encode({
          "user_id": id,
          "name": name,
          "district": district,
          "ward": ward,
          "address_detail": addressDetail,
          "latitude": latitude,
          "longitude": longitude,
        }),
      );
      final responseData = json.decode(response.body);
      if (responseData['status'] == 'success') {
        fetchAndSetAddress();
        return true;
      }
    } catch (e) {
      print('Loi address $e');
      return false;
    }
    return false;
  }

  Future<bool> updateAddress(
      {required String addressId,
      required String name,
      required String district,
      required String ward,
      required String addressDetail,
      required double latitude,
      required double longitude}) async {
    try {
      final response = await http.put(
        Uri.parse(API.address),
        body: json.encode({
          "id": addressId,
          "name": name,
          "district": district,
          "ward": ward,
          "address_detail": addressDetail,
          "latitude": latitude,
          "longitude": longitude,
        }),
      );
      final responseData = json.decode(response.body);
      if (responseData['status'] == 'success') {
        fetchAndSetAddress();
        return true;
      }
    } catch (e) {
      print('Loi address $e');
      return false;
    }
    return false;
  }
}
