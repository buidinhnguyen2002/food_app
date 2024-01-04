import 'package:final_project/screens/cart_screen.dart';
import 'package:final_project/utils/colors.dart';
import 'package:final_project/utils/constants.dart';
import 'package:final_project/utils/functions.dart';
import 'package:final_project/utils/widgets.dart';
import 'package:flutter/material.dart';

AppBar mainAppBar(BuildContext context, String title) {
  return AppBar(
    backgroundColor: Theme.of(context).colorScheme.background,
    leading: Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Image.asset(AssetConstants.logo),
    ),
    leadingWidth: 50,
    titleSpacing: 15,
    title: Text(
      title,
      style: Theme.of(context).textTheme.titleMedium,
    ),
  );
}
