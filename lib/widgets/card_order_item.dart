import 'package:final_project/utils/colors.dart';
import 'package:final_project/utils/widgets.dart';
import 'package:final_project/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class CardOrderItem extends StatelessWidget {
  const CardOrderItem({
    super.key,
    required this.title,
    required this.quantity,
    required this.totalAmount,
    required this.status,
    required this.imageSource,
    required this.labelButtonLeft,
    required this.labelButtonRight,
    this.onPressButtonLeft,
    this.onPressButtonRight,
  });
  final String title;
  final int quantity;
  final double totalAmount;
  final String status;
  final String imageSource;
  final String labelButtonLeft;
  final String labelButtonRight;
  final Function? onPressButtonLeft;
  final Function? onPressButtonRight;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(10),
      // height: 210,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  width: (deviceSize.width - 40 - 15 * 2) * 0.4 - 10,
                  height: 100,
                  child: Image.network(
                    imageSource,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              BoxEmpty.sizeBox15,
              Expanded(
                child: Container(
                  height: 100,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.headlineLarge,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                      Row(
                        children: [
                          Text(
                            "$quantity ${AppLocalizations.of(context)!.label_items}",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          BoxEmpty.sizeBox5,
                          Text(
                            "|",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          BoxEmpty.sizeBox5,
                          Text(
                            "2.4 km",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${totalAmount.toInt()} VNĐ",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              BoxEmpty.sizeBox10,
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: status != 'cancelled'
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(7),
                                    border: Border.all(
                                        color: status != 'cancelled'
                                            ? Theme.of(context)
                                                .colorScheme
                                                .onPrimary
                                            : Theme.of(context)
                                                .colorScheme
                                                .error)),
                                child: Text(
                                  status.toLowerCase(),
                                  style: TextStyle(
                                      color: status != 'cancelled'
                                          ? Theme.of(context)
                                              .colorScheme
                                              .onPrimary
                                          : Theme.of(context).colorScheme.error,
                                      fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (status != 'cancelled') BoxEmpty.sizeBox10,
          if (status != 'cancelled')
            Divider(
              height: 1,
              color: Theme.of(context).dividerColor,
            ),
          if (status != 'cancelled') BoxEmpty.sizeBox5,
          if (status != 'cancelled')
            Row(
              children: [
                Expanded(
                  child: CommonButton(
                    title: labelButtonLeft,
                    onPress: onPressButtonLeft as Function(),
                    paddingVertical: 8,
                    backgroundColor: Colors.transparent,
                    textColor: Theme.of(context).colorScheme.primary,
                    borderColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
                BoxEmpty.sizeBox15,
                Expanded(
                  child: CommonButton(
                    title: labelButtonRight,
                    onPress: onPressButtonRight != null
                        ? onPressButtonRight as Function()
                        : () {},
                    paddingVertical: 8,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
