import 'package:final_project/utils/constants.dart';
import 'package:flutter/material.dart';

class PaymentItem extends StatelessWidget {
  const PaymentItem(
      {super.key,
      required this.changePayment,
      required this.value,
      required this.title,
      required this.logo,
      required this.selectedPayment,
      required this.width});
  final Function(int) changePayment;
  final int value;
  final String title;
  final String logo;
  final int selectedPayment;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(25),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: Image.asset(
          logo,
          fit: BoxFit.cover,
          width: width,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        trailing: Radio(
          value: value,
          groupValue: selectedPayment,
          onChanged: (value) => changePayment(value!),
          fillColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return Theme.of(context).colorScheme.primary;
              }
              return Theme.of(context).colorScheme.primary;
            },
          ),
        ),
      ),
    );
  }
}
