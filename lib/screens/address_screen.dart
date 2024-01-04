import 'package:final_project/widgets/address_item.dart';
import 'package:final_project/widgets/bottom_widget.dart';
import 'package:final_project/widgets/common_button.dart';
import 'package:flutter/material.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});
  static const routeName = '/address-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          "Deliver to",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Column(
        children: [
          const Expanded(
            child: Padding(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
              child: Column(
                children: [
                  AddressItem(title: "Home", description: "ABC"),
                ],
              ),
            ),
          ),
          BottomWidget(
            child: CommonButton(title: "Apply", onPress: () {}),
          ),
        ],
      ),
    );
  }
}
