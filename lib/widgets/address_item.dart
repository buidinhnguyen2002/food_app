import 'package:final_project/utils/widgets.dart';
import 'package:flutter/material.dart';

class AddressItem extends StatefulWidget {
  const AddressItem(
      {super.key, required this.title, required this.description});
  final String title;
  final String description;

  @override
  State<AddressItem> createState() => _AddressItemState();
}

class _AddressItemState extends State<AddressItem> {
  int _selectedAddress = 0;

  void changePayments(int i) {
    setState(() {
      _selectedAddress = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: const CircleAvatar(
        radius: 30,
        backgroundColor: Color.fromARGB(29, 25, 153, 68),
        child: CircleAvatar(
          child: Icon(Icons.location_pin),
        ),
      ),
      title: Row(
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          BoxEmpty.sizeBox10,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              color: Color.fromARGB(29, 25, 153, 68),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              "Defauld",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primaryContainer,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 7),
        child: Text(
          widget.description,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      trailing: Radio(
        value: 1,
        groupValue: _selectedAddress,
        onChanged: (value) => changePayments(value!),
        fillColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return Theme.of(context).colorScheme.primary;
            }
            return Theme.of(context).colorScheme.primary;
          },
        ),
      ),
    );
  }
}
