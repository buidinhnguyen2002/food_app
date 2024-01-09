import 'package:final_project/models/food.dart';
import 'package:final_project/providers/auth.dart';
import 'package:final_project/providers/cart_provider.dart';
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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static AppBar appBar(BuildContext context) {
    final avatar = Provider.of<Auth>(context).avatar;
    final cartCount = Provider.of<CartProvider>(context).itemCount;
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(avatar),
      ),
      leadingWidth: 100,
      titleSpacing: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocalizations.of(context)!.label_delivery_to,
            style: TextStyle(fontSize: 16, color: AppColors.grey02),
          ),
          Text(
            "Times Square",
            style: Theme.of(context).textTheme.headlineLarge,
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
                    color: Theme.of(context).colorScheme.tertiary,
                    width: 0.5,
                  ),
                ),
                child: Center(
                  child: Badge(
                    label: Text("1"),
                    child: Icon(
                      Icons.notifications_none_sharp,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
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
                    width: 0.5,
                  ),
                ),
                child: Center(
                  child: Badge(
                    label: Text(cartCount.toString()),
                    child: Icon(
                      Icons.shopping_bag_outlined,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
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
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Food> filterFood = [];
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final foodData = Provider.of<FoodData>(context, listen: false);
    final foods = foodData.foods;

    final categoryData = Provider.of<CategoryData>(context, listen: false);
    final categories = categoryData.categories;
    return SingleChildScrollView(
      child: Stack(
        children: [
          Padding(
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
                    // color: AppColors.lightGrey,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  // height: 45,
                  child: TextField(
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!
                          .label_search, // Placeholder
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).colorScheme.tertiary,
                        size: 25,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        filterFood = foodData.getFoodBySearch(value);
                      });
                    },
                  ),
                ),
                BoxEmpty.sizeBox20,
                headerPartialContent(
                    AppLocalizations.of(context)!.label_special_offers,
                    AppLocalizations.of(context)!.label_see_all),
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
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 8,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                headerPartialContent(
                    AppLocalizations.of(context)!.label_discount_guaranteed,
                    AppLocalizations.of(context)!.label_see_all),
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
                headerPartialContent(
                    AppLocalizations.of(context)!.label_recommended,
                    AppLocalizations.of(context)!.label_see_all),
                BoxEmpty.sizeBox15,
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SizedBox(
                    height: deviceSize.height * 0.7,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: foods.length,
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
          if (filterFood.isNotEmpty)
            Positioned(
              left: 10,
              top: 90,
              child: Container(
                height: deviceSize.height - 180,
                width: deviceSize.width - 20,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 240, 240, 240),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    if (filterFood.isEmpty) {
                      return const SizedBox(
                        width: 0,
                        height: 0,
                      );
                    }
                    final food = filterFood[index];
                    return ProductItem(
                        id: food.id,
                        image: food.imageSource,
                        price: food.price,
                        title: food.foodName);
                  },
                  itemCount: filterFood.length,
                ),
              ),
            ),
        ],
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
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onBackground,
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
