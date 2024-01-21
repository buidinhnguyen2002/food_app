import 'package:final_project/providers/address_provider.dart';
import 'package:final_project/screens/edit_address_screen.dart';
import 'package:final_project/utils/functions.dart';
import 'package:final_project/utils/widgets.dart';
import 'package:final_project/widgets/address_item.dart';
import 'package:final_project/widgets/bottom_widget.dart';
import 'package:final_project/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});
  static const routeName = '/address-screen';

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  int _selectedAddress = 0;

  void changeAddress(int i) {
    setState(() {
      _selectedAddress = i;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selectedAddress = Provider.of<AddressProvider>(context).selectedAddress;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<AddressProvider>(context);
    final address = addressProvider.address;
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          "Deliver to",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          IconButton(
            onPressed: () {
              navigation(context, EditAddressScreen.routeName);
            },
            icon: Icon(Icons.add),
          ),
          BoxEmpty.sizeBox20,
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final ad = address[index];
                  return AddressItem(
                    id: ad.id,
                    title: ad.name,
                    description: ad.address,
                    value: index,
                    changeAddress: changeAddress,
                    selectedAddress: _selectedAddress,
                    isDefault: _selectedAddress == index,
                  );
                },
                itemCount: address.length,
              ),
            ),
          ),
          BottomWidget(
            child: CommonButton(
                title: "Apply",
                onPress: () {
                  addressProvider.selectedAddress = _selectedAddress;
                  showNotification(context, "Apply address successful");
                  Future.delayed(
                    const Duration(seconds: 1, milliseconds: 50),
                    () => Navigator.pop(context),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
