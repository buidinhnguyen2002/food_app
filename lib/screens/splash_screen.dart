import 'package:final_project/models/restaurant.dart';
import 'package:final_project/providers/address_provider.dart';
import 'package:final_project/providers/auth.dart';
import 'package:final_project/providers/cart_provider.dart';
import 'package:final_project/providers/category_data.dart';
import 'package:final_project/providers/food_data.dart';
import 'package:final_project/providers/order_provider.dart';
import 'package:final_project/providers/restaurant_provider.dart';
import 'package:final_project/providers/review_provider.dart';
import 'package:final_project/screens/main_screen.dart';
import 'package:final_project/utils/constants.dart';
import 'package:final_project/utils/functions.dart';
import 'package:final_project/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void loadData() async {
    final cartId = Provider.of<Auth>(context, listen: false).cartId;
    Provider.of<CartProvider>(context, listen: false).cartId = cartId;
    await Provider.of<RestaurantProvider>(context, listen: false)
        .fetchAndSetRestaurant();
    await Provider.of<ReviewProvider>(context, listen: false)
        .fetchAndSetReview();
    await Provider.of<FoodData>(context, listen: false).fetchAndSetFood();
    await Provider.of<OrderProvider>(context, listen: false).fetchAndSetOrder();
    await Provider.of<AddressProvider>(context, listen: false)
        .fetchAndSetAddress();
    await Provider.of<CategoryData>(context, listen: false)
        .fetchAndSetCategory();
    await Provider.of<CartProvider>(context, listen: false).fetchAndSetMyCart();
    Future.delayed(
      const Duration(seconds: 2),
      () => Navigator.of(context).pushNamed(MainScreen.routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AssetConstants.logo, fit: BoxFit.cover),
                BoxEmpty.sizeBox10,
                const Text(
                  "Foodu",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            left: deviceSize.width / 2 - 20,
            child: const CircularProgressIndicator.adaptive(),
          )
        ],
      ),
    );
  }
}
