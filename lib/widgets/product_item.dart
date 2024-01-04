import 'package:final_project/screens/product_detail_screen.dart';
import 'package:final_project/utils/colors.dart';
import 'package:final_project/utils/widgets.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(
      {super.key,
      required this.id,
      required this.image,
      required this.price,
      required this.title});
  final String id;
  final String title;
  final double price;
  final String image;

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
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                    width: (deviceSize.width - 40 - 15 * 2) * 0.4,
                    height: 120,
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        }
                      },
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Text('Image failed to load');
                      },
                    ),
                  ),
                ),
              ],
            ),
            BoxEmpty.sizeBox10,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  BoxEmpty.sizeBox10,
                  Row(
                    children: [
                      Text(
                        "1.5km",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      BoxEmpty.sizeBox5,
                      Text(
                        "|",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      BoxEmpty.sizeBox5,
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
                            "${price.toStringAsFixed(0)} VNĐ",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          BoxEmpty.sizeBox5,
                          Text(
                            "|",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                              fontSize: 10,
                            ),
                          ),
                          BoxEmpty.sizeBox5,
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
          ],
        ),
      ),
    );
  }
}
