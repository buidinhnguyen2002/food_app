import 'package:final_project/utils/colors.dart';
import 'package:final_project/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem(
      {super.key,
      required this.message,
      required this.rate,
      required this.avatar,
      required this.fullName});
  final String message;
  final double rate;
  final String avatar;
  final String fullName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      // padding: EdgeInsets.all(10),
      // decoration: BoxDecoration(
      //   color: Theme.of(context).colorScheme.surface,
      //   borderRadius: BorderRadius.circular(25),
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(avatar),
                      radius: 30,
                    ),
                    BoxEmpty.sizeBox10,
                    Text(
                      fullName,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),
              ),
              SmoothStarRating(
                color: AppColors.yellow,
                borderColor: AppColors.yellow,
                size: 18,
                rating: rate,
                allowHalfRating: false,
                starCount: 5,
              ),
            ],
          ),
          BoxEmpty.sizeBox10,
          Text(
            message,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          BoxEmpty.sizeBox10,
          Row(
            children: [
              InkWell(
                onTap: () {},
                child: Icon(
                  Icons.favorite_outline,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
              BoxEmpty.sizeBox10,
              Text(
                "938",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              BoxEmpty.sizeBox20,
              Text(
                "6 days ago",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
