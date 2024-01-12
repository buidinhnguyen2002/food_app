import 'package:final_project/providers/cart_provider.dart';
import 'package:final_project/screens/checkout_screen.dart';
import 'package:final_project/utils/colors.dart';
import 'package:final_project/utils/constants.dart';
import 'package:final_project/utils/functions.dart';
import 'package:final_project/utils/widgets.dart';
import 'package:final_project/widgets/cart_item.dart';
import 'package:final_project/widgets/common_button.dart';
import 'package:final_project/widgets/quantity_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_item.dart' as ci;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  static const routeName = '/cart';

  Widget emptyCart(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AssetConstants.emptyCart,
            fit: BoxFit.cover,
            height: 300,
            width: double.infinity,
          ),
          BoxEmpty.sizeBox25,
          Text(
            "Empty",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          BoxEmpty.sizeBox10,
          Text(
            AppLocalizations.of(context)!.label_empty,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }

  Widget listProductInCart(BuildContext context, Map<String, ci.CartItem> items,
      double totalAmount) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: ListView.separated(
              itemBuilder: (context, index) {
                final item = items.values.toList()[index];
                return CartItem(
                  id: item.id,
                  title: item.title,
                  price: item.price,
                  imageSource: item.imageSource,
                  quantity: item.quantity,
                );
              },
              separatorBuilder: (context, index) {
                return BoxEmpty.sizeBox20;
              },
              itemCount: items.length,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
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
                      AppLocalizations.of(context)!.label_total,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      "${totalAmount.toInt()} VNĐ",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
                BoxEmpty.sizeBox20,
                Row(
                  children: [
                    Expanded(
                      child: CommonButton(
                        title: AppLocalizations.of(context)!.button_check_out,
                        onPress: () {
                          navigation(context, CheckOutScreen.routeName);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final items = cart.items;
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          AppLocalizations.of(context)!.label_my_cart,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: items.isEmpty
          ? emptyCart(context)
          : listProductInCart(
              context, items.cast<String, ci.CartItem>(), cart.totalAmount),
    );
  }
}
