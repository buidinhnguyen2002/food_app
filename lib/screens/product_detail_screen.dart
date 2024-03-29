import 'package:final_project/providers/cart_provider.dart';
import 'package:final_project/providers/food_data.dart';
import 'package:final_project/utils/functions.dart';
import 'package:final_project/utils/widgets.dart';
import 'package:final_project/widgets/common_button.dart';
import 'package:final_project/widgets/quantity_selector.dart';
import 'package:final_project/widgets/relate_food_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      final foodData = Provider.of<FoodData>(context, listen: false);
      final food = foodData.getFoodById(id);
      final relateFoods = foodData.getFoodByRestaurant(food.restaurantId);
      return Scaffold(
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text(food.foodName),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Image.network(
                food.imageSource,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${AppLocalizations.of(context)!.price} ${food.price} VNĐ",
                      // "Price: ${food.price} VNĐ",
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
                        AppLocalizations.of(context)!.label_available,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    BoxEmpty.sizeBox10,
                    Text(
                      "Food related",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    BoxEmpty.sizeBox10,
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final food = relateFoods[index];
                          return RelateFoodItem(
                              id: food.id,
                              imgaeSource: food.imageSource,
                              title: food.foodName,
                              price: food.price);
                        },
                        itemCount: relateFoods.length,
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
                          "${AppLocalizations.of(context)!.label_total} ${quantity * food.price} VNĐ",
                          // "Total: ${quantity * food.price} VNĐ",
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
                            title: AppLocalizations.of(context)!
                                .button_add_to_cart,
                            // title: "Add to cart",
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
                              showNotification(context,
                                  "Đã thêm $quantity sản phẩm này vào giỏ hàng.");
                            },
                          ),
                        ),
                        BoxEmpty.sizeBox20,
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
