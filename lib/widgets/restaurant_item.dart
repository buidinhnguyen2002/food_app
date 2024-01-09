import 'package:final_project/providers/restaurant_provider.dart';
import 'package:final_project/screens/restaurant_detail.dart';
import 'package:final_project/utils/colors.dart';
import 'package:final_project/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantItem extends StatelessWidget {
  const RestaurantItem(
      {super.key,
      required this.name,
      required this.image,
      required this.description,
      required this.phoneNumber,
      required this.rate,
      required this.id});
  final String id;
  final String name;
  final String image;
  final String description;
  final String phoneNumber;
  final double rate;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(RestaurantDetail.routeName, arguments: {"id": id});
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Theme.of(context).colorScheme.surface),
        child: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              image,
              width: 120,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          BoxEmpty.sizeBox15,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                BoxEmpty.sizeBox10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.delivery_dining,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    BoxEmpty.sizeBox10,
                    Text('|'),
                    BoxEmpty.sizeBox10,
                    const Icon(
                      Icons.star,
                      size: 18,
                      color: AppColors.orange,
                    ),
                    Text(
                      rate.toString(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
                BoxEmpty.sizeBox10,
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    phoneNumber,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
