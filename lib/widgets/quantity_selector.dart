import 'package:final_project/utils/widgets.dart';
import 'package:flutter/material.dart';

class QuantitySelector extends StatelessWidget {
  const QuantitySelector(
      {super.key,
      required this.quantity,
      required this.increaseQuantity,
      required this.decreaseQuantity});
  final quantity;
  final VoidCallback increaseQuantity;
  final VoidCallback decreaseQuantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        quantityButton(context, Icons.remove, decreaseQuantity),
        BoxEmpty.sizeBox10,
        Text(
          '$quantity',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        BoxEmpty.sizeBox10,
        quantityButton(context, Icons.add, increaseQuantity),
      ],
    );
  }

  Widget quantityButton(
    BuildContext context,
    IconData icon,
    VoidCallback onPress,
  ) {
    return InkWell(
      onTap: onPress,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        child: Center(
          child: Icon(
            // Icons.remove,
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 16,
          ),
        ),
      ),
    );
  }
}
