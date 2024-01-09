import 'package:final_project/models/review.dart';
import 'package:final_project/providers/restaurant_provider.dart';
import 'package:final_project/providers/review_provider.dart';
import 'package:final_project/screens/rate_and_review_screen.dart';
import 'package:final_project/utils/colors.dart';
import 'package:final_project/utils/widgets.dart';
import 'package:final_project/widgets/custom_divider.dart';
import 'package:final_project/widgets/rating_overview.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class RestaurantReviewScreen extends StatelessWidget {
  const RestaurantReviewScreen({super.key});
  static const routeName = '/restaurant-review';
  void navigateToRateAndReview(BuildContext context, String resId) {
    Navigator.of(context)
        .pushNamed(RateAndReviewScreen.routeName, arguments: {"id": resId});
  }

  static const LatLng location = LatLng(10.871466531373942, 106.79217337116337);

  @override
  Widget build(BuildContext context) {
    final restaurantProvider =
        Provider.of<ReviewProvider>(context, listen: false);
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final id = args?['id'];
    final reviews = restaurantProvider.getReviewByRestaurantId(id);
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Big Garden",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            BoxEmpty.sizeBox10,
            const CustomDivider(),
            BoxEmpty.sizeBox10,
            RatingOverview(
              onPress: () => navigateToRateAndReview(context, id),
            ),
            BoxEmpty.sizeBox10,
            const CustomDivider(),
            BoxEmpty.sizeBox20,
            Text(
              "Overview",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            BoxEmpty.sizeBox10,
            Text(
              "ABC",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Monday - Friday",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Text(
                      "Saturyday - Sunday",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),
                BoxEmpty.sizeBox15,
                Column(
                  children: [
                    Text(
                      ":",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Text(
                      ":",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),
                BoxEmpty.sizeBox15,
                Column(
                  children: [
                    Text(
                      "10:00 - 22:00",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "12:00 - 20:00",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            BoxEmpty.sizeBox20,
            const CustomDivider(),
            BoxEmpty.sizeBox20,
            Text(
              "Address",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            BoxEmpty.sizeBox10,
            Expanded(
              child: GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: location,
                  zoom: 17,
                ),
                markers: {
                  const Marker(
                    markerId: MarkerId("location"),
                    position: location,
                  )
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
