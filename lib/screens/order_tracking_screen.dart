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
  static const LatLng sourceLocation =
      LatLng(10.830859630518859, 106.77497753778339);
  static const LatLng destination =
      LatLng(10.871487115000587, 106.79176169545593);
  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;
  LatLng driverLocation = LatLng(10.871487115000587, 106.79176169545593);
  int currentPointIndex = 0;
  bool isTimerRunning = true;
  BitmapDescriptor driverMarker = BitmapDescriptor.defaultMarker;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    isTimerRunning = false;
  }

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      AssetConstants.location,
    ).then((icon) => driverMarker = icon);
  }

  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then((location) {
      setState(() {
        currentLocation = location;
      });
    });

    Timer.periodic(Duration(seconds: 2), (timer) {
      if (!isTimerRunning) {
        timer.cancel(); // Stop the timer if isTimerRunning is false
      } else {
        updateLocation();
      }
    });
  }

  void updateLocation() async {
    GoogleMapController googleMapController = await _controller.future;
    if (currentPointIndex >= 0) {
      LatLng newPosition = polylineCoordinates[currentPointIndex];
      _controller.future.then((controller) {
        // controller.animateCamera(CameraUpdate.newLatLng(newPosition));
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: newPosition, zoom: 16),
          ),
        );
      });
      setState(() {
        driverLocation = newPosition;
      });

      currentPointIndex--;
    }
  }

  void getPolylinePoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    // final response = await http.get(Uri.parse(
    //     "https://maps.googleapis.com/maps/api/directions/json?origin=Toronto&destination=Montreal&key=AIzaSyDicGrWeOR3v_2J4osIi2huLsLxd-8mq1o"));
    // print(
    //     'Responsssssssssssssssssssssssssseeeeeeeeeeeeeeeeeeeeeeeeeee ${response.body}');
// old
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyDicGrWeOR3v_2J4osIi2huLsLxd-8mq1o",
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );
    print("LOIOOOOOOOOOO ${result.points.isNotEmpty}");
    if (result.points.isNotEmpty) {
      print("Tao o day ${result.points}");
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {
        currentPointIndex = polylineCoordinates.length - 1;
      });
    }
    print('POYLLLLLLLLL $polylineCoordinates');
  }

  @override
  void initState() {
    getCurrentLocation();
    setCustomMarkerIcon();
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
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Loading....",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            )
          : GoogleMap(
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
                // Marker(
                //   markerId: MarkerId("currentLocation"),
                //   position: LatLng(
                //       currentLocation!.latitude!, currentLocation!.longitude!),
                // ),
                Marker(
                  markerId: MarkerId("currentLocation"),
                  position: driverLocation,
                  icon: driverMarker,
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
