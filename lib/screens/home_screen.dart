import 'package:final_project/providers/category_data.dart';
import 'package:final_project/providers/food_data.dart';
import 'package:final_project/screens/cart_screen.dart';
import 'package:final_project/utils/colors.dart';
import 'package:final_project/utils/functions.dart';
import 'package:final_project/utils/widgets.dart';
import 'package:final_project/widgets/product_item.dart';
import 'package:final_project/widgets/product_promo_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      leading: const CircleAvatar(
        child: Text("Hello"),
      ),
      leadingWidth: 100,
      titleSpacing: 0,
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Delivery to",
            style: TextStyle(fontSize: 16, color: AppColors.grey02),
          ),
          Text(
            "Times Square",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ],
      ),
      actions: [
        Row(
          children: [
            InkWell(
              onTap: () {},
              customBorder: const CircleBorder(),
              child: Container(
                width: 46.0,
                height: 46.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.grey01,
                    width: 1.0,
                  ),
                ),
                child: const Center(
                  child: Badge(
                    label: Text("1"),
                    child: Icon(Icons.notifications_none_sharp,
                        color: AppColors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            InkWell(
              onTap: () => navigation(context, CartScreen.routeName),
              customBorder: const CircleBorder(),
              child: Container(
                width: 46.0,
                height: 46.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.grey01,
                    width: 1.0,
                  ),
                ),
                child: const Center(
                  child: Badge(
                    label: Text("1"),
                    child: Icon(Icons.shopping_bag_outlined,
                        color: AppColors.black),
                  ),
                ),
              ),
            ),
            BoxEmpty.sizeBox20,
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final foodData = Provider.of<FoodData>(context, listen: false);
    final foods = foodData.foods;
    final categoryData = Provider.of<CategoryData>(context, listen: false);
    final categories = categoryData.categories;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: Colors.transparent,
                  width: 1.0,
                ),
                color: AppColors.lightGrey,
              ),
              // height: 45,
              child: const TextField(
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  hintText: 'Search', // Placeholder
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            BoxEmpty.sizeBox20,
            headerPartialContent("Special Offers", "See All"),
            BoxEmpty.sizeBox20,
            Container(
              height: 200,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
            ),
            BoxEmpty.sizeBox20,
            SizedBox(
              height: 200,
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 8,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 12 / 13,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final category = categories[index];
                  return GridTile(
                    child: categoryItem(
                        context, category.name, category.imageSource),
                    // child: categoryItem("Hamburger", ""),
                  );
                },
              ),
            ),
            BoxEmpty.sizeBox10,
            headerPartialContent("Discount Guaranteed", "See All"),
            BoxEmpty.sizeBox15,
            SizedBox(
              height: 250,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                separatorBuilder: (BuildContext context, int index) =>
                    BoxEmpty.sizeBox15,
                itemBuilder: (BuildContext context, int index) {
                  return const ProductPromoItem();
                },
              ),
            ),
            BoxEmpty.sizeBox20,
            headerPartialContent("Recommended For You", "See All"),
            BoxEmpty.sizeBox15,
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SizedBox(
                height: deviceSize.height * 0.7,
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemCount: foods.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      BoxEmpty.sizeBox15,
                  itemBuilder: (BuildContext context, int index) {
                    final food = foods[index];
                    return ProductItem(
                      id: food.id,
                      title: food.foodName,
                      image: food.imageSource,
                      price: food.price,
                      key: ValueKey<String>(food.id),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryItem(BuildContext context, String title, String image) {
    return InkWell(
      onTap: () {},
      child: SizedBox(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 60,
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
            BoxEmpty.sizeBox5,
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget headerPartialContent(String title, String trailing) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          trailing,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.green,
          ),
        ),
      ],
    );
  }
}
