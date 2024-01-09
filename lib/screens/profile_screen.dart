import 'package:final_project/providers/auth.dart';
import 'package:final_project/providers/locale_provider.dart';
import 'package:final_project/providers/theme_provider.dart';
import 'package:final_project/screens/cart_screen.dart';
import 'package:final_project/screens/language_screen.dart';
import 'package:final_project/utils/colors.dart';
import 'package:final_project/utils/constants.dart';
import 'package:final_project/utils/functions.dart';
import 'package:final_project/utils/widgets.dart';
import 'package:final_project/widgets/profile_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final avatar = Provider.of<Auth>(context).avatar;
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 20),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(avatar),
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
            // title: "My Favorite Restaurants",
            title: AppLocalizations.of(context)!.my_favorite_restaurant,
            icon: Icons.list_alt,
            onPress: () {},
          ),
          ProfileItem(
            title: AppLocalizations.of(context)!.label_payment_methods,
            icon: Icons.payment_outlined,
            onPress: () {},
          ),
          Divider(
            height: 1,
            color: Theme.of(context).dividerColor,
          ),
          ProfileItem(
            title: AppLocalizations.of(context)!.label_address,
            icon: Icons.location_on_outlined,
            onPress: () {},
          ),
          ProfileItem(
            icon: Icons.language,
            title: AppLocalizations.of(context)!.label_language,
            onPress: () {},
            widgetTrailing: SizedBox(
              width: 200,
              child: Row(
                children: [
                  const Expanded(child: SizedBox()),
                  Text(
                    AppLocalizations.of(context)!.label_sub_language,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  BoxEmpty.sizeBox10,
                  IconButton(
                    onPressed: () {
                      // Provider.of<Auth>(context, listen: false)
                      //     .changeLocale(Locale('en'));
                      navigation(context, LanguageScreen.routeName);
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ProfileItem(
            title: AppLocalizations.of(context)!.label_mode_them,
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
