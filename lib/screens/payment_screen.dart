import 'package:final_project/providers/order_provider.dart';
import 'package:final_project/utils/constants.dart';
import 'package:final_project/utils/functions.dart';
import 'package:final_project/utils/widgets.dart';
import 'package:final_project/widgets/bottom_widget.dart';
import 'package:final_project/widgets/common_button.dart';
import 'package:final_project/widgets/payment_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});
  static const routeName = '/payments';

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isChecked = false;
  int _selectedPayments = 0;
  @override
  void initState() {
    super.initState();
    _selectedPayments =
        Provider.of<OrderProvider>(context, listen: false).selectedPayment;
  }

  void changePayments(int i) {
    setState(() {
      _selectedPayments = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    final payments = orderProvider.payments;
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
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
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final payment = payments[index];
                        return PaymentItem(
                            changePayment: changePayments,
                            value: payment.value,
                            title: payment.name,
                            logo: payment.logo,
                            selectedPayment: _selectedPayments,
                            width: payment.widthIcon);
                      },
                      itemCount: payments.length,
                    ),
                  ),
                  CommonButton(
                      title: "Add New Card",
                      onPress: () {},
                      backgroundColor: const Color.fromARGB(29, 25, 153, 68),
                      textColor: Theme.of(context).colorScheme.primary),
                ],
              ),
            ),
          ),
          BottomWidget(
            child: CommonButton(
                title: "Apply",
                onPress: () {
                  orderProvider.selectedPayment = _selectedPayments;
                  showNotification(context, "Apply payment successful");
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
