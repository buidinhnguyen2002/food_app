import 'dart:async';
import 'dart:convert';

import 'package:final_project/models/address.dart';
import 'package:final_project/models/district.dart';
import 'package:final_project/models/ward.dart';
import 'package:final_project/providers/address_provider.dart';
import 'package:final_project/utils/functions.dart';
import 'package:final_project/utils/widgets.dart';
import 'package:final_project/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class EditAddressScreen extends StatefulWidget {
  const EditAddressScreen({super.key});
  static const routeName = "/edit-address-screen";
  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  List<District> listDistrict = [];
  List<Ward> listWards = [];
  late District selectedDistrictValue;
  late Ward selectedWardValue;
  int selectDistrictCode = 0;
  int selectWardCode = 0;
  LatLng addressPosition = const LatLng(10.8230989, 106.62966379999999);
  final Completer<GoogleMapController> _controller = Completer();
  String baseProvince = "Thành phố Hồ Chí Minh";
  GoogleMapController? _googleMapController;
  double zoom = 16;
  TextEditingController _addressDetail = TextEditingController();
  TextEditingController _holderName = TextEditingController();
  @override
  void initState() {
    super.initState();

    loadDistrict();
    locationFromAddress(baseProvince).then((location) {
      Location locationAddress = location[0];
      setState(() {
        addressPosition =
            LatLng(locationAddress.latitude, locationAddress.longitude);
      });
    });
  }

  Future<void> updateAddress(String address) async {
    GoogleMapController googleMapController = await _controller.future;
    locationFromAddress(address).then((location) {
      Location locationAddress = location[0];
      setState(() {
        addressPosition =
            LatLng(locationAddress.latitude, locationAddress.longitude);
        print("newPOSITITON $addressPosition");
      });
      _controller.future.then((controller) {
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: addressPosition, zoom: zoom),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    String id = '';
    Address address;
    if (args != null) {
      id = args['id'];
      address = addressProvider.getAddressById(id);
      _holderName.text = address.name;
      _addressDetail.text = address.addressDetail;
      // selectedDistrictValue = getDistrict(address.district);
      // selectedWardValue = getWard(address.ward);
      // selectDistrictCode = getCodeDistrict(address.district);
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(id == '' ? "Create Address" : "Edit Address"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Holder name:",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                BoxEmpty.sizeBox5,
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 0),
                      border: const OutlineInputBorder(gapPadding: 0),
                      hintText: 'Type holder address...',
                      hintStyle: Theme.of(context).textTheme.headlineMedium,
                    ),
                    controller: _holderName,
                  ),
                ),
              ],
            ),
            BoxEmpty.sizeBox10,
            buildDropdownButton('Quận:', listDistrict),
            BoxEmpty.sizeBox10,
            buildDropdownButtonWard('Phường:', listWards),
            TextField(
              maxLines: 2,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                border: OutlineInputBorder(),
                hintText: 'Type detail address...',
                hintStyle: Theme.of(context).textTheme.headlineMedium,
              ),
              controller: _addressDetail,
              textInputAction: TextInputAction.done,
              onEditingComplete: () {
                zoom = 19;
                updateAddress(
                    "${baseProvince},${selectedDistrictValue.name},${selectedWardValue.name},${_addressDetail.text}");
              },
            ),
            BoxEmpty.sizeBox10,
            Expanded(
              child: addressPosition == null
                  ? const CircularProgressIndicator()
                  : GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(addressPosition.latitude,
                            addressPosition.longitude),
                        zoom: 16,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                        _googleMapController = controller;
                        _controller.future.then((controller) {
                          _googleMapController!.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(target: addressPosition, zoom: 16),
                            ),
                          );
                        });
                      },
                      markers: {
                        Marker(
                          markerId: const MarkerId("currentLocation"),
                          position: addressPosition,
                          draggable: true,
                          onDragEnd: (LatLng position) {
                            setState(() {
                              addressPosition = position;
                            });
                          },
                        ),
                      },
                    ),
            ),
            BoxEmpty.sizeBox10,
            CommonButton(
                title: id == '' ? "Create address" : "Save address",
                onPress: () async {
                  String message = "";
                  if (id == '') {
                    final response = await addressProvider.createAddress(
                      name: _holderName.text,
                      district: selectedDistrictValue.name,
                      ward: selectedWardValue.name,
                      addressDetail: _addressDetail.text,
                      latitude: addressPosition.latitude,
                      longitude: addressPosition.longitude,
                    );
                    message = "Create address succesful";
                  } else {
                    final response = await addressProvider.updateAddress(
                      addressId: id,
                      name: _holderName.text,
                      district: selectedDistrictValue.name,
                      ward: selectedWardValue.name,
                      addressDetail: _addressDetail.text,
                      latitude: addressPosition.latitude,
                      longitude: addressPosition.longitude,
                    );
                    message = "Update address succesful";
                  }
                  await showNotification(context, message);
                  Future.delayed(
                    const Duration(seconds: 1, microseconds: 50),
                    () {
                      Navigator.pop(context);
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }

  String host = "https://provinces.open-api.vn/api/";

  Future<void> loadDistrict() async {
    final response = await http.get(Uri.parse("${host}p/79?depth=2"));
    final dataDistrictInDistrict =
        json.decode(response.body) as Map<String, dynamic>;
    final dataDistricts = dataDistrictInDistrict["districts"] as List;
    setState(() {
      listDistrict = dataDistricts.map((d) => District.fromJson(d)).toList();
      selectedDistrictValue = listDistrict[0];
      selectDistrictCode = selectedDistrictValue.code;
    });
    loadWards();
  }

  Future<void> loadWards() async {
    final response =
        await http.get(Uri.parse("${host}d/$selectDistrictCode?depth=2"));
    final dataWardsInProvine =
        json.decode(response.body) as Map<String, dynamic>;
    final dataWards = dataWardsInProvine["wards"] as List;
    print(dataWards);
    setState(() {
      listWards = dataWards.map((d) => Ward.fromJson(d)).toList();
      selectedWardValue = listWards[0];
    });
  }

  Widget buildDropdownButton(String label, List<District> items) {
    if (items.isEmpty) return const CircularProgressIndicator();
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 0),
          DropdownButton<String>(
            value: selectedDistrictValue.name,
            style: Theme.of(context).textTheme.headlineMedium,
            items: items.map((District value) {
              return DropdownMenuItem<String>(
                value: value.name,
                child: Text(value.name),
              );
            }).toList(),
            onChanged: (String? value) {
              zoom = 18;
              updateAddress("${baseProvince},${value.toString()}");
              setState(() {
                selectedDistrictValue = getDistrict(value.toString());
              });
              selectDistrictCode = getCodeDistrict(value.toString());
              loadWards();
            },
            isExpanded: true,
          ),
        ],
      ),
    );
  }

  Widget buildDropdownButtonWard(String label, List<Ward> items) {
    if (items.isEmpty) return const CircularProgressIndicator();
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 0),
          DropdownButton<String>(
            value: selectedWardValue.name,
            style: Theme.of(context).textTheme.headlineMedium,
            items: items.map((Ward value) {
              return DropdownMenuItem<String>(
                value: value.name,
                child: Text(value.name),
              );
            }).toList(),
            onChanged: (String? value) {
              zoom = 19;
              updateAddress(
                  "${baseProvince},${selectedDistrictValue.name},${value.toString()}");
              setState(() {
                selectedWardValue = getWard(value.toString());
              });
              selectWardCode = getCodeDistrict(value.toString());
              loadWards();
            },
            isExpanded: true,
          ),
        ],
      ),
    );
  }

  int getCodeDistrict(String district) {
    return listDistrict.where((dis) => dis.name == district).first.code;
  }

  District getDistrict(String district) {
    return listDistrict.where((dis) => dis.name == district).first ??
        District(
            name: "", code: 1, divisionType: "", codename: "", provinceCode: 1);
  }

  Ward getWard(String ward) {
    return listWards.where((war) => war.name == ward).first;
  }
}
