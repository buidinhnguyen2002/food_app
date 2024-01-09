import 'dart:convert';

import 'package:final_project/models/review.dart';
import 'package:final_project/utils/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReviewProvider with ChangeNotifier {
  List<Review> _reviews = [];
  List<Review> get reviews {
    return _reviews;
  }

  List<Review> getReviewByRestaurantId(String id) {
    return _reviews.where((review) => review.restaurantId == id).toList();
  }

  Future<void> fetchAndSetReview() async {
    try {
      final response = await http.get(Uri.parse(API.reviews));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData['status'] != 'success') return;
      final data = extractedData['data'] as List;
      _reviews = data.map((review) => Review.fromJson(review)).toList();
      notifyListeners();
    } catch (e) {
      print("Loi $e");
    }
  }

  Future<bool> addReview(String resId, String cusId, String message) async {
    try {
      final response = await http.post(
        Uri.parse(API.reviews),
        body: json.encode({
          'restaurant_id': resId,
          'customer_id': cusId,
          'message': message,
        }),
      );
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData['status'] != 'success') return false;
      final data = extractedData['data'] as dynamic;
      _reviews.add(Review.fromJson(data));
      notifyListeners();
    } catch (e) {
      print("Loi $e");
      return false;
    }
    return true;
  }
}
