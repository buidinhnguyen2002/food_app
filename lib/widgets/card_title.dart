import 'package:final_project/utils/widgets.dart';
import 'package:flutter/material.dart';

class CardTitle extends StatelessWidget {
  const CardTitle(
      {super.key,
      required this.child,
      required this.title,
      this.restaurantName});
  final String title;
  final Widget child;
  final String? restaurantName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              if (restaurantName != null)
                Text(
                  restaurantName!,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
            ],
          ),
          BoxEmpty.sizeBox10,
          child,
        ],
      ),
    );
  }
}
