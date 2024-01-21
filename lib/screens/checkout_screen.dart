// ignore_for_file: use_build_context_synchronously

import 'package:collection/collection.dart';
import 'package:final_project/models/cart_item.dart';
import 'package:final_project/providers/NavigatorProvider.dart';
import 'package:final_project/providers/address_provider.dart';
import 'package:final_project/providers/cart_provider.dart';
import 'package:final_project/providers/order_provider.dart';
import 'package:final_project/providers/restaurant_provider.dart';
import 'package:final_project/screens/address_screen.dart';
import 'package:final_project/screens/home_screen.dart';
import 'package:final_project/screens/main_screen.dart';
import 'package:final_project/screens/payment_screen.dart';
import 'package:final_project/utils/colors.dart';
import 'package:final_project/utils/functions.dart';
import 'package:final_project/utils/widgets.dart';
import 'package:final_project/widgets/address_item.dart';
import 'package:final_project/widgets/bottom_widget.dart';
import 'package:final_project/widgets/card_title.dart';
import 'package:final_project/widgets/common_button.dart';
import 'package:final_project/widgets/product_summary_item.dart';
import 'package:final_project/widgets/quantity_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:provider/provider.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:final_project/main.dart';

class CheckOutScreen extends StatefulWidget {
  static const routeName = '/check-out';

  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final int deliveryFee = 20000;

  Widget horizontalLine(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Divider(
        height: 1,
        color: Theme.of(context).dividerColor,
      ),
    );
  }

  Widget _orderItem(BuildContext context, String title, int price) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      dense: true,
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
          fontSize: 14,
        ),
      ),
      trailing: Text(
        "$price VNĐ",
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void handlePlaceOrder(BuildContext context) async {
    final order = Provider.of<OrderProvider>(context, listen: false);
    final selectedPayment = order.selectedPayment;
    if (selectedPayment == 1) {
      checkoutWithPayPal(context);
    } else {
      callPlaceOrder("0");
      await showNotification(context, "Place order successful");
      Future.delayed(
        Duration(seconds: 1, milliseconds: 50),
        () => Navigator.pushNamedAndRemoveUntil(
            context, MainScreen.routeName, (route) => false,
            arguments: {"index": 1}),
      );
    }
  }

  void callPlaceOrder(String status) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final order = Provider.of<OrderProvider>(context, listen: false);
    final addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    final cusAddressId = addressProvider.idAddress;
    final groupRestaurant = cart.groupOrdersByRestaurant();
    groupRestaurant.forEach((key, value) {
      final totalAmount = value.fold<double>(
          0,
          (previousValue, item) =>
              previousValue + (item.price * item.quantity));
      order.placeOrder(
          items: value,
          totalAmount: totalAmount,
          status: status,
          cusAddressId: cusAddressId);
    });
  }

  double convertTotalAmountToUSD() {
    final cart = Provider.of<CartProvider>(context, listen: false);
    double exchangeRate = 25000;
    double usdAmount = cart.totalAmount / exchangeRate;
    usdAmount = double.parse(usdAmount.toStringAsFixed(2));
    return usdAmount;
  }

  void checkoutWithPayPal(BuildContext ctx) async {
    final result = await Navigator.of(ctx).push(MaterialPageRoute(
      builder: (ctx) => PaypalCheckout(
        sandboxMode: true,
        clientId:
            "ATt2zw3QwlkRMVwbWKzL1CqpKC1qBHRU3sP54gs981n0HmIovmbvHdeCuPpnXeXXqJcWd7GyFtwvvDsw",
        secretKey:
            "EEMsI-DgEgnkQWKdf_Afs4ikNvhPQ8a7sadNrVGixVgjjyYloxRZKcPtNsFwmTYtDpTo_ke77r2Hx-0H",
        returnURL: "success.snippetcoder.com",
        cancelURL: "cancel.snippetcoder.com",
        transactions: [
          {
            "amount": {
              // "total": '70',
              "total": convertTotalAmountToUSD(),
              "currency": "USD",
              "details": {
                // "subtotal": '70',
                "subtotal": convertTotalAmountToUSD(),
                "shipping": '0',
                "shipping_discount": 0
              }
            },
            "description": "The payment transaction description.",
            // "item_list": {
            //   "items": [
            //     {
            //       "name": "Apple",
            //       "quantity": 4,
            //       "price": '5',
            //       "currency": "USD"
            //     },
            //     {
            //       "name": "Pineapple",
            //       "quantity": 5,
            //       "price": '10',
            //       "currency": "USD"
            //     }
            //   ],
            // }
          }
        ],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          callPlaceOrder("1");
          Navigator.pop(ctx, "success");
          print("onSuccess: $params");
        },
        onError: (error) {
          print("onError: $error");
          Navigator.pop(context);
        },
        onCancel: () {
          print('cancelled:');
          Navigator.pop(ctx);
        },
      ),
    ));
    if (result != null) {
      Navigator.pushNamedAndRemoveUntil(
          ctx, MainScreen.routeName, (route) => false,
          arguments: {"index": 1});
    }
  }

  List<Widget> _buildOrderSummaryByRestaurant(
      Map<String, List<CartItem>> groupByRestaurant) {
    List<Widget> widgetList = [];
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    groupByRestaurant.forEach((key, value) {
      final resName = restaurantProvider.getRestaurantById(key).name;
      widgetList.add(
        CardTitle(
          title: "Order Summary",
          restaurantName: resName,
          child: Column(
            children: value.mapIndexed((index, food) {
              return Column(
                children: [
                  ProductSummaryItem(
                    title: food.title,
                    imageSource: food.imageSource,
                    quantity: food.quantity,
                    totalAmount: (food.price * food.quantity).toInt(),
                  ),
                  if (index != value.length - 1) BoxEmpty.sizeBox5,
                  if (index != value.length - 1) horizontalLine(context),
                ],
              );
            }).toList(),
          ),
        ),
      );
    });
    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final groupOrdersByRestaurant = cart.groupOrdersByRestaurant();
    final addressProvider = Provider.of<AddressProvider>(context);
    final address = addressProvider.address[addressProvider.selectedAddress];
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text("Checkout Orders",
            style: Theme.of(context).textTheme.titleMedium),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                child: Column(
                  children: [
                    CardTitle(
                      title: "Deliver to",
                      child: Column(
                        children: [
                          horizontalLine(context),
                          ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            leading: const CircleAvatar(
                              radius: 30,
                              backgroundColor: Color.fromARGB(29, 25, 153, 68),
                              child: CircleAvatar(
                                child: Icon(Icons.location_pin),
                              ),
                            ),
                            title: Row(
                              children: [
                                Text(
                                  address.name,
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                                BoxEmpty.sizeBox10,
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(29, 25, 153, 68),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    "Defauld",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: Text(
                                address.address,
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                navigation(context, AddressScreen.routeName);
                              },
                              icon: Icon(Icons.arrow_forward_ios,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                        ],
                      ),
                    ),
                    BoxEmpty.sizeBox20,
                    ..._buildOrderSummaryByRestaurant(groupOrdersByRestaurant),
                    BoxEmpty.sizeBox20,
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            leading: Icon(
                              Icons.payment,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            title: Text(
                              "Payment Methods",
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                navigation(context, PaymentScreen.routeName);
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                          horizontalLine(context),
                          ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            leading: Icon(
                              Icons.local_activity,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            title: Text(
                              "Get Discounts",
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    BoxEmpty.sizeBox20,
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _orderItem(
                              context, "Subtotal", cart.totalAmount.toInt()),
                          _orderItem(context, "Delivery Fee", deliveryFee),
                          horizontalLine(context),
                          _orderItem(context, "Total",
                              cart.totalAmount.toInt() + deliveryFee),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          BottomWidget(
            child: CommonButton(
              title:
                  "Place order - ${cart.totalAmount.toInt() + deliveryFee} VNĐ",
              onPress: () => handlePlaceOrder(context),
            ),
          )
        ],
      ),
    );
  }
}
