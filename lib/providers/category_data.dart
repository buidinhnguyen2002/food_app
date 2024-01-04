import 'dart:convert';

import 'package:final_project/models/category.dart';
import 'package:final_project/utils/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryData with ChangeNotifier {
  List<Category> _category = [];
  List<Category> get categories {
    return [..._category];
  }

  Category getCategoryById(String id) {
    return _category.firstWhere((category) => category.id == id);
  }

  Future<void> fetchAndSetCategory() async {
    try {
      final response = await http.get(Uri.parse(API.getAllCategory));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData['status'] != 'success') return;
      final data = extractedData['data'] as List;
      _category = data.map((category) => Category.fromJson(category)).toList();
      // notifyListeners();
    } catch (e) {
      print("Loi $e");
    }
  }
}
