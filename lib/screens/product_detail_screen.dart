import 'package:final_project/providers/cart_provider.dart';
import 'package:final_project/providers/food_data.dart';
import 'package:final_project/utils/widgets.dart';
import 'package:final_project/widgets/common_button.dart';
import 'package:final_project/widgets/quantity_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/product-detail';
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;

  void increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decreaseQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      final id = args['id'];
      final food =
          Provider.of<FoodData>(context, listen: false).getFoodById(id);
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text(food.foodName),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 250,
              width: double.infinity,
              child: Image.network(
                food.imageSource,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Price: ${food.price} VNĐ",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 22),
                    ),
                    BoxEmpty.sizeBox5,
                    Text(food.description),
                    BoxEmpty.sizeBox5,
                    if (food.quantityAvailable == 0)
                      Text(
                        "Sold out",
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.error,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    else
                      Text(
                        "Available",
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.only(
                    top: 20, left: 20, right: 20, bottom: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                // height: 50,
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total: ${quantity * food.price} VNĐ",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        QuantitySelector(
                          quantity: quantity,
                          decreaseQuantity: decreaseQuantity,
                          increaseQuantity: increaseQuantity,
                        ),
                      ],
                    ),
                    BoxEmpty.sizeBox20,
                    Row(
                      children: [
                        Expanded(
                          child: CommonButton(
                            title: "Add to cart",
                            onPress: () {
                              cart.addItem(
                                id,
                                food.price,
                                food.foodName,
                                quantity,
                                food.imageSource,
                                cart.cartId,
                                food.restaurantId,
                              );
                            },
                          ),
                        ),
                        BoxEmpty.sizeBox20,
                        Expanded(
                          child: CommonButton(
                            title: "Buy now",
                            onPress: () {},
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Product Detail'),
        ),
        body: const Center(
          child: Text('No Product ID'),
        ),
      );
    }
  }
}
