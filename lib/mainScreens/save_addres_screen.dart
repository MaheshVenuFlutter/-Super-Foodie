import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_users/mainScreens/addres_Screen.dart';
import 'package:food_users/widgets/address_appbar.dart';
import 'package:food_users/widgets/simple_app_bar.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../global/global.dart';
import '../models/address_model.dart';
import '../widgets/text_feild.dart';

class SaveAddressScreen extends StatelessWidget {
  final _neame = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _flatNumber = TextEditingController();
  final _city = TextEditingController();
  final _state = TextEditingController();
  final _completeAddress = TextEditingController();
  final _locationController = TextEditingController();
  final fromKey = GlobalKey<FormState>();

  List<Placemark>? placemarks;
  Position? position;

  // getUserLocationAddress() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   placeMarks =
  //       await placemarkFromCoordinates(position.latitude, position.longitude);

  //   Placemark pMark = placeMarks![0];

  //   String fullAddress =
  //       '${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea}, ${pMark.administrativeArea} ${pMark.postalCode}, ${pMark.country}';
  //   _locationController.text = fullAddress;
  //   _flatNumber.text =
  //       '${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}';

  //   _city.text =
  //       '${pMark.subAdministrativeArea}, ${pMark.administrativeArea} ${pMark.postalCode}';
  //   _state.text = ' ${pMark.country}';
  // }

  void getUserLocationAddress() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print("permission denied");
      LocationPermission asked = await Geolocator.requestPermission();
    } else {
      Position newPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      position = newPosition;

      placemarks = await placemarkFromCoordinates(
          position!.latitude, position!.longitude);

      Placemark pMark = placemarks![0];

      String fullAddress =
          '${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea}, ${pMark.administrativeArea} ${pMark.postalCode}, ${pMark.country}';

      _locationController.text = fullAddress;

      _flatNumber.text =
          '${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}';
      _city.text =
          '${pMark.subAdministrativeArea}, ${pMark.administrativeArea} ${pMark.postalCode}';
      _state.text = '${pMark.country}';
      _completeAddress.text = fullAddress;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AddressAppBar(
        title: "Super Foodie",
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //save new Address to firebase
          if (fromKey.currentState!.validate()) {
            final model = Address(
              name: _neame.text.trim(),
              state: _state.text.trim(),
              fullAddress: _completeAddress.text.trim(),
              phoneNumber: _phoneNumber.text.trim(),
              flatNumber: _flatNumber.text.trim(),
              city: _city.text.trim(),
              lat: position!.latitude,
              lng: position!.longitude,
            ).toJson();
            print(position!.latitude);
            print(position!.longitude);
            FirebaseFirestore.instance
                .collection("users")
                .doc(sharedPreferences!.getString("uid"))
                .collection("userAddress")
                .doc(DateTime.now().microsecondsSinceEpoch.toString())
                .set(model)
                .then((value) {
              Fluttertoast.showToast(
                  msg: "New Address has been saved successfully.",
                  fontSize: 15,
                  textColor: Colors.white,
                  backgroundColor: Colors.amber);
              fromKey.currentState!.reset();
            });
          }
        },
        label: const Text("Save Now"),
        icon: const Icon(Icons.check),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Align(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "Save New Address: ",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.person_pin_circle,
                color: Colors.black,
                size: 35,
              ),
              title: Container(
                width: 250,
                child: TextField(
                  style: const TextStyle(color: Colors.black),
                  controller: _locationController,
                  decoration: const InputDecoration(
                      hintText: "Whats your address?",
                      hintStyle: TextStyle(color: Colors.black)),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              onPressed: () {
                getUserLocationAddress();
              },
              icon: const Icon(
                Icons.location_on,
                color: Colors.redAccent,
              ),
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: const BorderSide(color: Colors.cyan)))),
              label: const Text(
                "Get My Current Location",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Form(
              key: fromKey,
              child: Column(
                children: [
                  MyTextField(
                    hint: "Name",
                    controller: _neame,
                  ),
                  MyTextField(
                    hint: "Phone Number",
                    controller: _phoneNumber,
                  ),
                  MyTextField(
                    hint: "City",
                    controller: _city,
                  ),
                  MyTextField(
                    hint: "State/Country",
                    controller: _state,
                  ),
                  MyTextField(
                    hint: "Address Line",
                    controller: _flatNumber,
                  ),
                  MyTextField(
                    hint: "Complete Address",
                    controller: _completeAddress,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
