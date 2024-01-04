import 'dart:convert';

import 'package:final_project/models/cart_item.dart';
import 'package:final_project/models/food.dart';
import 'package:final_project/utils/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};
  int _idCart = 0;
  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  set cartId(int cartId) {
    _idCart = cartId;
  }

  int get cartId {
    return _idCart;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += total += cartItem.quantity * cartItem.price;
    });
    return total;
  }

  Map<String, List<CartItem>> groupOrdersByRestaurant() {
    Map<String, List<CartItem>> restaurantMap = {};
    _items.forEach((key, value) {
      if (!restaurantMap.containsKey(value.restaurantId)) {
        restaurantMap[value.restaurantId] = [];
      }
      restaurantMap[value.restaurantId]!.add(value);
    });
    return restaurantMap;
  }

  Future<void> fetchAndSetMyCart() async {
    try {
      final response = await http.get(Uri.parse('${API.cart}?id=${1}'));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData['status'] != 'success') return;
      final List<dynamic> data = extractedData['data'] as List<dynamic>;
      final List<CartItem> cartItems =
          data.map((item) => CartItem.fromJson(item)).toList();
      _items = {for (var item in cartItems) item.id: item};
      notifyListeners();
    } catch (e) {
      print("Loi $e a");
    }
  }

  void addItem(String productId, double price, String title, int quantity,
      String imageSource, int idCart, String restaurantId) async {
    if (_items.containsKey(productId)) {
      try {
        final response = await http.put(
          Uri.parse(API.cart),
          body: json.encode({
            'food_id': productId,
            'cart_id': idCart,
            'quantity': _items[productId]!.quantity + quantity,
          }),
        );
        final responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          _items.update(
            productId,
            (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity + quantity,
              imageSource: existingCartItem.imageSource,
              restaurantId: existingCartItem.restaurantId,
            ),
          );
        }
      } catch (e) {}
    } else {
      final response = await http.post(
        Uri.parse(API.cart),
        body: json.encode({
          'food_id': productId,
          'cart_id': idCart,
          'quantity': quantity,
        }),
      );
      final responseData = json.decode(response.body);
      if (responseData['status'] == 'success') {
        _items.putIfAbsent(
          productId,
          () => CartItem(
            id: productId,
            title: title,
            price: price,
            quantity: quantity,
            imageSource: imageSource,
            restaurantId: restaurantId,
          ),
        );
      }
    }
    notifyListeners();
  }

  Future<void> removeItem(String productId) async {
    final response = await http.delete(
      Uri.parse(API.cart),
      body: json.encode({
        'food_id': productId,
        'cart_id': _idCart,
      }),
    );
    final responseData = json.decode(response.body);
    if (responseData['status'] == 'success') {
      _items.remove(productId);
    }
    notifyListeners();
  }
}
