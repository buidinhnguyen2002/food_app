import 'package:final_project/utils/constants.dart';
import 'package:final_project/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NotificationDialog extends StatelessWidget {
  const NotificationDialog({super.key, required this.content});
  final String content;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(15),
      backgroundColor: Theme.of(context).colorScheme.background,
      content: SizedBox(
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(AssetConstants.animationTick, width: 100),
            BoxEmpty.sizeBox10,
            Text(
              content,
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
    ;
  }
}
