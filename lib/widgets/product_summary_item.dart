import 'package:flutter/material.dart';

class ProductSummaryItem extends StatelessWidget {
  const ProductSummaryItem(
      {super.key,
      required this.title,
      required this.imageSource,
      required this.totalAmount,
      required this.quantity});
  final String title;
  final String imageSource;
  final int totalAmount;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          imageSource,
          fit: BoxFit.cover,
          height: 1000,
          width: 100,
        ),
      ),
      title: Text(title, style: Theme.of(context).textTheme.headlineLarge),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Text(
          "${totalAmount} VNĐ",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).colorScheme.primary),
        ),
        child: Text(
          "${quantity}x",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
