import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hmwssb/core/api/api.dart';
import 'package:hmwssb/core/api/shared_prefernce.dart';
import 'package:hmwssb/core/constants.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hmwssb/data/models/cans_by_mobile_new.dart';
import 'package:intl/intl.dart';
import 'package:hmwssb/core/api/network.dart';
import 'package:hmwssb/core/camera.dart';
import 'package:hmwssb/core/theme/app_color.dart';
import 'package:hmwssb/data/models/cans_by_mobile.dart';

class MeterFixation extends StatefulWidget {
  const MeterFixation({super.key});

  @override
  State<MeterFixation> createState() => _MeterFixationState();
}

class _MeterFixationState extends State<MeterFixation> {
  Position? _currentPosition;
  dynamic _image;
  dynamic _image1;
  String? photoBase64;
  String? photoBase641;

  void openCamera(context, type) async {
    final image = await CustomCamera.openCamera();
    var base64Data = base64Encode(image);

    setState(() {
      if (type == 1) {
        _image = image;
        photoBase64 = base64Data;
      } else {
        _image1 = image;
        photoBase641 = base64Data;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    determinePosition();
  }

  final GlobalKey<DropdownSearchState<String>> meterMakeKey =
      GlobalKey<DropdownSearchState<String>>();
  final GlobalKey<DropdownSearchState<String>> meterAgencyKey =
      GlobalKey<DropdownSearchState<String>>();

  final TextEditingController meterNoController = TextEditingController();
  final FocusNode meterNoFocus = FocusNode();
  final TextEditingController initialReadingController =
      TextEditingController();
  final FocusNode initialReadingFocus = FocusNode();
  final TextEditingController manufactureDateController =
      TextEditingController();
  final FocusNode manufactureDateFocus = FocusNode();
  final TextEditingController meterIssueDateController =
      TextEditingController();
  final FocusNode meterIssueDateFocus = FocusNode();
  final TextEditingController meterFixedDateController =
      TextEditingController();
  final FocusNode meterFixedDateFocus = FocusNode();
  final TextEditingController makeWarrantyController = TextEditingController();
  final FocusNode makeWarrantyFocus = FocusNode();
  DateTime futureSelectedDate = DateTime.now();
  String modifiedDate = "";
  String selectedMeterMake = "Meter Make";
  String selectedMeterAgency = "Meter Agency";
  String? manufactureDateApi;
  String? meterIssueDateApi;
  String? meterFixedDateApi;
  String? makeWarrantyApi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: primaryColor,
        title: const Text(
          'Meter Fixation',
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
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Can No : ${LocalStorages.getCanno() ?? ''}',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor),
                ),
                Text(
                  "PipeSize : ${LocalStorages.getPipesize()}",
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                maxLength: 15,
                controller: meterNoController,
                focusNode: meterNoFocus,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  counterText: '',
                  border: const OutlineInputBorder(),
                  labelText: 'Enter Meter No *',
                  hintText: 'Enter Meter No *',
                  labelStyle: TextStyle(
                    color: black,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownSearch<String>(
                key: meterMakeKey,
                validator: (v) => v == null ? "required field" : null,
                items: (String? filter, LoadProps? value) {
                  return meterMakeList;
                },
                selectedItem: selectedMeterMake,
                onChanged: (dynamic print) => {
                  setState(() {
                    selectedMeterMake = print!;
                  })
                },
                dropdownBuilder: (context, selectedItem) {
                  return Text(
                    selectedItem ?? " Meter Make *",
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
                        labelText: " Meter Make *",
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
            //     key: meterMakeKey,
            //     validator: (v) => v == null ? "required field" : null,
            //     // hint: " Meter Make *",
            //     mode: Mode.BOTTOM_SHEET,
            //     showSelectedItem: true,
            //     items: meterMakeList,
            //     selectedItem: selectedMeterMake,
            //     // label: " Meter Make *",
            //     showClearButton: false,
            //     onChanged: (dynamic print) => {
            //       setState(() {
            //         selectedMeterMake = print!;
            //       })
            //     },
            //     dropdownSearchDecoration: InputDecoration(
            //         labelText: " Meter Make *",
            //         labelStyle: TextStyle(
            //           fontSize: 14.sp, // Adjust the font size for the label
            //           color: black, // Adjust the color for the label
            //         ),
            //         border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(10.0))),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownSearch<String>(
                key: meterAgencyKey,
                validator: (v) => v == null ? "required field" : null,
                items: (String? filter, LoadProps? value) {
                  return meterAgencies;
                },
                selectedItem: selectedMeterAgency,
                onChanged: (dynamic print) => {
                  setState(() {
                    selectedMeterAgency = print!;
                  })
                },
                dropdownBuilder: (context, selectedItem) {
                  return Text(
                    selectedItem ?? " Meter Agency *",
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
                        labelText: " Meter Agency *",
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
            //     key: meterAgencyKey,
            //     validator: (v) => v == null ? "required field" : null,
            //     // hint: " Meter Agency *",
            //     mode: Mode.BOTTOM_SHEET,
            //     showSelectedItem: true,
            //     items: meterAgencies,

            //     selectedItem: selectedMeterAgency,
            //     // label: "Meter Agency *",

            //     showClearButton: false,
            //     onChanged: (dynamic print) => {
            //       setState(() {
            //         selectedMeterAgency = print!;
            //       })
            //     },
            //     dropdownSearchDecoration: InputDecoration(
            //         labelText: "Meter Agency *",
            //         labelStyle: TextStyle(
            //           fontSize: 14.sp, // Adjust the font size for the label
            //           color: black, // Adjust the color for the label
            //         ),
            //         border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(10.0))),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: manufactureDateController,
                focusNode: manufactureDateFocus,
                textInputAction: TextInputAction.done,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  _selectPastDate(context).then((value) {
                    if (value != null) {
                      setState(() {
                        manufactureDateController.text = value["displayDate"]!; // Display format
                        manufactureDateApi = value["apiDate"]!; // API format
                      });
                    }
                  });
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Manufactured Date',
                  hintText: 'Manufactured Date',
                  labelStyle: TextStyle(
                    color: black,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: meterIssueDateController,
                focusNode: meterIssueDateFocus,
                textInputAction: TextInputAction.done,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  _selectFutureDate(context).then((value) {
                    if (value != null) {
                      setState(() {
                        meterIssueDateController.text = value["displayDate"]!;
                        meterIssueDateApi = value["apiDate"]!;
                      });
                    }
                  });
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Make Issue Date',
                  hintText: 'Make Issue Date',
                  labelStyle: TextStyle(
                    color: black,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: meterFixedDateController,
                focusNode: meterFixedDateFocus,
                textInputAction: TextInputAction.done,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  _selectPastDate(context).then((value) {
                    if (value != null) {
                      setState(() {
                        meterFixedDateController.text = value["displayDate"]!;
                        meterFixedDateApi = value["apiDate"]!;
                      });
                    }
                  });
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Meter Fixed Date',
                  hintText: 'Meter Fixed Date',
                  labelStyle: TextStyle(
                    color: black,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: makeWarrantyController,
                focusNode: makeWarrantyFocus,
                textInputAction: TextInputAction.done,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  _selectFutureDate(context).then((value) {
                    if (value != null) {
                      setState(() {
                        makeWarrantyController.text = value["displayDate"]!;
                        makeWarrantyApi = value["apiDate"]!;
                      });
                    }
                  });
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Make Warranty Date',
                  hintText: 'Make Warranty Date',
                  labelStyle: TextStyle(
                    color: black,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                maxLength: 10,
                controller: initialReadingController,
                focusNode: initialReadingFocus,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  counterText: '',
                  border: const OutlineInputBorder(),
                  labelText: 'Enter Initial Reading  *',
                  hintText: 'Enter Initial Reading  *',
                  labelStyle: TextStyle(
                    color: black,
                    fontSize: 14.sp,
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
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
                            "assets/images/building.png",
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
            const Text("Building Photo",
                style: TextStyle(fontSize: 16, color: primaryColor)),
            const SizedBox(height: 10),
            SizedBox(
              child: GestureDetector(
                onTap: () {
                  openCamera(context, 2);
                },
                child: Center(
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: _image1 == null
                        ? Image.asset(
                            "assets/images/meter.png",
                            height: 200,
                            width: 200,
                            fit: BoxFit.fill,
                          )
                        : Image.memory(_image1, fit: BoxFit.fill),
                  ),
                ),
              ),
            ),
            const Text("Meter Photo",
                style: TextStyle(fontSize: 16, color: primaryColor)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => validate(),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: primaryColor,
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.0),
                child: Text("Submit", style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<Map<String, String>?> _selectPastDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      return {
        "apiDate": DateFormat("yyyy-MM-dd").format(picked), // API format
        "displayDate": DateFormat("dd-MM-yyyy").format(picked), // Display format
      };
    }
    return null;
  }

  Future<Map<String, String>?> _selectFutureDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2045, 8),
    );

    if (picked != null) {
      return {
        "apiDate": DateFormat("yyyy-MM-dd").format(picked), // API format
        "displayDate": DateFormat("dd-MM-yyyy").format(picked), // Display format
      };
    }
    return null;
  }



  validate() {
    if (meterNoController.text.isEmpty) {
      EasyLoading.showInfo("Enter Meter No");
    } else if (selectedMeterMake == "Meter Make") {
      EasyLoading.showInfo("Select Meter Make");
    } else if (selectedMeterMake == "Meter Agency") {
      EasyLoading.showInfo("Select Meter Agency");
    } else if (manufactureDateController.text.isEmpty) {
      EasyLoading.showInfo("Select Manufacture Date");
    } else if (meterIssueDateController.text.isEmpty) {
      EasyLoading.showInfo("Select Make Issue Date");
    } else if (meterFixedDateController.text.isEmpty) {
      EasyLoading.showInfo("Select Meter Fixed Date");
    } else if (makeWarrantyController.text.isEmpty) {
      EasyLoading.showInfo("Select Make Warranty Date");
    } else if (initialReadingController.text.isEmpty) {
      EasyLoading.showInfo("Enter Initial Reading");
    } else if (_currentPosition == null) {
      EasyLoading.showInfo("Receiving GeoCoordinates Please Wait");
      determinePosition();
    } else if (_currentPosition != null && _currentPosition?.latitude == null) {
      determinePosition();
      EasyLoading.showInfo("Receiving GeoCoordinates Please Wait");
    }
    else if (photoBase64 == null) {
      EasyLoading.showInfo("Select Building Photo");
    } else if (photoBase641 == null) {
      EasyLoading.showInfo("Select Meter Photo");
    }
    else {
      submitData();
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
        // print(_currentPosition?.latitude ?? "");
      });
    }).catchError((e) {
      // print(e);
    });
  }

  void submitData() async {
    String finalUrl =
        "${Api.baseWithMobileApp}SaveMeterInformationForCitizenApp"
        "?Can=${LocalStorages.getCanno() ?? ""}"
        "&meterNo=${meterNoController.text}"
        "&capturedBy=${LocalStorages.getMobileNumber() ?? ''}"
        "&mrCode=232322"
        "&meterSize=${LocalStorages.getPipesize() ?? ""}"
        "&meterAgency=$selectedMeterAgency"
        "&meterManufacturedby=$selectedMeterMake"
        "&meterManufacturedDate=${manufactureDateApi ?? ''}"  // ✅ Use API date
        "&makeWarrantyDate=${makeWarrantyApi ?? ''}"  // ✅ Use API date
        "&makeIssuedDate=${meterIssueDateApi ?? ''}"  // ✅ Use API date
        "&meterFixedDate=${meterFixedDateApi ?? ''}"  // ✅ Use API date
        "&initialReading=${initialReadingController.text}"
        "&capturedDate=${DateFormat("dd/MM/yyyy").format(DateTime.now())}"
        "&latitude=${_currentPosition?.latitude}"
        "&longitude=${_currentPosition?.longitude}";

    var postData = {"image": photoBase641, "buildingImage": photoBase64};

    try {
      EasyLoading.show(status: "Loading...");
      var response = await NetworkApiService().commonApiCall(url: finalUrl, data: postData);
      EasyLoading.dismiss();

      if (response.statusCode == 200) {
        var value = cansbymobilenew.fromJson(response.data);

        print("🔹 API Response: ${response.data}");

        if ((value.mItem1?.responseCode ?? "0") == "200") {
          print("✅ API Success: ${value.mItem1?.description}");
          EasyLoading.showInfo(value.mItem1?.description ?? "");
          await Future.delayed(const Duration(milliseconds: 500));

          if (mounted) {
            print("🚀 Navigating back...");
            Navigator.pop(context);
          } else {
            print("❌ Context is not mounted!");
          }
        } else {
          print("⚠ API Error: ${value.mItem1?.description}");
          EasyLoading.showInfo(value.mItem1?.description ?? "");
        }
      }
    } on DioException catch (ex) {
      EasyLoading.dismiss();
      print("❌ Dio Error: ${ex.message}");
      showException(ex);
    }
  }


}
