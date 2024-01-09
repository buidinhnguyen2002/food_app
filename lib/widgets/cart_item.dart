import 'package:final_project/providers/cart_provider.dart';
import 'package:final_project/utils/colors.dart';
import 'package:final_project/utils/functions.dart';
import 'package:final_project/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  const CartItem(
      {super.key,
      required this.id,
      required this.title,
      required this.quantity,
      required this.price,
      required this.imageSource});
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String imageSource;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Dismissible(
      background: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.error,
            borderRadius: BorderRadius.circular(25)),
        child: Icon(
          Icons.delete,
          color: Theme.of(context).colorScheme.onError,
        ),
      ),
      key: ValueKey<String>(id),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                  "Are you sure you want to delete this product in cart?"),
              actions: [
                TextButton(
                  onPressed: () {
                    cart.removeItem(id);
                    Navigator.of(context).pop(true);
                    showNotification(
                        context, "Đã xóa $title ra khỏi giỏ hàng.");
                  },
                  child: const Text("Yes"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text("No"),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                imageSource,
                fit: BoxFit.cover,
                height: double.infinity,
                width: 120,
              ),
            ),
            BoxEmpty.sizeBox20,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Row(
                    children: [
                      Text(
                        "$quantity items",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      BoxEmpty.sizeBox5,
                      Text(
                        "|",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      BoxEmpty.sizeBox5,
                      Text(
                        "1.5 km",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  Text(
                    "${quantity * price.toInt()} VNĐ",
                    style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
