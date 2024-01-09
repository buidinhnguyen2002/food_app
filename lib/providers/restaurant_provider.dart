import 'dart:convert';

import 'package:final_project/models/restaurant.dart';
import 'package:final_project/utils/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RestaurantProvider with ChangeNotifier {
  List<Restaurant> _restaurants = [];
  List<Restaurant> get restaurants {
    return _restaurants;
  }

  Restaurant getRestaurantById(String id) {
    return _restaurants.firstWhere((res) => res.id == id);
  }

  Future<void> fetchAndSetRestaurant() async {
    try {
      final response = await http.get(Uri.parse(API.getAllRestaurants));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData['status'] != 'success') return;
      final data = extractedData['data'] as List;
      _restaurants = data.map((res) => Restaurant.fromJson(res)).toList();
      print(_restaurants);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
