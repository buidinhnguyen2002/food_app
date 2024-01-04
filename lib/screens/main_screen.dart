import 'package:final_project/providers/food_data.dart';
import 'package:final_project/screens/cart_screen.dart';
import 'package:final_project/screens/home_screen.dart';
import 'package:final_project/screens/order_screen.dart';
import 'package:final_project/screens/profile_screen.dart';
import 'package:final_project/utils/app_bar.dart';
import 'package:final_project/utils/colors.dart';
import 'package:final_project/utils/functions.dart';
import 'package:final_project/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static const routeName = '/main';
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Widget getBody() {
    switch (_selectedPageIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const OrderScreen();
      case 4:
        return const ProfileScreen();
      default:
    }
    return Container();
  }

  AppBar getAppBar(BuildContext context) {
    switch (_selectedPageIndex) {
      case 0:
        return HomeScreen.appBar(context);
      case 1:
        return mainAppBar(context, "Orders");
      case 2:
        return mainAppBar(context, "Restaurant");
      case 4:
        return mainAppBar(context, "Profile");
      default:
    }
    return AppBar();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    // Provider.of<FoodData>(context).fetchAndSetFood();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: getAppBar(context),
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_rounded), label: "Order"),
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant), label: "Restaurant"),
          BottomNavigationBarItem(icon: Icon(Icons.payment), label: "E-Wallet"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_pin_outlined), label: "Profile"),
        ],
        unselectedItemColor: Theme.of(context).colorScheme.onTertiary,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          setState(() {
            _selectedPageIndex = index;
          });
        },
      ),
    );
  }
}
