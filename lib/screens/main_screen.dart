import 'package:final_project/providers/food_data.dart';
import 'package:final_project/screens/cart_screen.dart';
import 'package:final_project/screens/home_screen.dart';
import 'package:final_project/screens/order_screen.dart';
import 'package:final_project/screens/profile_screen.dart';
import 'package:final_project/screens/restaurant_screen.dart';
import 'package:final_project/utils/app_bar.dart';
import 'package:final_project/utils/colors.dart';
import 'package:final_project/utils/functions.dart';
import 'package:final_project/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static const routeName = '/main';
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
  }

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
      case 2:
        return const RestaurantScreen();
      case 3:
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
        return mainAppBar(context, AppLocalizations.of(context)!.order);
      case 2:
        return mainAppBar(
            context, AppLocalizations.of(context)!.label_restaurant);
      case 3:
        return mainAppBar(context, AppLocalizations.of(context)!.label_profile);
      default:
    }
    return AppBar();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final index = args?['index'];
    if (index != null) {
      setState(() {
        _selectedPageIndex = index;
      });
    } else {
      setState(() {
        _selectedPageIndex = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: getAppBar(context),
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: AppLocalizations.of(context)!.home),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_rounded),
              label: AppLocalizations.of(context)!.order),
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant),
              label: AppLocalizations.of(context)!.label_restaurant),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.payment),
          //     label: AppLocalizations.of(context)!.label_wallet),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_pin_outlined),
              label: AppLocalizations.of(context)!.label_profile),
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
