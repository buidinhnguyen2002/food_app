import 'dart:async';

import 'package:final_project/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key});
  static const routeName = "/order-tracking";
  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  // static const LatLng sourceLocation =
  //     LatLng(10.830859630518859, 106.77497753778339);
  // static const LatLng destination =
  //     LatLng(10.871487115000587, 106.79176169545593);
  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);
  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;
  void getCurrentLocation() {
    Location location = Location();
    location.getLocation().then((location) {
      setState(() {
        currentLocation = location;
      });
    });
  }

  void getPolylinePoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    final response = await http.get(Uri.parse(
        "https://maps.googleapis.com/maps/api/directions/json?origin=Toronto&destination=Montreal&key=AIzaSyC1PQeTNyaRjqPYmyoM_6HQAwJZ8oAVedw"));
    print(
        'Responsssssssssssssssssssssssssseeeeeeeeeeeeeeeeeeeeeeeeeee ${response.body}');
// old
    // PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
    //   "AIzaSyC1PQeTNyaRjqPYmyoM_6HQAwJZ8oAVedw",
    //   PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
    //   PointLatLng(destination.latitude, destination.longitude),
    // );
    // print("LOIOOOOOOOOOO ${result.points.isNotEmpty}");
    // if (result.points.isNotEmpty) {
    //   print("Tao o day ${result.points}");
    //   result.points.forEach(
    //     (PointLatLng point) => polylineCoordinates.add(
    //       LatLng(point.latitude, point.longitude),
    //     ),
    //   );
    //   setState(() {});
    // }
    // print('POYLLLLLLLLL $polylineCoordinates');
  }

  @override
  void initState() {
    getCurrentLocation();
    getPolylinePoints();
    super.initState();
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnable;
    PermissionStatus _permissionGranted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).colorScheme.background,
        title:
            Text("Track order", style: Theme.of(context).textTheme.titleSmall),
      ),
      body: currentLocation == null
          ? Text("Loading....")
          : GoogleMap(
              // initialCameraPosition: CameraPosition(
              //   target: LatLng(
              //       currentLocation!.latitude!, currentLocation!.longitude!),
              //   zoom: 13.5,
              // ),
              initialCameraPosition: CameraPosition(
                target:
                    LatLng(sourceLocation.latitude, sourceLocation.longitude),
                zoom: 13.5,
              ),
              onMapCreated: (GoogleMapController controller) =>
                  _controller.complete(controller),
              polylines: {
                Polyline(
                  polylineId: PolylineId("route"),
                  points: polylineCoordinates,
                  color: Theme.of(context).colorScheme.primary,
                  width: 6,
                ),
              },
              markers: {
                Marker(
                  markerId: MarkerId("currentLocation"),
                  position: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                ),
                const Marker(
                  markerId: MarkerId("source"),
                  position: sourceLocation,
                ),
                const Marker(
                  markerId: MarkerId("destination"),
                  position: destination,
                ),
              },
            ),
    );
  }
}
