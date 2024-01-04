import 'package:final_project/providers/auth.dart';
import 'package:final_project/providers/cart_provider.dart';
import 'package:final_project/providers/category_data.dart';
import 'package:final_project/providers/food_data.dart';
import 'package:final_project/providers/order_provider.dart';
import 'package:final_project/providers/theme_provider.dart';
import 'package:final_project/screens/address_screen.dart';
import 'package:final_project/screens/auth_screen.dart';
import 'package:final_project/screens/cart_screen.dart';
import 'package:final_project/screens/checkout_screen.dart';
import 'package:final_project/screens/home_screen.dart';
import 'package:final_project/screens/main_screen.dart';
import 'package:final_project/screens/payment_screen.dart';
import 'package:final_project/screens/product_detail_screen.dart';
import 'package:final_project/screens/splash_screen.dart';
import 'package:final_project/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProvider(create: (ctx) => FoodData()),
        ChangeNotifierProvider(create: (ctx) => CategoryData()),
        ChangeNotifierProvider(create: (ctx) => ThemeProvider()),
        ChangeNotifierProvider(create: (ctx) => CartProvider()),
        ChangeNotifierProxyProvider<Auth, OrderProvider>(
          create: (context) => OrderProvider([], 0),
          update: (context, auth, previous) =>
              OrderProvider(previous == null ? [] : previous.myOrder, auth.id),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, child) => MaterialApp(
          title: 'Flutter Demo',
          theme: Provider.of<ThemeProvider>(context).themeData,
          home: auth.isAuth ? const SplashScreen() : const AuthScreen(),
          routes: {
            MainScreen.routeName: (context) => const MainScreen(),
            CartScreen.routeName: (context) => const CartScreen(),
            ProductDetailScreen.routeName: (context) =>
                const ProductDetailScreen(),
            CheckOutScreen.routeName: (context) => const CheckOutScreen(),
            PaymentScreen.routeName: (context) => const PaymentScreen(),
            AddressScreen.routeName: (context) => const AddressScreen(),
          },
        ),
      ),
    );
  }
}
