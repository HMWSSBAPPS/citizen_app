import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hmwssb/core/api/shared_prefernce.dart';
import 'package:hmwssb/core/theme/app_color.dart';
import 'package:hmwssb/data/models/complaints_master.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hmwssb/core/api/api.dart';
import 'package:hmwssb/core/api/network.dart';
import 'package:hmwssb/core/camera.dart';

class RaiseComplaint extends StatefulWidget {
  final String type;
  final String subType;
  final bool allowImageCapture;
  const RaiseComplaint(this.type, this.subType, {super.key,
    this.allowImageCapture = true,
  });

  @override
  State<RaiseComplaint> createState() => _RaiseComplaintState();
}

class _RaiseComplaintState extends State<RaiseComplaint> {
  final complaintTypeKey = GlobalKey<DropdownSearchState<String>>();
  final complaintReasonKey = GlobalKey<DropdownSearchState<String>>();
  final descriptionController = TextEditingController();

  List<MItem2> complaintData = [];
  List<String> complaintTypes = [];
  List<String> complaintReasons = [];
  List<String> filteredReasons = [];
  String selectedComplaintType = "";
  String selectedComplaintReason = "";
  bool canCapture = false;
  bool isEnabled = true;

  List<String> notRequiredList = [
    'NO WATER FOR X DAYS',
    'LOW WATER PRESSURE',
    'ERRATIC TIMING OF WATER SUPPLY',
    'CHANGE OF CATEGORY OF CONSUMPTION'
  ];

  Position? _currentPosition;
  dynamic _image;
  String? photoBase64 = "";

  void openCamera(context, type) async {
    final image = await CustomCamera.openCamera();
    var base64Data = base64Encode(image);

    setState(() {
      _image = image;
      photoBase64 = base64Data;
    });
  }

  @override
  void initState() {
    super.initState();
    determinePosition();
    getComplaintMaster();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: primaryColor,
        title: const Text(
          'Register Grievance',
          style: TextStyle(color: white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownSearch<String>(
                enabled: isEnabled,
                key: complaintTypeKey,
                validator: (v) => v == null ? "required field" : null,
                items: (String? filter, LoadProps? value) {
                  return complaintTypes;
                },
                selectedItem: selectedComplaintType.isEmpty
                    ? null
                    : selectedComplaintType,
                onChanged: (dynamic print) => {
                  setState(() {
                    selectedComplaintType = print ?? '';
                    getComplaintReasons(selectedComplaintType);
                  })
                },
                dropdownBuilder: (context, selectedItem) {
                  return Text(
                    selectedItem ?? " Complaint Type *",
                    style: TextStyle(
                      fontSize: 14.sp, // Adjust the font size for the label
                      color: black, // Adjust the color for the label
                    ),
                  );
                },
                popupProps: PopupProps.bottomSheet(
                  // showSearchBox: true,
                  // title: Text("data"),
                  bottomSheetProps:
                      const BottomSheetProps(backgroundColor: Colors.white),
                  searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                        hintText: " Complaint Type *",
                        labelText: " Complaint Type *",
                        labelStyle: TextStyle(
                          fontSize: 18.sp, // Adjust the font size for the label
                          color: black, // Adjust the color for the label
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: DropdownSearch<String>(
            //     enabled: isEnabled,
            //     key: complaintTypeKey,
            //     validator: (v) => v == null ? "required field" : null,
            //     hint: " Complaint Type *",
            //     mode: Mode.BOTTOM_SHEET,
            //     showSelectedItem: true,
            //     items: complaintTypes,
            //     selectedItem: selectedComplaintType,
            //     // label: " Complaint Type *",
            //     showClearButton: false,
            //     onChanged: (dynamic print) => {
            //       setState(() {
            //         selectedComplaintType = print!;
            //         getComplaintReasons(selectedComplaintType);
            //       })
            //     },
            //     dropdownSearchDecoration: InputDecoration(
            //         labelText: " Complaint Type *",
            //         labelStyle: TextStyle(
            //           fontSize: 18.sp, // Adjust the font size for the label
            //           color: black, // Adjust the color for the label
            //         ),
            //         border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(10.0))),
            //   ),
            // ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownSearch<String>(
                enabled: isEnabled,
                key: complaintReasonKey,
                validator: (v) => v == null ? "required field" : null,
                items: (String? filter, LoadProps? value) {
                  return filteredReasons;
                },
                selectedItem: selectedComplaintReason.isEmpty
                    ? null
                    : selectedComplaintReason,
                onChanged: (dynamic print) => {
                  setState(() {
                    selectedComplaintReason = print ?? '';
                  })
                },
                dropdownBuilder: (context, selectedItem) {
                  return Text(
                    selectedItem ?? " Complaint Reason *",
                    style: TextStyle(
                      fontSize: 14.sp, // Adjust the font size for the label
                      color: black, // Adjust the color for the label
                    ),
                  );
                },
                popupProps: PopupProps.bottomSheet(
                  bottomSheetProps:
                      const BottomSheetProps(backgroundColor: Colors.white),
                  searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                        hintText: " Complaint Reason *",
                        labelText: " Complaint Reason *",
                        labelStyle: TextStyle(
                          fontSize: 18.sp, // Adjust the font size for the label
                          color: black, // Adjust the color for the label
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: DropdownSearch<String>(
            //     enabled: isEnabled,
            //     key: complaintReasonKey,
            //     validator: (v) => v == null ? "required field" : null,
            //     hint: " Complaint Reason *",
            //     mode: Mode.BOTTOM_SHEET,
            //     showSelectedItem: true,
            //     selectedItem: selectedComplaintReason,
            //     items: filteredReasons,
            //     label: " Complaint Reason *",
            //     showClearButton: false,
            //     onChanged: (dynamic print) =>
            //         {selectedComplaintReason = print!, setState(() {})},
            //     dropdownSearchDecoration: InputDecoration(
            //         labelText: " Complaint Reason *",
            //         labelStyle: TextStyle(
            //           fontSize: 18.sp, // Adjust the font size for the label
            //           color: black, // Adjust the color for the label
            //         ),
            //         border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(10.0))),
            //   ),
            // ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: descriptionController,
                maxLines: 6,
                minLines: 4,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Complaint Description',
                  hintText: 'Enter Complaint Description',
                  labelStyle: TextStyle(
                    color: black,
                    fontSize: 18.sp,
                  ),
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp(r'[A-Za-z0-9\,\.\s]+')),
                ],
              ),
            ),
            const SizedBox(height: 10),
            showCameraWidget(),
            ElevatedButton(
              onPressed: () => validate(),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: primaryColor, // Text color
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text("Submit", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  validate() {
    if (selectedComplaintType.isEmpty) {
      EasyLoading.showInfo("Select Complaint Type");
    } else if (selectedComplaintReason.isEmpty) {
      EasyLoading.showInfo("Select Complaint Reason");
    } else if (descriptionController.text.isEmpty) {
      EasyLoading.showInfo("Enter Description");
    } else if (_currentPosition?.latitude == null) {
      determinePosition();
      EasyLoading.showInfo("Fetching Geo-Cordinates Please Wait");
    } else if (canCapture && photoBase64 == "") {
      EasyLoading.showInfo("Capture Image");
    } else {
      submitData();
    }
  }

  getComplaintMaster() async {
    try {
      EasyLoading.show(status: "Loading...");
      var response = await NetworkApiService()
          .commonApiCall(url: Api.getComplaintMaster, isGetMethod: true);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var value = ComplaintsMaster.fromJson(response.data);
        if ((value.mItem1?.responseCode ?? "0") != "200") {
          EasyLoading.showError(
              value.mItem1?.description ?? "An error 0ccured");
        } else {
          if (value.mItem2?.isNotEmpty == true) {
            setState(() {
              complaintData = value.mItem2!;
              complaintTypes = value.mItem2!
                  .map((e) => e.complaintTypeName!)
                  .toSet()
                  .toList();
              if (widget.type.isNotEmpty) {
                for (var element in complaintData) {
                  if (element.complaintTypeName == widget.type) {
                    selectedComplaintType =
                        element.complaintTypeName.toString();
                    getComplaintReasons(selectedComplaintType);
                  }
                }
              }
            });
          } else {
            EasyLoading.showInfo("No complaint Types Found");
          }
        }
      }
    } on DioException catch (ex) {
      EasyLoading.dismiss();
      showException(ex);
    }
  }

  getComplaintReasons(String selectedComplaintType) {
    selectedComplaintReason = "";
    complaintReasonKey.currentState?.changeSelectedItem("Complaint Reason");
    filteredReasons = complaintData
        .where((item) => item.complaintTypeName! == selectedComplaintType)
        .map((item) => item.complaintReasonName!)
        .toList();
    for (var element in filteredReasons) {
      if (element == widget.subType) {
        setState(() {
          isEnabled = false;
          selectedComplaintReason = element;
        });
      }
    }
  }

  void submitData() async {
    // https: //test3.hyderabadwater.gov.in/HMWSSBAPI/RegisterGrievanceInMobileApp?CAN=612896017&=2&=test
    var reasonCode = complaintData
        .where((item) => item.complaintReasonName! == selectedComplaintReason)
        .map((item) => item.complaintReasonCode!)
        .toList();
    var postData = {
      "can": LocalStorages.getCanno() ?? '',
      "reasonCode": reasonCode[0],
      "complaintDesc": descriptionController.text.toString(),
      "mobileNo": LocalStorages.getMobileNumber() ?? '',
      "latitude": _currentPosition?.latitude,
      "longitude": _currentPosition?.longitude,
      "image": photoBase64
    };

    try {
      EasyLoading.show(status: "Loading...");
      var response = await NetworkApiService()
          .commonApiCall(url: Api.registerGrievance, data: postData);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  response.data,
                  style: const TextStyle(fontSize: 16),
                ),
                content: const Text(''),
                actions: <Widget>[
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            });
      }
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
            locationSettings: const LocationSettings(accuracy: LocationAccuracy.best))
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {});
  }

  Widget showCameraWidget() {
    // If the selected reason is "SEWERAGE OVERFLOWS-ON THE ROAD", don't show the capture image option
    if (selectedComplaintReason == "SEWERAGE OVERFLOWS-ON THE ROAD") {
      canCapture = false;
      return const SizedBox.shrink(); // This ensures the widget doesn't take any space
    }

    if (selectedComplaintType == "Water Supply" || selectedComplaintType == "Sewerage") {
      if (!notRequiredList.contains(selectedComplaintReason)) {
        canCapture = true;
        return Column(
          children: [
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
                      "assets/images/capture_image.png",
                      height: 200,
                      width: 200,
                      fit: BoxFit.fill,
                    )
                        : Image.memory(
                      _image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        );
      }
    }

    canCapture = false;
    return const SizedBox.shrink();
  }
}
