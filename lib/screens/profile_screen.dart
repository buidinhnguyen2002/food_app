import 'package:final_project/providers/theme_provider.dart';
import 'package:final_project/screens/cart_screen.dart';
import 'package:final_project/utils/colors.dart';
import 'package:final_project/utils/constants.dart';
import 'package:final_project/utils/functions.dart';
import 'package:final_project/utils/widgets.dart';
import 'package:final_project/widgets/profile_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _lights = false;
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final themeData = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 20),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            leading: const CircleAvatar(
              child: Text("Hello"),
              radius: 30,
            ),
            title: Text(
              "Bui Dinh Nguyen",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            subtitle: Text(
              "0376681323",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.primary,
                )),
          ),
          BoxEmpty.sizeBox15,
          Divider(
            height: 1,
            color: Theme.of(context).dividerColor,
          ),
          ProfileItem(
            title: "My Favorite Restaurants",
            icon: Icons.list_alt,
            onPress: () {},
          ),
          ProfileItem(
            title: "Payment Methods",
            icon: Icons.payment_outlined,
            onPress: () {},
          ),
          Divider(
            height: 1,
            color: Theme.of(context).dividerColor,
          ),
          ProfileItem(
            title: "Address",
            icon: Icons.location_on_outlined,
            onPress: () {},
          ),
          ProfileItem(
            title: "Dark Mode",
            icon: Icons.dark_mode_outlined,
            onPress: () {},
            widgetTrailing: CupertinoSwitch(
              value: _lights,
              onChanged: (value) {
                setState(() {
                  _lights = value;
                });
                themeData.toggleTheme();
              },
            ),
          ),
        ],
      ),
    );
  }
}
