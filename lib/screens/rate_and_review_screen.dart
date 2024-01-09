// ignore_for_file: use_build_context_synchronously

import 'package:final_project/providers/auth.dart';
import 'package:final_project/providers/review_provider.dart';
import 'package:final_project/utils/colors.dart';
import 'package:final_project/utils/constants.dart';
import 'package:final_project/utils/widgets.dart';
import 'package:final_project/widgets/bottom_widget.dart';
import 'package:final_project/widgets/common_button.dart';
import 'package:final_project/widgets/custom_divider.dart';
import 'package:final_project/widgets/notification_dialog.dart';
import 'package:final_project/widgets/rating_overview.dart';
import 'package:final_project/widgets/review_item.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class RateAndReviewScreen extends StatefulWidget {
  const RateAndReviewScreen({super.key});
  static const routeName = '/rate-and-review';

  @override
  State<RateAndReviewScreen> createState() => _RateAndReviewScreenState();
}

class _RateAndReviewScreenState extends State<RateAndReviewScreen> {
  double rate = 5;
  TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final reviewProvider = Provider.of<ReviewProvider>(context);
    final cusId = Provider.of<Auth>(context).id;
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final id = args?['id'];
    final reviews = reviewProvider.getReviewByRestaurantId(id);
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          "Rating & Reviews",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 20, top: 20),
              child: Column(
                children: [
                  const CustomDivider(),
                  BoxEmpty.sizeBox15,
                  RatingOverview(onPress: () {}),
                  BoxEmpty.sizeBox15,
                  const CustomDivider(),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        if (reviews.isEmpty) return SizedBox();
                        final review = reviews[index];
                        return ReviewItem(
                          message: review.message,
                          rate: review.rate,
                          avatar: review.avatarCustomer,
                          fullName: review.fullNameCustomer,
                        );
                      },
                      itemCount: reviews.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
          BottomWidget(
            child: Column(
              children: [
                SmoothStarRating(
                  color: AppColors.yellow,
                  borderColor: AppColors.yellow,
                  onRatingChanged: (rating) {
                    setState(() {
                      rate = rating;
                    });
                  },
                  rating: rate,
                ),
                BoxEmpty.sizeBox10,
                TextFormField(
                  maxLines: 2,
                  decoration: InputDecoration(
                      hintText: 'Enter your review here...',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      hintStyle: Theme.of(context).textTheme.headlineMedium),
                  controller: commentController,
                ),
                BoxEmpty.sizeBox10,
                CommonButton(
                  title: "Submit",
                  onPress: () async {
                    bool status = await reviewProvider.addReview(
                        id, cusId.toString(), commentController.text);
                    if (status) {
                      commentController.text = "";
                      showDialog(
                        context: context,
                        builder: (BuildContext ctx) {
                          Future.delayed(
                            const Duration(seconds: 2),
                            () {
                              Navigator.of(ctx).pop(true);
                            },
                          );
                          return NotificationDialog(
                              content: "Review successful!");
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
