import 'dart:convert';

import 'package:final_project/models/food.dart';
import 'package:final_project/utils/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FoodData with ChangeNotifier {
  List<Food> _food = [];
  List<Food> get foods {
    return [..._food];
  }

  Food getFoodById(String id) {
    return _food.firstWhere((food) => food.id == id);
  }

  List<Food> getFoodByRestaurant(String resId) {
    return _food.where((food) => food.restaurantId == resId).toList();
  }

  List<Food> getFoodBySearch(String keyWord) {
    if (keyWord == '') return [];
    return _food
        .where((food) =>
            food.foodName.toLowerCase().contains(keyWord.toLowerCase()))
        .toList();
  }

  Future<void> fetchAndSetFood() async {
    try {
      final response = await http.get(Uri.parse(API.getAllFoods));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData['status'] != 'success') return;
      final data = extractedData['data'] as List;
      _food = data.map((food) => Food.fromJson(food)).toList();
      notifyListeners();
    } catch (e) {
      // print("Loi $e");
    }
  }
}
