import 'dart:convert';

import 'package:final_project/models/cart_item.dart';
import 'package:final_project/models/order.dart';
import 'package:final_project/models/payment.dart';
import 'package:final_project/utils/api_constants.dart';
import 'package:final_project/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderProvider with ChangeNotifier {
  List<Order> _myOrder = [];
  int id;
  List<Payment> payments = [
    Payment(
        name: "PayPal",
        logo: AssetConstants.papalLogo,
        value: 1,
        widthIcon: 20),
    Payment(
        name: "Cash on delivery",
        logo: AssetConstants.CODPayment,
        value: 2,
        widthIcon: 40),
  ];
  int _selectedPayment = 1;
  int get selectedPayment {
    return _selectedPayment;
  }

  set selectedPayment(int value) {
    _selectedPayment = value;
  }

  List<Order> get myOrder {
    return _myOrder;
  }

  List<Order> get activeOrder {
    return _myOrder
        .where((order) =>
            order.status != 'cancelled' && order.status != 'completed')
        .toList();
  }

  List<Order> get cancelOrder {
    return _myOrder.where((order) => order.status == 'cancelled').toList();
  }

  List<Order> get completeOrder {
    return _myOrder.where((order) => order.status == 'completed').toList();
  }

  OrderProvider(this._myOrder, this.id);

  Future<void> fetchAndSetOrder() async {
    try {
      final response = await http.get(
        Uri.parse('${API.order}?id=$id'),
      );
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData['status'] != 'success') return;
      final data = extractedData['data'] as List;
      _myOrder = data.map((food) => Order.fromJson(food)).toList();
      print(_myOrder);
      notifyListeners();
    } catch (e) {
      print("Loi order provider $e");
    }
  }

  Future<bool> placeOrder(
      {required List<CartItem> items,
      required double totalAmount,
      required String status,
      required String cusAddressId}) async {
    List<Map<String, dynamic>> itemsJson =
        items.map((item) => item.toJson()).toList();
    try {
      final response = await http.post(
        Uri.parse(API.order),
        body: json.encode({
          'restaurant_id': items[0].restaurantId,
          'customer_id': id,
          'customer_address_id': cusAddressId,
          'deliveryDriver_id': 1,
          'delivery_fee': 10000,
          'unit': "VNĐ",
          'total_amount': totalAmount,
          'is_paid': status,
          'driver_rating_of_customer': 5,
          'restaurant_rating_of_customer': 5,
          'status': "active",
          'foods': itemsJson,
        }),
      );
      final responseData = json.decode(response.body);
      if (responseData['status'] == 'success') {
        fetchAndSetOrder();
        return true;
      }
    } catch (e) {
      print('Loi placeorder $e');
      return false;
    }
    return false;
  }

  Future<void> handleCancelOrder(String orderId) async {
    try {
      final response = await http.patch(
        Uri.parse(API.order),
        body: json.encode({
          'id': orderId,
          'status': 'cancelled',
        }),
      );
      final responseData = json.decode(response.body);
      if (responseData['status'] == 'success') {
        fetchAndSetOrder();
        print("Thanh cong");
      }
    } catch (e) {
      print(e);
    }
  }
}
