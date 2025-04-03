import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:group_button/group_button.dart';
import 'package:hmwssb/core/api/api.dart';
import 'package:hmwssb/core/api/network.dart';
import 'package:hmwssb/core/camera.dart';
import 'package:hmwssb/core/theme/app_color.dart';
import 'package:hmwssb/presentation/rwh/model/edit_pits_update_model.dart';
import 'package:hmwssb/presentation/rwh/model/get_pits_details_model.dart';
import 'package:hmwssb/presentation/rwh/ui/radio_tile.dart';

class EditPitsScreen extends StatefulWidget {
  const EditPitsScreen({
    required this.getSurveyPits,
    required this.position,
    super.key,
  });

  final GetSurveyPits? getSurveyPits;
  final Position? position;

  @override
  State<EditPitsScreen> createState() => _EditPitsScreenState();
}

class _EditPitsScreenState extends State<EditPitsScreen> {
  Position? _currentPosition;

  GroupButtonController workController = GroupButtonController();
  final List<String> _yesNoOptions = [
    'Yes',
    'No',
  ];
  int rwhWorkingIndex = 0;

  dynamic _image;
  String? pitPhoto;

  final TextEditingController lengthController = TextEditingController();
  final TextEditingController breadthController = TextEditingController();
  final TextEditingController widthController = TextEditingController();

  void openCamera() async {
    final image = await CustomCamera.openCamera();
    String base64Data = base64Encode(image);

    setState(() {
      _image = image;
      pitPhoto = base64Data;
    });
  }

  @override
  void initState() {
    super.initState();
    lengthController.text = widget.getSurveyPits?.rwhLength ?? '';
    breadthController.text = widget.getSurveyPits?.rwhBreadth ?? '';
    widthController.text = widget.getSurveyPits?.rwhDepth ?? '';
    rwhWorkingIndex = widget.getSurveyPits?.rwhWorkingStatus == 'Yes' ? 0 : 1;
    workController.selectIndex(rwhWorkingIndex);
    _currentPosition = widget.position;
  }

  @override
  Widget build(BuildContext context) {
    return _getPitsDimension();
  }

  Widget _getPitsDimension() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: primaryColor,
        title: const Text(
          'Rainwater Harvest Pit',
          style: TextStyle(
            color: white,
            fontSize: 20,
          ),
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
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Dimensions of RWH",
              style: TextStyle(fontSize: 18, color: primary),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          controller: lengthController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: false),
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Length (ft)*',
                            hintText: 'Enter Length*',
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: false),
                          controller: breadthController,
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Breadth (ft)*',
                            hintText: 'Enter Breadth*',
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: false),
                          controller: widthController,
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Depth (ft)*',
                            hintText: 'Enter Depth* ',
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Status of Existing RWHS Working Condition*",
                  style: TextStyle(fontSize: 18, color: primary),
                ),
              ),
              GroupButton(
                controller: workController,
                isRadio: true,
                options:
                    const GroupButtonOptions(groupingType: GroupingType.column),
                buttons: _yesNoOptions,
                buttonIndexedBuilder: (selected, index, context) {
                  return RadioTile(
                    title: _yesNoOptions[index],
                    selected: workController.selectedIndex,
                    index: index,
                    onTap: () {
                      workController.selectIndex(index);
                      setState(() {
                        rwhWorkingIndex = index;
                      });
                    },
                  );
                },
              ),
              Column(
                children: [
                  SizedBox(
                    child: GestureDetector(
                      onTap: () {
                        openCamera();
                      },
                      child: Center(
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: _image == null
                              ? Image.asset(
                                  "assets/images/water_harvest.png",
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
                  const Text(
                    "Pit Photo",
                    style: TextStyle(fontSize: 16, color: primary),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => validatePitsDetails(),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: primary, // Text color
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text("Submit", style: TextStyle(color: Colors.white)),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void validatePitsDetails() async {
    if (lengthController.text.toString().isEmpty) {
      EasyLoading.showInfo("Enter Length for Pit ");
      return; // Stop further validation after showing the first error
    }
    if (breadthController.text.toString().isEmpty) {
      EasyLoading.showInfo("Enter Breadth for Pit ");
      return;
    }
    if (widthController.text.toString().isEmpty) {
      EasyLoading.showInfo("Enter Depth for Pit ");
      return;
    }

    if (pitPhoto?.isEmpty ?? true) {
      EasyLoading.showInfo("Select PIT Photo for Pit ");
      return;
    }

    if (_currentPosition == null) {
      EasyLoading.showInfo("Receiving GeoCoordinates, Please Wait");
      determinePosition();
      return;
    }

    if (_currentPosition?.latitude == null) {
      determinePosition();
      EasyLoading.showInfo("Receiving GeoCoordinates, Please Wait");
      return;
    }

    // Continue with the next steps if validation is successful
    else {
      await savePitsDetailsApiCall();
    }
  }

  Future<void> savePitsDetailsApiCall() async {
    isLoadData(true);
    EasyLoading.show(status: 'Loading...');

    RWHPitsDetailsUpdateModel pitsData = RWHPitsDetailsUpdateModel(
      id: widget.getSurveyPits?.id ?? 0,
      rwhLength: int.tryParse(lengthController.text.trim()) ?? 0,
      rwhBreadth: int.tryParse(breadthController.text.trim()) ?? 0,
      rwhDepth: int.tryParse(widthController.text.trim()) ?? 0,
      rwhWorkingStatus: rwhWorkingIndex == 0 ? 'Yes' : 'No',
      latitude: _currentPosition?.latitude ?? 0.0,
      longitude: _currentPosition?.longitude ?? 0.0,
      updateReason: '',
      image: pitPhoto,
    );
    try {
      final Response response = await NetworkApiService().commonApiCall(
        url: Api.editSurveyPitsUrl,
        data: pitsData.toJson(),
      );
      EasyLoading.dismiss();
      isLoadData(false);
      if (response.statusCode == 200 && response.data['error'] == 0) {
        EasyLoading.showSuccess(response.data['message'].toString());
      } else {
        EasyLoading.showError(response.data['message'].toString());
      }

      Navigator.pop(context);
      Navigator.pop(context);
    } on DioException catch (ex) {
      EasyLoading.dismiss();
      isLoadData(false);
      Navigator.pop(context);
      Navigator.pop(context);
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
      return Future.error('Location permissions are denied');
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Geolocator.getCurrentPosition(
                locationSettings:
                    const LocationSettings(accuracy: LocationAccuracy.best))
            .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    })
        // .catchError((e) {
        //   print(e);
        // })
        ;
  }

  bool isLoading = false;
  void isLoadData(bool val) {
    setState(() {
      isLoading = val;
    });
  }
}
