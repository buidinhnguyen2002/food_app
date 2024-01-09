import 'package:final_project/screens/rate_and_review_screen.dart';
import 'package:final_project/utils/colors.dart';
import 'package:final_project/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class RatingOverview extends StatelessWidget {
  const RatingOverview({super.key, required this.onPress});
  final VoidCallback onPress;
  Widget rateChart(BuildContext context, int rate) {
    return Row(
      children: [
        Text(
          rate.toString(),
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        BoxEmpty.sizeBox5,
        Expanded(
          child: Container(
            height: 5,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "4.8",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              // BoxEmpty.sizeBox5,
              SmoothStarRating(
                color: AppColors.yellow,
                rating: 4.5,
                borderColor: AppColors.yellow,
                allowHalfRating: false,
                halfFilledIconData: Icons.star_half_rounded,
                defaultIconData: Icons.star_border_rounded,
                filledIconData: Icons.star_rounded,
                starCount: 5,
                size: 22,
                spacing: 2,
              ),
              // BoxEmpty.sizeBox5,
              Text(
                "(4.8k reviews)",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
          Expanded(
            flex: 0,
            child: Container(
              width: 2,
              height: 120,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                rateChart(context, 5),
                BoxEmpty.sizeBox5,
                rateChart(context, 4),
                BoxEmpty.sizeBox5,
                rateChart(context, 3),
                BoxEmpty.sizeBox5,
                rateChart(context, 2),
                BoxEmpty.sizeBox5,
                rateChart(context, 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
