import 'package:final_project/screens/edit_address_screen.dart';
import 'package:final_project/utils/functions.dart';
import 'package:final_project/utils/widgets.dart';
import 'package:flutter/material.dart';

class AddressItem extends StatelessWidget {
  const AddressItem(
      {super.key,
      required this.title,
      required this.description,
      required this.id,
      required this.value,
      required this.selectedAddress,
      required this.changeAddress,
      required this.isDefault});
  final String id;
  final String title;
  final String description;
  final int value;
  final int selectedAddress;
  final Function(int) changeAddress;
  final bool isDefault;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(25),
      ),
      child: ListTile(
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
            Container(
              constraints: const BoxConstraints(maxWidth: 90),
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            BoxEmpty.sizeBox10,
            isDefault
                ? Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
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
                  )
                : const SizedBox(),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 7),
          child: Text(
            description,
            style: Theme.of(context).textTheme.headlineSmall,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(EditAddressScreen.routeName,
                      arguments: {"id": id});
                },
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Radio(
                value: value,
                groupValue: selectedAddress,
                onChanged: (value) => changeAddress(value!),
                fillColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return Theme.of(context).colorScheme.primary;
                    }
                    return Theme.of(context).colorScheme.primary;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
