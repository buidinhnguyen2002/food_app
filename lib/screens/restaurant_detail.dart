import 'package:final_project/providers/food_data.dart';
import 'package:final_project/providers/restaurant_provider.dart';
import 'package:final_project/screens/restaurant_review_screen.dart';
import 'package:final_project/utils/colors.dart';
import 'package:final_project/utils/widgets.dart';
import 'package:final_project/widgets/custom_divider.dart';
import 'package:final_project/widgets/menu_restaurant_item.dart';
import 'package:final_project/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantDetail extends StatelessWidget {
  const RestaurantDetail({super.key});
  static const routeName = '/restaurant-detail';
  void navigateToReview(BuildContext context, String resId) {
    Navigator.of(context)
        .pushNamed(RestaurantReviewScreen.routeName, arguments: {"id": resId});
  }

  @override
  Widget build(BuildContext context) {
    final restaurantProvider =
        Provider.of<RestaurantProvider>(context, listen: false);
    final foodData = Provider.of<FoodData>(context, listen: false);
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final id = args?['id'];
    final restaurant = restaurantProvider.getRestaurantById(id);
    final foods = foodData.getFoodByRestaurant(id);
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.shopping_bag_outlined))
        ],
      ),
      body: Column(
        children: [
          Image.network(restaurant.image),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  BoxEmpty.sizeBox15,
                  const CustomDivider(),
                  ListTile(
                    leading: const Icon(
                      Icons.star,
                      color: AppColors.yellow,
                    ),
                    title: Text(
                      restaurant.rate.toString(),
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    contentPadding: const EdgeInsets.all(0),
                    horizontalTitleGap: 5,
                    dense: true,
                    trailing: IconButton(
                      onPressed: () {
                        navigateToReview(context, restaurant.id);
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                  const CustomDivider(),
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: Icon(
                      Icons.location_on,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: Text(
                      "2.4 km",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    dense: true,
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                  const CustomDivider(),
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: Icon(
                      Icons.local_activity,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: Text(
                      "Offers are available",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    dense: true,
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                  const CustomDivider(),
                  BoxEmpty.sizeBox15,
                  Text(
                    "Menu",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final food = foods[index];
                        return MenuRestaurantItem(
                          name: food.foodName,
                          id: food.id,
                          price: food.price,
                          imageSource: food.imageSource,
                        );
                      },
                      itemCount: foods.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
