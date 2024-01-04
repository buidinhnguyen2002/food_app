import 'package:final_project/utils/widgets.dart';
import 'package:final_project/widgets/bottom_widget.dart';
import 'package:final_project/widgets/common_button.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});
  static const routeName = '/payments';

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isChecked = false;
  int _selectedPayments = 0;
  void changePayments(int i) {
    setState(() {
      _selectedPayments = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          "Payment Methods",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.qr_code_scanner_sharp))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      leading: Icon(Icons.paypal),
                      title: Text(
                        "PayPal",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      trailing: Radio(
                        value: 1,
                        groupValue: _selectedPayments,
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
                    ),
                  ),
                  BoxEmpty.sizeBox20,
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      leading: Icon(Icons.paypal),
                      title: Text("PayPal"),
                      trailing: Radio(
                        value: 2,
                        groupValue: _selectedPayments,
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
                    ),
                  ),
                  BoxEmpty.sizeBox20,
                  CommonButton(
                      title: "Add New Card",
                      onPress: () {},
                      backgroundColor: Color.fromARGB(29, 25, 153, 68),
                      textColor: Theme.of(context).colorScheme.primary),
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
