import 'package:final_project/screens/product_detail_screen.dart';
import 'package:final_project/utils/widgets.dart';
import 'package:flutter/material.dart';

class MenuRestaurantItem extends StatelessWidget {
  const MenuRestaurantItem(
      {super.key,
      required this.name,
      required this.id,
      required this.price,
      required this.imageSource});
  final String name;
  final String id;
  final double price;
  final String imageSource;
  void navigateToProductDetail(BuildContext context, String proId) {
    Navigator.of(context)
        .pushNamed(ProductDetailScreen.routeName, arguments: {"id": proId});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateToProductDetail(context, id);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(
          bottom: 10,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            SizedBox(
              height: 100,
              width: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  imageSource,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            BoxEmpty.sizeBox10,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  BoxEmpty.sizeBox5,
                  Text(
                    '$price VNĐ',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
