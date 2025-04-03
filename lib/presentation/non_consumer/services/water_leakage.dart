import 'dart:convert';
import 'package:hmwssb/core/api/shared_prefernce.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hmwssb/core/api/api.dart';
import 'package:hmwssb/core/api/network.dart';
import 'package:hmwssb/core/camera.dart';
import 'package:hmwssb/core/theme/app_color.dart';
import 'package:hmwssb/data/models/common_response.dart';
import 'package:hmwssb/data/models/section_code_response.dart';

class WaterLeakage extends StatefulWidget {
  const WaterLeakage({super.key});

  @override
  State<WaterLeakage> createState() => _WaterLeakageState();
}

class _WaterLeakageState extends State<WaterLeakage> {
  Position? _currentPosition;
  dynamic _image;
  String? photoBase64;

  var descriptionController = TextEditingController();
  var addressController = TextEditingController();
  var sectionCode = "";

  @override
  void initState() {
    super.initState();
    determinePosition();
  }

  void openCamera(context, type) async {
    final image = await CustomCamera.openCamera();
    var base64Data = base64Encode(image);
    setState(() {
      _image = image;
      photoBase64 = base64Data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: primaryColor,
            title: const Text('Water Leakage', style: TextStyle(color: white)),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                })),
        body: SingleChildScrollView(
            child: Column(children: [
          const SizedBox(height: 10),
          const Text("Capture Image",
              style: TextStyle(fontSize: 18, color: primaryColor)),
          SizedBox(
              child: GestureDetector(
                  onTap: () {
                    openCamera(context, 1);
                  },
                  child: Center(
                      child: SizedBox(
                          width: 200,
                          height: 200,
                          child: _image == null
                              ? Image.asset(
                                  "assets/images/illegalwater.png",
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.fill,
                                )
                              : Image.memory(_image, fit: BoxFit.fill))))),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                  controller: addressController,
                  maxLines: 6,
                  minLines: 4,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Address',
                      hintText: 'Enter Address'))),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                  controller: descriptionController,
                  maxLines: 6,
                  minLines: 4,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: ' Description',
                      hintText: 'Enter  Description'))),
          ElevatedButton(
              onPressed: () => validate(),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: primaryColor,
              ),
              child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80.0),
                  child:
                      Text("Submit", style: TextStyle(color: Colors.white)))),
          const SizedBox(height: 15)
        ])));
  }

  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      Geolocator.openAppSettings();
      return Future.error('Location permissions are denied');
    }

    if (permission == LocationPermission.deniedForever) {
      Geolocator.openAppSettings();
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Geolocator.getCurrentPosition(
                locationSettings:
                    const LocationSettings(accuracy: LocationAccuracy.best))
            .then((Position position) {
      setState(() {
        _currentPosition = position;
        if (sectionCode.isEmpty) {
          getSectionCodeFromLocation();
        }
        // print(_currentPosition?.latitude ?? "");
      });
    })
        // .catchError((e) {
        //   print(e);
        // })
        ;
  }

  validate() {
    if (photoBase64 == null) {
      EasyLoading.showInfo("Capture Image");
    } else if (addressController.text.isEmpty) {
      EasyLoading.showInfo("Enter Address");
    } else if (descriptionController.text.isEmpty) {
      EasyLoading.showInfo("Enter Description");
    } else if (_currentPosition?.latitude == null) {
      EasyLoading.showInfo("Getting GeoCoordinates Please Wait...");
      determinePosition();
    } else {
      submitData();
    }
  }

  void submitData() async {
    var postData = {
      "complaintDesc": descriptionController.text.toString(),
      "reasonCode": "1",
      "address": addressController.text.toString(),
      "sectionCode": sectionCode,
      "mobileNo": LocalStorages.getMobileNumber() ?? '',
      "image": photoBase64,
      "latitude": _currentPosition?.latitude ?? 0.0,
      "longitude": _currentPosition?.longitude ?? 0.0
    };

    try {
      EasyLoading.show(status: "Loading...");
      var response = await NetworkApiService()
          .commonApiCall(url: Api.registerManHole, data: postData);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var value = CommonResponse.fromJson(response.data);
        if ((value.mItem1?.responseCode ?? "0") == "200") {
          EasyLoading.showError(value.mItem1?.description ?? "");
          Navigator.pop(context);
        } else {
          EasyLoading.showError(value.mItem1?.description ?? "");
        }
      }
    } on DioException catch (ex) {
      EasyLoading.dismiss();
      showException(ex);
    }
  }

  void getSectionCodeFromLocation() async {
    try {
      EasyLoading.show(status: "Loading...");
      var response = await NetworkApiService()
          .commonApiCall(url: Api.getSectioncode, data: {
        'Lat': _currentPosition?.latitude.toString() ?? '',
        'Long': _currentPosition?.longitude.toString() ?? '',
      });
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var value = SectionCodeResponse.fromJson(response.data);
        if ((value.mItem1?.responseCode ?? "0") == "200") {
          sectionCode = value.mItem2.toString();
        } else {
          EasyLoading.showError(value.mItem1?.description ?? "");
        }
      }
    } on DioException catch (ex) {
      EasyLoading.dismiss();
      showException(ex);
    }
  }
}
