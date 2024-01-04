import 'package:collection/collection.dart';
import 'package:final_project/models/cart_item.dart';
import 'package:final_project/providers/cart_provider.dart';
import 'package:final_project/providers/order_provider.dart';
import 'package:final_project/screens/address_screen.dart';
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

  void handlePlaceOrder() {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final order = Provider.of<OrderProvider>(context, listen: false);
    final groupRestaurant = cart.groupOrdersByRestaurant();
    groupRestaurant.forEach((key, value) {
      final totalAmount = value.fold<double>(
          0,
          (previousValue, item) =>
              previousValue + (item.price * item.quantity));
      order.placeOrder(items: value, totalAmount: totalAmount);
    });
  }

  void checkoutWithPayPal() async {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => PaypalCheckout(
        sandboxMode: true,
        clientId:
            "ATt2zw3QwlkRMVwbWKzL1CqpKC1qBHRU3sP54gs981n0HmIovmbvHdeCuPpnXeXXqJcWd7GyFtwvvDsw",
        secretKey:
            "EEMsI-DgEgnkQWKdf_Afs4ikNvhPQ8a7sadNrVGixVgjjyYloxRZKcPtNsFwmTYtDpTo_ke77r2Hx-0H",
        returnURL: "success.snippetcoder.com",
        cancelURL: "cancel.snippetcoder.com",
        transactions: const [
          {
            "amount": {
              "total": '70',
              "currency": "USD",
              "details": {
                "subtotal": '70',
                "shipping": '0',
                "shipping_discount": 0
              }
            },
            "description": "The payment transaction description.",
            // "payment_options": {
            //   "allowed_payment_method":
            //       "INSTANT_FUNDING_SOURCE"
            // },
            "item_list": {
              "items": [
                {
                  "name": "Apple",
                  "quantity": 4,
                  "price": '5',
                  "currency": "USD"
                },
                {
                  "name": "Pineapple",
                  "quantity": 5,
                  "price": '10',
                  "currency": "USD"
                }
              ],

              // shipping address is not required though
              //   "shipping_address": {
              //     "recipient_name": "Raman Singh",
              //     "line1": "Delhi",
              //     "line2": "",
              //     "city": "Delhi",
              //     "country_code": "IN",
              //     "postal_code": "11001",
              //     "phone": "+00000000",
              //     "state": "Texas"
              //  },
            }
          }
        ],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          print("onSuccess: $params");
        },
        onError: (error) {
          print("onError: $error");
          Navigator.pop(context);
        },
        onCancel: () {
          print('cancelled:');
        },
      ),
    ));
  }

  List<Widget> _buildOrderSummaryByRestaurant(
      Map<String, List<CartItem>> groupByRestaurant) {
    List<Widget> widgetList = [];

    groupByRestaurant.forEach((key, value) {
      widgetList.add(
        CardTitle(
          title: "Order Summary",
          restaurantName: "ABC",
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
    return Scaffold(
      appBar: AppBar(
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
                          // AddressItem(title: "Home", description: "ABC"),
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
                                  "Home",
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
                                "ABC",
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
                title: "Place order - $deliveryFee VNĐ",
                onPress: checkoutWithPayPal),
          )
        ],
      ),
    );
  }
}
