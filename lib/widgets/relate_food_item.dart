import 'package:final_project/screens/product_detail_screen.dart';
import 'package:final_project/utils/colors.dart';
import 'package:final_project/utils/widgets.dart';
import 'package:flutter/material.dart';

class RelateFoodItem extends StatelessWidget {
  const RelateFoodItem(
      {super.key,
      required this.imgaeSource,
      required this.title,
      required this.price,
      required this.id});
  final String id;
  final String imgaeSource;
  final String title;
  final double price;
  void navigateToProductDetail(BuildContext context, String proId) {
    Navigator.of(context)
        .pushNamed(ProductDetailScreen.routeName, arguments: {"id": proId});
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        navigateToProductDetail(context, id);
      },
      radius: 50,
      child: Container(
        width: (deviceSize.width) * 0.7 - 40,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 120,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      imgaeSource,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            BoxEmpty.sizeBox10,
            Text(
              title,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            BoxEmpty.sizeBox5,
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
            BoxEmpty.sizeBox5,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "${price.toInt()} VNĐ",
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
