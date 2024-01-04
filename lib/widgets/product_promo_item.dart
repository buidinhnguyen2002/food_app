import 'package:final_project/utils/colors.dart';
import 'package:final_project/utils/widgets.dart';
import 'package:flutter/material.dart';

class ProductPromoItem extends StatelessWidget {
  const ProductPromoItem({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {},
      radius: 50,
      child: Container(
        width: (deviceSize.width - 40) * 0.6,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    "https://static.vinwonders.com/production/mon-ngon-ha-dong-banner.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      "Promo",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            BoxEmpty.sizeBox10,
            Text(
              "Mixed Salad Bonb",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            BoxEmpty.sizeBox10,
            Row(
              children: [
                Text(
                  "1.5km",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                BoxEmpty.sizeBox10,
                Text(
                  "|",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                BoxEmpty.sizeBox10,
                const Icon(
                  Icons.star,
                  color: Color.fromARGB(255, 243, 226, 77),
                ),
                BoxEmpty.sizeBox5,
                Text(
                  "4.8",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            BoxEmpty.sizeBox10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "\$6.00",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    BoxEmpty.sizeBox10,
                    Text(
                      "|",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 10,
                      ),
                    ),
                    BoxEmpty.sizeBox10,
                    Icon(
                      Icons.pedal_bike_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    BoxEmpty.sizeBox5,
                    Text(
                      "\$2.00",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
                const Icon(
                  Icons.favorite_border,
                  color: AppColors.red,
                  size: 18,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
