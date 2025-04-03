import 'package:hmwssb/core/api/shared_prefernce.dart';
import 'package:hmwssb/data/models/otp_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:hmwssb/core/api/api.dart';
import 'package:hmwssb/core/api/network.dart';
import 'package:hmwssb/core/theme/app_color.dart';

// import 'package:hmwssb/data/models/can_info_model.dart' as canInfo;
// import 'package:hmwssb/data/models/cans_by_mobile.dart' as cansByMobile;

class TankerBooking extends StatefulWidget {
  final List<String> capacityList;

  const TankerBooking({
    super.key,
    this.capacityList = const <String>[],
  });

  @override
  State<TankerBooking> createState() => _TankerBookingState();
}

class _TankerBookingState extends State<TankerBooking> {
  late GoogleMapController _controller;

  final Set<Marker> _markers = {};

  final TextEditingController otpController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  var otp = "-1";
  // SharedPreferences? pref;
  int _selectedOption = 0; // 0 means no option is selected

  void _selectOption(int option) {
    setState(() {
      _selectedOption = option;
    });
  }

  late LatLng _currentPosition;

  DateTime? _selectedDateTime;

  bool _isButtonEnabled = false;

  // Future<void> _selectDateTime(BuildContext context) async {
  //   final DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now().add(const Duration(days: 1)),
  //     firstDate: DateTime.now(),
  //     lastDate: DateTime.now().add(const Duration(days: 10)),
  //   );

  //   if (pickedDate != null) {
  //     final TimeOfDay? pickedTime = await showTimePicker(
  //       context: context,
  //       initialTime: TimeOfDay.now(),
  //     );

  //     if (pickedTime != null) {
  //       setState(() {
  //         _selectedDateTime = DateTime(
  //           pickedDate.year,
  //           pickedDate.month,
  //           pickedDate.day,
  //           pickedTime.hour,
  //           pickedTime.minute,
  //         );
  //         dateController.text = _formatDateTime(_selectedDateTime);
  //       });
  //     }
  //   }
  // }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime initialDate = now.add(const Duration(days: 1));
    final DateTime firstDate = now;
    final DateTime lastDate = now.add(const Duration(days: 10));

    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate);

    if (pickedDate != null) {
      final TimeOfDay? pickedTime =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());

      if (pickedTime != null) {
        final DateTime selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute);

        if (pickedDate.day == now.day &&
            pickedDate.month == now.month &&
            pickedDate.year == now.year &&
            selectedDateTime.isBefore(now)) {
          EasyLoading.showToast(
              'Note: You cannot select a past time for todays date.',
              toastPosition: EasyLoadingToastPosition.bottom);
          setState(() {
            dateController.clear();
          });
        } else {
          setState(() {
            _selectedDateTime = selectedDateTime;
            dateController.text = _formatDateTime(_selectedDateTime);
          });
        }
      }
    }
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    return DateFormat('dd-MM-yyyy HH:mm').format(dateTime);
  }

  @override
  void initState() {
    super.initState();
    initPreferences();
    dateController.addListener(_checkFields);
    otpController.addListener(_checkFields);
  }

  void _checkFields() {
    setState(() {
      // Enable the button only if all three fields have content
      _isButtonEnabled = otpController.text.isNotEmpty &&
          dateController.text.isNotEmpty &&
          _selectedOption != 0 &&
          otp != "-1";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: primaryColor,
        title: const Text(
          'Book Tanker',
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
      body: Column(
        children: <Widget>[
          // Google Map
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    _currentPosition.latitude, _currentPosition.longitude),
                zoom: 14,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
                _controller.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: LatLng(_currentPosition.latitude,
                          _currentPosition.longitude),
                      zoom: 14,
                    ),
                  ),
                );
              },
              liteModeEnabled: true,
              markers: _markers,
              mapType: MapType.terrain,
            ),
          ),
          // Overlaying UI elements on top of the map
          Card(
            color: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  const Center(
                    child: Text(
                      'Book Water Tanker',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal),
                    ),
                  ),

                  Text(LocalStorages.getAddress() ?? "",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  // Tanker options/**/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      if (widget.capacityList.contains("3"))
                        SelectableTankerOption(
                          liters: '2.5KL',
                          price: "",
                          isSelected: _selectedOption == 1,
                          onTap: () {
                            _selectOption(1);
                            _checkFields();
                          },
                        ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (widget.capacityList.contains("1"))
                        SelectableTankerOption(
                          liters: '5KL',
                          price: "",
                          isSelected: _selectedOption == 2,
                          onTap: () {
                            _selectOption(2);
                            _checkFields();
                          },
                        ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (widget.capacityList.contains("2"))
                        SelectableTankerOption(
                          liters: '10KL',
                          price: '',
                          isSelected: _selectedOption == 3,
                          onTap: () {
                            _selectOption(3);
                            _checkFields();
                          },
                        ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () => _selectDateTime(context),
                          child: AbsorbPointer(
                            child: TextField(
                              controller: dateController,
                              decoration: const InputDecoration(
                                labelText: "Select Booking Date and Time",
                                border: OutlineInputBorder(),
                              ),
                              readOnly: true,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: () {
                            // Action when Send OTP is pressed
                            getOtpForBooking();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor, // Button color
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            otp == "-1" ? "Get Otp" : "Resend Otp",
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: otpController,
                          maxLength: 4,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: false),
                          textInputAction: TextInputAction.done,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter Otp *',
                            hintText: 'Enter Otp *',
                            counterText: '',
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: _isButtonEnabled
                              ? () {
                                  if (otp != otpController.text.toString()) {
                                    EasyLoading.showInfo("Invalid OTP");
                                  } else {
                                    bookTanker();
                                  }
                                }
                              : null,
                          // Disable the button when not enabled
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor, // Button color
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Book Tanker',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // OTP input and button
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void initPreferences() async {
    // Fetch latitude and longitude from local storage
    double latitude =
        double.tryParse((LocalStorages.getLatitude() ?? '0.0').toString()) ??
            0.0;
    double longitude =
        double.tryParse((LocalStorages.getLongitude() ?? '0.0').toString()) ??
            0.0;

    // Initialize _currentPosition with valid values
    _currentPosition = LatLng(latitude, longitude);

    // Update the marker position in the UI
    setState(() {
      _addMarker();
    });
  }

  getOtpForBooking() async {
    try {
      EasyLoading.show(status: "Loading...");
      var response = await NetworkApiService()
          .commonApiCall(url: Api.getOtpBooking, data: {
        'can': LocalStorages.getCanno() ?? "",
        'mobileno': LocalStorages.getMobileNumber() ?? ""
      });
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var value = OtpResponse.fromJson(response.data);
        if ((value.mItem1?.responseCode ?? "0") == "200") {
          setState(() {
            otp = value.mItem2!;
          });
        } else {
          EasyLoading.showError(
              value.mItem1?.description ?? "An error 0ccured");
        }
      }
    } on DioException catch (ex) {
      EasyLoading.dismiss();
      showException(ex);
    }
  }

  bookTanker() async {
    try {
      var option = "0";
      if (_selectedOption == 1) {
        option = "3";
      } else if (_selectedOption == 2) {
        option = "1";
      } else {
        option = "2";
      }

      /*bool isChecked = false;

      // Show dialog to determine IsRWHChecked before the API call
      await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: const Text("Important Information"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Building has no pit. It will cost more."),
                    Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: (value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                        const Text("I understand"),
                      ],
                    ),
                  ],
                ),
                actions: <Widget>[
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                    },
                    child: const Text('Ok'),
                  ),
                ],
              );
            },
          );
        },
      );*/

      EasyLoading.show(status: "Loading...");

// Fetch current and movable lat-long values
      final latitude = LocalStorages.getLatitude() ?? '';
      final longitude = LocalStorages.getLongitude() ?? '';
      final movableLatitude = LocalStorages.getMovLatitude() ?? '';
      final movableLongitude = LocalStorages.getMovLongitude() ?? '';
      // print("Previous Movable Latitude: $movableLatitude");
      // print("Previous Movable Longitude: $movableLongitude");
      // print("Current Latitude: $latitude");
      // print("Current Longitude: $longitude");
// Compare lat-long values and determine if they are updated
      int isLatLongUpdated = 1; // Default value is 1, indicating no change
      if (LocalStorages.getLatLongEdit() == 1) {
        // Check if latitude and longitude are different from movable values
        if (latitude != movableLatitude || longitude != movableLongitude) {
          isLatLongUpdated = 0; // Update to 0 if lat-long values have changed
          // print("Updated Movable Latitude: $latitude");
          // print("Updated Movable Longitude: $longitude");

          // Update movable lat-long values in local storage
          LocalStorages.saveUserData(
            localSaveType: LocalSaveType.latitude,
            value: latitude.toString(),
          );
          LocalStorages.saveUserData(
            localSaveType: LocalSaveType.longitude,
            value: longitude.toString(),
          );
        }
      } else {
        // If lat-long is not editable, do not go inside the condition
        // print("Lat-Long editing is disabled. Skipping the update.");
      }
      // print("Final IsLatLongUpdated Value: $isLatLongUpdated");

// Perform API call
      var response = await NetworkApiService().commonApiCall(
        url: Api.bookTanker,
        data: {
          'can': LocalStorages.getCanno() ?? "",
          'capacity': option,
          'withMotor': '0',
          'requiredDateTime': dateController.text.trim(),
          'latitude': latitude,
          'longitude': longitude,
          "IsRWHChecked": 'N',
          //isChecked ? "Y" : "N",
          "IsLatLongUpdated": isLatLongUpdated,
          "sourceChannel": "CitizensApp",
        },
      );

      EasyLoading.dismiss();

      if (response.statusCode == 200) {
        //var responseData = cansByMobile.MItem2.fromJson(response.data);
        // print(response.data);

        // Show the appropriate response dialog
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                response.data.toString(),
                style: const TextStyle(fontSize: 16),
              ),
              actions: <Widget>[
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text('Ok'),
                ),
              ],
            );
          },
        );
      }
    } on DioException catch (ex) {
      EasyLoading.dismiss();
      showException(ex);
    }
  }

  void _addMarker() async {
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('newMarker'),
          position: LatLng(
              _currentPosition.latitude,
              _currentPosition
                  .longitude), // A new position near the initial one
        ),
      );
    });
  }
}

class SelectableTankerOption extends StatelessWidget {
  final String liters;
  final String price;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableTankerOption({
    super.key,
    required this.liters,
    required this.price,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
            decoration: BoxDecoration(
              color: isSelected ? Colors.green : Colors.white,
              border:
                  Border.all(color: isSelected ? primaryColor : Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/tanker.png',
                  height: 60,
                ),
                const SizedBox(width: 5),
                Text(liters,
                    style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ],
            )),
      ),
    );
  }
}
