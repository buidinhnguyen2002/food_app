import 'package:final_project/providers/restaurant_provider.dart';
import 'package:final_project/widgets/restaurant_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurants = Provider.of<RestaurantProvider>(context).restaurants;
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: ListView.builder(
        itemBuilder: (context, index) {
          final restaurant = restaurants[index];
          return RestaurantItem(
            key: ValueKey(restaurant.id),
            id: restaurant.id,
            image: restaurant.image,
            name: restaurant.name,
            description: restaurant.description,
            phoneNumber: restaurant.phoneNumber,
            rate: restaurant.rate,
          );
        },
        itemCount: restaurants.length,
      ),
      // child: Text("ABC"),
    );
  }
}
