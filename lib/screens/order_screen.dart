import 'package:final_project/providers/order_provider.dart';
import 'package:final_project/screens/order_tracking_screen.dart';
import 'package:final_project/utils/functions.dart';
import 'package:final_project/utils/widgets.dart';
import 'package:final_project/widgets/card_order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    final activeOrder = orderProvider.activeOrder;
    final cancelOrder = orderProvider.cancelOrder;
    final completedOrder = orderProvider.completeOrder;
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: AppLocalizations.of(context)!.label_order_active),
                Tab(text: AppLocalizations.of(context)!.label_order_completed),
                Tab(text: AppLocalizations.of(context)!.label_order_cancelled),
              ],
              unselectedLabelColor: Theme.of(context).colorScheme.tertiary,
              labelStyle: Theme.of(context).textTheme.headlineLarge,
            ),
            BoxEmpty.sizeBox20,
            Expanded(
              child: TabBarView(
                children: [
                  ListView.builder(
                      itemCount: activeOrder.length,
                      itemBuilder: (context, index) {
                        final order = activeOrder[index];
                        return CardOrderItem(
                          quantity: order.quantityItem,
                          title: order.name,
                          totalAmount: order.totalAmount,
                          status: order.isPaid
                              ? AppLocalizations.of(context)!
                                  .label_order_status_pay_paid
                              : AppLocalizations.of(context)!
                                  .label_order_status_pay_unpaid,
                          imageSource: order.image,
                          labelButtonLeft: AppLocalizations.of(context)!
                              .button_order_cancelled,
                          labelButtonRight: AppLocalizations.of(context)!
                              .button_order_track_driver,
                          onPressButtonLeft: () =>
                              orderProvider.handleCancelOrder(order.id),
                          onPressButtonRight: () {
                            navigation(context, OrderTrackingScreen.routeName);
                          },
                        );
                      }),
                  ListView.builder(
                      itemCount: completedOrder.length,
                      itemBuilder: (context, index) {
                        final order = completedOrder[index];
                        return CardOrderItem(
                          quantity: order.quantityItem,
                          title: order.name,
                          totalAmount: order.totalAmount,
                          status: order.status,
                          imageSource: order.image,
                          labelButtonLeft: "Leave a Review",
                          labelButtonRight: "Order Again",
                          onPressButtonLeft: () {},
                        );
                      }),
                  ListView.builder(
                      itemCount: cancelOrder.length,
                      itemBuilder: (context, index) {
                        final order = cancelOrder[index];
                        return CardOrderItem(
                          quantity: order.quantityItem,
                          title: order.name,
                          totalAmount: order.totalAmount,
                          // status: order.status,
                          status: order.status,
                          imageSource: order.image,
                          labelButtonLeft: "Leave a Review",
                          labelButtonRight: "Order Again",
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
