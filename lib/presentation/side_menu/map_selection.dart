import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hmwssb/core/common_web_app_screen.dart';
import 'package:hmwssb/presentation/tanker_booking/models/tracking_status.dart';
import 'package:map_picker/map_picker.dart';

import 'package:hmwssb/core/api/api.dart';
import 'package:hmwssb/core/api/network.dart';
import 'package:hmwssb/core/api/shared_prefernce.dart';
import 'package:hmwssb/core/theme/app_color.dart';
import 'package:hmwssb/data/models/tanker_response.dart';
import 'package:hmwssb/presentation/tanker_booking/models/track_status.dart';
import 'package:hmwssb/presentation/tanker_booking/screens/detailed_row.dart';
import 'package:hmwssb/presentation/tanker_booking/screens/tanker_booking_screen.dart';

class SelectLocation extends StatefulWidget {
  const SelectLocation({super.key});

  @override
  SelectLocationState createState() => SelectLocationState();
}

class SelectLocationState extends State<SelectLocation> {
  final _controller = Completer<GoogleMapController>();
  MapPickerController mapPickerController = MapPickerController();
  int tankerBook = 0;
  List<String> capacityList = [];

  // SharedPreferences? pref;
  var textController = TextEditingController();
  late CameraPosition cameraPosition;
  var _currentPosition = const LatLng(17.4120325, 78.4601700);
  Booking? tokenData;
  ResultArray? data;
  String callDriverWithVirtualNumber = '';

  @override
  void initState() {
    super.initState();
    initPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return verifyMItem2.contains('Sorry')
        ? Center(
            child: Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                child: RichText(
                  textAlign: TextAlign.center, // Align text to the center
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Note: ', // First part of the text (Note:)
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: verifyMItem2
                            .split('|')
                            .last, // Second part of the text (the actual note)
                        style: TextStyle(
                          color: black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                )),
          )
        : Stack(
            alignment: Alignment.topCenter,
            children: [showMap(), showTankerStatus()],
          );
  }

  void initPreferences() async {
    // pref = await SharedPreferences.getInstance();
    if ((LocalStorages.getLatitude() != "" &&
            LocalStorages.getLatitude() != "0") &&
        (LocalStorages.getLongitude() != "" &&
            LocalStorages.getLongitude() != "0")) {
      // if (pref?.getString(ShareKey.LATITUDE) != "" &&
      //     pref?.getString(ShareKey.LATITUDE) != "0") {
      setState(() {
        _currentPosition = LatLng(
            double.tryParse(LocalStorages.getLatitude().toString()) ??
                _currentPosition.latitude,
            double.tryParse(LocalStorages.getLongitude().toString()) ??
                _currentPosition.longitude);
        textController.text = LocalStorages.getAddress() ?? '';
      });
    }
    canBook();
    determinePosition();
  }

  String verifyMItem2 = '';

  canBook() async {
    try {
      EasyLoading.show(status: "Loading...");
      trackDetails().then((value) async {
        if (tokenData != null && tokenData?.bookingStatus != null) {
          if (tokenData?.bookingStatus == 4 || tokenData?.bookingStatus == 5) {
            var response = await NetworkApiService().commonApiCall(
                url: Api.canTankerBook,
                data: {'can': LocalStorages.getCanno() ?? ""});

            if (response.statusCode == 200) {
              var value = TankerResponse.fromJson(response.data);
              verifyMItem2 = value.mItem2 ?? '0';
              if (verifyMItem2 == "1") {
                setState(() {
                  tankerBook = 1;
                  capacityList = value.mItem3 ?? [];
                });
                // setState(() {});
              } else {
                setState(() {
                  tankerBook = 2;
                });
                // trackDetails();
              }
              EasyLoading.dismiss();
            }
          } else {
            setState(() {
              tankerBook = 2;
            });
            EasyLoading.dismiss();
          }
        } else {
          var response = await NetworkApiService().commonApiCall(
              url: Api.canTankerBook,
              data: {'can': LocalStorages.getCanno() ?? ""});

          if (response.statusCode == 200) {
            var value = TankerResponse.fromJson(response.data);
            verifyMItem2 = value.mItem2 ?? '0';
            if (verifyMItem2 == "1") {
              setState(() {
                tankerBook = 1;
                capacityList = value.mItem3 ?? [];
              });
              // setState(() {});
            } else {
              setState(() {
                tankerBook = 2;
              });
              // trackDetails();
            }
            EasyLoading.dismiss();
          }
        }
      });

      setState(() {});
    } on DioException catch (ex) {
      EasyLoading.dismiss();
      showException(ex);
    }
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
      if ((LocalStorages.getLatitude() == "" ||
              LocalStorages.getLatitude() == "0") ||
          (LocalStorages.getLongitude() == "" ||
              LocalStorages.getLongitude() == "0")) {
        // if (pref?.getString(ShareKey.LATITUDE) == "" ||
        //     pref?.getString(ShareKey.LATITUDE) == "0") {
        setState(() {
          _currentPosition = LatLng(position.latitude, position.longitude);
        });
      }
    })
        // .catchError((e) {
        //   print(e);
        // })
        ;
  }

  trackDetails() async {
    // SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      // var postData = {"can_number": pref.getString(ShareKey.CANNO)};
      var postData = {
        "REQUEST": {
          "CAN": LocalStorages.getCanno() ?? "",
          "MOBILENO": LocalStorages.getMobileNumber() ?? "",  // Replace with dynamic data if needed
          "REQUESTTYPE": "TANKERQUEUE"
        }
      };

      // EasyLoading.show(status: "Loading...");
      var response = await NetworkApiService().commonApiCall(
          url: Api.baseUrlTanker, data: postData, isPostMethod: true);
      // EasyLoading.dismiss();
      if (response.statusCode == 200) {
        TrackStatus value = TrackStatus.fromJson(response.data);
        Status value2 = Status.fromJson(response.data);
        if (value.error == 0) {
          setState(() {
            data = value2.resultArray as ResultArray?;
            tokenData = value.booking;
            callDriverWithVirtualNumber = value.virtualNumber ?? '';
          });
        }
      }
    } on DioException catch (ex) {
      // EasyLoading.dismiss();
      showException(ex);
    }
  }

  Widget showTankerStatus() {
    if (tankerBook == 2) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              color: Colors.white,
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailRow(
                        title: 'Can Number',
                        value: LocalStorages.getCanno() ?? ""),
                    // value: LocalStorage.getCanno() ?? ""),
                    DetailRow(
                        title: 'Pin Number', value: data?.pINNO?.toString() ?? ""),

                    DetailRow(
                        title: 'Queue Number',
                        value: data?.sEQNUM.toString() ?? ""),
                    DetailRow(
                        title: 'Token Number',
                        value: data?.tOKENNO?.toString()??""),
                    DetailRow(
                        title: 'Required Date',
                        value: data?.rECVDDATE?.toString() ?? ''),

                    // Align(
                    //   alignment: Alignment.bottomRight,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: ElevatedButton.icon(
                    //       onPressed: () async {
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) => CustomWebViewScreen(
                    //                     url:
                    //                         tokenData?.customerCopyUrl ?? '')));
                    //       },
                    //       icon: const Icon(
                    //         Icons.receipt,
                    //         color: Colors.white,
                    //       ),
                    //       // The icon on the start of the button
                    //       label: const Text(
                    //         'Challan',
                    //         style: TextStyle(color: Colors.white),
                    //       ),
                    //       // The text on the button
                    //       style: ElevatedButton.styleFrom(
                    //         backgroundColor: primaryColor, // Background color
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            if (tokenData?.bookingStatus == 1)
              Image.asset(
                "assets/images/inqueue.png",
                width: double.infinity,
              ),
            if (tokenData?.bookingStatus == 2)
              Image.asset(
                "assets/images/inqueue.png",
                width: double.infinity,
              ),
            if (tokenData?.bookingStatus == 3)
              Image.asset(
                "assets/images/started.png",
                width: double.infinity,
              ),
            if (tokenData?.bookingStatus == 4)
              Image.asset(
                "assets/images/delivered.png",
                width: double.infinity,
              ),
            if (tokenData?.bookingStatus == 5)
              Image.asset(
                "assets/images/cancelled.png",
                width: double.infinity,
              ),
            const SizedBox(height: 20),
            if (tokenData?.bookingStatus == 3)
              Column(
                children: [
                  const Text(
                    "Driver Details",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        tokenData?.driverName ?? "",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor),
                      ),
                      Text(
                        tokenData?.vehicleNo ?? "",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Filling Station : ${tokenData?.fillingStationName ?? ""}",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor),
                  ),
                  const SizedBox(height: 20),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     //!DONT KNOW WHICH CLASS IS THIS
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: ElevatedButton.icon(
                  //         onPressed: () {
                  //           // Your action here
                  //           Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                   builder: (context) => LocationTracking(
                  //                       previoustokenData: tokenData,
                  //                       callBackBunction: (p0) {
                  //                         trackDetails();
                  //                       },
                  //                       lastLatlng: LatLng(
                  //                           // tokenData?.lastLatitude==null?0.0:
                  //                           double.parse(
                  //                               tokenData?.lastLatitude ??
                  //                                   "0.0"),
                  //                           double.parse(
                  //                               tokenData?.lastLongitude ??
                  //                                   "0.0")))));
                  //         },
                  //         icon: const Icon(
                  //           Icons.map,
                  //           color: Colors.white,
                  //         ),
                  //         // The icon on the start of the button
                  //         label: const Text(
                  //           'Live Track',
                  //           style: TextStyle(color: Colors.white),
                  //         ),
                  //         // The text on the button
                  //         style: ElevatedButton.styleFrom(
                  //           backgroundColor: primaryColor, // Background color
                  //         ),
                  //       ),
                  //     ),
                  //     const SizedBox(width: 20),
                  //     // Space between buttons
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: ElevatedButton.icon(
                  //         onPressed: () {
                  //           // Your action here
                  //           _callNumber(callDriverWithVirtualNumber);
                  //         },
                  //         icon: const Icon(
                  //           Icons.call,
                  //           color: Colors.white,
                  //         ),
                  //         // The icon on the start of the button
                  //         label: const Text(
                  //           'Call Driver',
                  //           style: TextStyle(color: Colors.white),
                  //         ),
                  //         // The text on the button
                  //         style: ElevatedButton.styleFrom(
                  //           backgroundColor: primaryColor, // Background color
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
          ],
        ),
      );
    } else {
      return const SizedBox(height: 0);
      // return const Center(child: Text('Something went wrong'));
    }
  }

  // void callDriver() async {
  //   // SharedPreferences pref = await SharedPreferences.getInstance();
  //   try {
  //     var postData = {
  //       "apiKey": "163e7050-81f1-4b47-aeb2-b081609fca42",
  //       "customer_number": LocalStorages.getMobileNumber() ?? '',
  //       "user_number": tokenData?.driverPhone,
  //       "caller_id": "08037097115",
  //       "reference_id": tokenData?.id.toString()
  //     };
  //     var body = jsonEncode(postData);
  //     EasyLoading.show(status: "Loading...");
  //     var response = await NetworkApiService()
  //         ..commonApiCall(url:
  //         .post(Api.app247InAppCalling, data: body);

  //     EasyLoading.dismiss();
  //     if (response.statusCode == 200) {
  //       _callNumber("08037097115");
  //     }
  //   } on DioException catch (ex) {
  //     EasyLoading.dismiss();
  //     showException(ex);
  //   }
  // }

  // _callNumber(String mobNo) async {
  //   final Uri phoneUri = Uri(
  //     scheme: 'tel',
  //     path: mobNo, // Get the number from the TextField
  //   );
  //   // if (await canLaunchUrl(phoneUri)) {
  //   //   await launchUrl(phoneUri); // Launch the phone's dialer
  //   // } else {
  //   //   EasyLoading.showError("Not launch");
  //   // }
  //   try {
  //     if (await canLaunchUrl(phoneUri)) {
  //       await launchUrl(phoneUri);
  //     } else {
  //       EasyLoading.showError("Could not launch the dialer.");
  //     }
  //   } on Exception catch (e) {
  //     EasyLoading.showError("An error occurred: $e");
  //   }
  // }

  Widget showMap() {
    if (tankerBook == 1) {
      cameraPosition = CameraPosition(target: _currentPosition, zoom: 14.4746);

      // Fetch the LATLONGEDITIBLE value
      final isLatLongEditable = LocalStorages.getLatLongEdit() == 1;
      // print('hdgf');
      // print(isLatLongEditable);

      return Stack(
        children: [
          MapPicker(
            iconWidget: SvgPicture.asset(
              "assets/svg/location_pin.svg",
              height: 60,
              colorFilter: isLatLongEditable
                  ? null
                  : const ColorFilter.mode(
                      Colors.grey, // Change color based on editable state
                      BlendMode.srcIn,
                    ),
              // color: isLatLongEditable
              //     ? null
              //     : Colors.grey, // Change color based on editable state
            ),
            mapPickerController: mapPickerController,
            child: GoogleMap(
              myLocationEnabled: true,
              zoomControlsEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition: cameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              // Handle camera move based on isLatLongEditable
              onCameraMoveStarted: () {
                if (isLatLongEditable) {
                  mapPickerController.mapMoving!();
                  textController.text = "Checking ...";
                }
              },
              onCameraMove: (cameraPosition) {
                if (isLatLongEditable) {
                  this.cameraPosition = cameraPosition;
                } else {
                  // Prevent camera movement
                  _controller.future.then((controller) {
                    controller.moveCamera(
                      CameraUpdate.newCameraPosition(this.cameraPosition),
                    );
                  });
                }
              },
              onCameraIdle: () async {
                if (isLatLongEditable) {
                  mapPickerController.mapFinishedMoving!();
                  List<Placemark> placemarks = await placemarkFromCoordinates(
                    cameraPosition.target.latitude,
                    cameraPosition.target.longitude,
                  );
                  textController.text =
                      '${placemarks.first.name}, ${placemarks.first.subLocality}, ${placemarks.first.locality}, ${placemarks.first.country}';
                }
              },
            ),
          ),
          Positioned(
            top: 10,
            width: MediaQuery.of(context).size.width - 60,
            height: 50,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Address',
                ),
                textAlign: TextAlign.center,
                readOnly: true,
                controller: textController,
              ),
            ),
          ),
          Positioned(
            bottom: 24,
            left: 24,
            right: 70,
            child: SizedBox(
              height: 50,
              child: TextButton(
                onPressed: () async {
                  LocalStorages.saveUserData(
                    localSaveType: LocalSaveType.address,
                    value: textController.text.trim(),
                  );
                  LocalStorages.saveUserData(
                    localSaveType: LocalSaveType.latitude,
                    value: cameraPosition.target.latitude.toString(),
                  );
                  LocalStorages.saveUserData(
                    localSaveType: LocalSaveType.longitude,
                    value: cameraPosition.target.longitude.toString(),
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TankerBooking(capacityList: capacityList),
                    ),
                  ).then((value) {
                    setState(() {
                      canBook();
                    });
                  });
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                    const Color(0xFFA3080C),
                  ),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                child: const Text(
                  "Confirm Location",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    color: Color(0xFFFFFFFF),
                    fontSize: 19,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return const SizedBox(width: 0, height: 0);
    }
  }
}
