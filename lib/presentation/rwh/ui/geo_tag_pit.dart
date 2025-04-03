import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hmwssb/core/api/shared_prefernce.dart';
import 'package:hmwssb/core/theme/app_color.dart';
import 'package:hmwssb/presentation/rwh/model/pits_save_post_model.dart';
import 'package:hmwssb/presentation/rwh/model/save_survey_details_post_model.dart';
import 'package:hmwssb/presentation/rwh/ui/radio_tile.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:group_button/group_button.dart';
import 'package:hmwssb/core/api/api.dart';
import 'package:hmwssb/core/api/network.dart';
import 'package:hmwssb/core/camera.dart';

class GeoTag extends StatefulWidget {
  const GeoTag({super.key});

  @override
  State<GeoTag> createState() => _GeoTagState();
}

class _GeoTagState extends State<GeoTag> {
  final GlobalKey<DropdownSearchState<String>> houseTypeKey =
      GlobalKey<DropdownSearchState<String>>();
  GroupButtonController rwhController = GroupButtonController();
  // GroupButtonController workController = GroupButtonController();

  final TextEditingController plotController = TextEditingController();

  // final TextEditingController lengthController = TextEditingController();
  // final TextEditingController breadthController = TextEditingController();
  // final TextEditingController widthController = TextEditingController();

  final TextEditingController remarksController = TextEditingController();
  final TextEditingController borewellsController = TextEditingController();
  final TextEditingController noOfPitsController = TextEditingController();
  final TextEditingController tankersRequiredController =
      TextEditingController();
  final TextEditingController minDepthController = TextEditingController();
  final TextEditingController maxDepthController = TextEditingController();
  final TextEditingController workingBorewell = TextEditingController();

  final List<GroupButtonController> workController = <GroupButtonController>[];
  final List<TextEditingController> lengthController =
      <TextEditingController>[];
  final List<TextEditingController> breadthController =
      <TextEditingController>[];
  final List<TextEditingController> widthController = <TextEditingController>[];
  List<int> rwhWorkingIndex = <int>[];
  List<dynamic> selectedPitsImagesData = <dynamic>[];
  List<String> storedPitsImagesData = <String>[];

  Position? _currentPosition;
  dynamic _image;
  // dynamic _image1;
  String? buildingPhoto;
  // String? photoBase641;
  bool isRwhPresent = true;
  int rwhIndex = 0;
  // int rwhWorkingIndex = 0;
  String selectedHouseType = 'Select House Type';
  final List<String> _yesNoOptions = [
    'Yes',
    'No',
  ];
  bool isValidated = false;
  final List<String> _houseTypeOptions = [
    'Individual',
    'Apartment',
    'Commercial'
  ];
  String finalString = '';
  int isCan = 0;
  bool canVisible = false;

  // SharedPreferences? pref;

  void openCamera() async {
    final image = await CustomCamera.openCamera();
    String base64Data = base64Encode(image);

    setState(() {
      _image = image;
      buildingPhoto = base64Data;
    });
  }

  void openPitsCamera({required int index}) async {
    final image = await CustomCamera.openCamera();
    String base64Data = base64Encode(image);

    setState(() {
      selectedPitsImagesData[index] = image;
      storedPitsImagesData[index] = base64Data;
    });
  }

  @override
  void initState() {
    super.initState();
    determinePosition();
    rwhController.selectIndex(0);
  }

  bool isPitsForm = false;

  bool isLoading = false;
  void isLoadData(bool val) {
    setState(() {
      isLoading = val;
    });
  }

  Future<bool> saveSurveyDetailsApiCall() async {
    isLoadData(true);
    EasyLoading.show(status: 'Loading...');
    String rwhExists = "";

    if (rwhIndex == 0) {
      rwhExists = "Yes";
    } else {
      rwhExists = "No";
    }
    try {
      RWHSurveyDetailsPostModel postData = RWHSurveyDetailsPostModel(
        canNumber: LocalStorages.getCanno() ?? '',
        plotArea: plotController.text.trim(),
        houseType: selectedHouseType,
        latitude: _currentPosition?.latitude,
        longitude: _currentPosition?.longitude,
        noOfBorewells: int.tryParse(borewellsController.text.trim()) ?? 0,
        noOfBorewellsWorking: int.tryParse(workingBorewell.text.trim()) ?? 0,
        borewellMinDepth: int.tryParse(minDepthController.text.trim()) ?? 0,
        borewellMaxDepth: int.tryParse(maxDepthController.text.trim()) ?? 0,
        noOfTankersRequired:
            int.tryParse(tankersRequiredController.text.trim()) ?? 0,
        tankersBooked: 0,
        // bookedByYou: bookedByYou,
        rwhExists: rwhExists,
        noOfPits: int.tryParse(noOfPitsController.text.trim()) ?? 0,
        buildingImage: buildingPhoto ?? '',
      );
      final Response response = await NetworkApiService().commonApiCall(
        url: Api.saveSurveyUrl,
        data: postData.toJson(),
      );
      if (response.statusCode == 200 && response.data['error'] == 0) {
        if (noOfPitsController.text.trim().isNotEmpty) {
          setState(() {
            isPitsForm = true;
          });
        } else {
          Navigator.pop(context);
        }
        EasyLoading.dismiss();
        isLoadData(false);
        EasyLoading.showSuccess(response.data['message'].toString());
        return true;
      } else {
        EasyLoading.dismiss();
        isLoadData(false);
        Navigator.pop(context);
        EasyLoading.showError(response.data['message'].toString());
        return false;
      }
    } on DioException catch (ex) {
      EasyLoading.dismiss();
      isLoadData(false);
      Navigator.pop(context);
      showException(ex);
      return false;
    }
  }

  void addControllers() {
    int lengthOfPits = int.tryParse(noOfPitsController.text.trim()) ?? 1;
    // Clear previous controllers if needed
    workController.clear();
    lengthController.clear();
    breadthController.clear();
    widthController.clear();
    selectedPitsImagesData.clear();
    storedPitsImagesData.clear();
    rwhWorkingIndex.clear();

    for (int idx = 0; idx < lengthOfPits; idx++) {
      workController.add(GroupButtonController());
      lengthController.add(TextEditingController());
      breadthController.add(TextEditingController());
      widthController.add(TextEditingController());
      rwhWorkingIndex.add(idx);
      selectedPitsImagesData.add(null);
      storedPitsImagesData.add('');
      workController[idx].selectIndex(0);
    }
  }

  List<SurveyPits> surveyPitsList() {
    List<SurveyPits> pits = [];
    if (isRwhPresent) {
      int lengthOfPits = int.tryParse(noOfPitsController.text.trim()) ?? 1;
      for (int idx = 0; idx < lengthOfPits; idx++) {
        String rwhWorkExists = "";
        if (rwhWorkingIndex[idx] == 0) {
          rwhWorkExists = "Yes";
        } else {
          rwhWorkExists = "No";
        }

        pits.add(SurveyPits(
          rwhLength: int.tryParse(lengthController[idx].text.trim()) ?? 0,
          rwhBreadth: int.tryParse(breadthController[idx].text.trim()) ?? 0,
          rwhDepth: int.tryParse(widthController[idx].text.trim()) ?? 0,
          rwhWorkingStatus: rwhWorkExists,
          latitude: _currentPosition?.latitude ?? 0.0,
          longitude: _currentPosition?.longitude ?? 0.0,
          image: storedPitsImagesData[idx],
        ));
      }
      return pits;
    }
    return pits;
  }

  Future<void> savePitsDetailsApiCall() async {
    isLoadData(true);
    EasyLoading.show(status: 'Loading...');

    RWHPitsDetailsPostModel pitsData = RWHPitsDetailsPostModel(
        canNumber: LocalStorages.getCanno() ?? '',
        surveyPits: surveyPitsList());
    try {
      final Response response = await NetworkApiService().commonApiCall(
        url: Api.saveSurveyPitsUrl,
        data: pitsData.toJson(),
      );
      if (response.statusCode == 200 && response.data['error'] == 0) {
        EasyLoading.showSuccess(response.data['message'].toString());
      } else {
        EasyLoading.showError(response.data['message'].toString());
      }
      EasyLoading.dismiss();
      isLoadData(false);
      Navigator.pop(context);
    } on DioException catch (ex) {
      EasyLoading.dismiss();
      isLoadData(false);
      showException(ex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        //   appBar: AppBar(
        //     automaticallyImplyLeading: true,
        //     backgroundColor: primaryColor,
        //     title: const Text(
        //       'Rainwater Harvest Pit',
        //       style: TextStyle(
        //         color: white,
        //         fontSize: 20,
        //       ),
        //     ),
        //     leading: IconButton(
        //       icon: const Icon(
        //         Icons.arrow_back,
        //         color: Colors.white,
        //       ),
        //       onPressed: () {
        //         Navigator.pop(context);
        //       },
        //     ),
        //   ),
        //   body:
        isLoading
            ? const SizedBox.shrink()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    isPitsForm
                        ? _getPitsDimension()
                        : Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownSearch<String>(
                                  key: houseTypeKey,
                                  validator: (v) =>
                                      v == null ? "required field" : null,
                                  items: (String? filter, LoadProps? value) {
                                    return _houseTypeOptions;
                                  },
                                  selectedItem: selectedHouseType,
                                  onChanged: (dynamic print) =>
                                      {selectedHouseType = print!},
                                  dropdownBuilder: (context, selectedItem) {
                                    return Text(
                                      selectedItem ?? " House Type*",
                                      style: TextStyle(
                                        fontSize: 14
                                            .sp, // Adjust the font size for the label
                                        color:
                                            black, // Adjust the color for the label
                                      ),
                                    );
                                  },
                                  popupProps: PopupProps.bottomSheet(
                                    bottomSheetProps: const BottomSheetProps(
                                        backgroundColor: Colors.white),
                                    searchFieldProps: TextFieldProps(
                                      decoration: InputDecoration(
                                          labelText: " House Type*",
                                          labelStyle: TextStyle(
                                            fontSize: 18
                                                .sp, // Adjust the font size for the label
                                            color:
                                                black, // Adjust the color for the label
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0))),
                                    ),
                                  ),
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: DropdownSearch<String>(
                              //       key: houseTypeKey,
                              //       validator: (v) =>
                              //           v == null ? "required field" : null,
                              //       hint: " House Type*",
                              //       mode: Mode.BOTTOM_SHEET,
                              //       showSelectedItem: true,
                              //       items: _houseTypeOptions,
                              //       label: " House Type*",
                              //       showClearButton: false,
                              //       onChanged: (dynamic print) =>
                              //           {selectedHouseType = print!}),
                              // ),

                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextField(
                                  controller: plotController,
                                  textInputAction: TextInputAction.done,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Plot Area*',
                                    hintText: 'Enter Plot Area(sq mts)*',
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9.]'))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextField(
                                  controller: tankersRequiredController,
                                  textInputAction: TextInputAction.done,
                                  maxLength: 4,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: false),
                                  decoration: const InputDecoration(
                                    counterText: '',
                                    border: OutlineInputBorder(),
                                    labelText:
                                        'No of Tankers Required Per Month*',
                                    hintText:
                                        'No of Tankers Required Per Month*',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextField(
                                  controller: borewellsController,
                                  textInputAction: TextInputAction.done,
                                  maxLength: 4,
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: false),
                                  decoration: const InputDecoration(
                                    counterText: '',
                                    border: OutlineInputBorder(),
                                    labelText: 'No of Bore Wells *',
                                    hintText: 'No of Bore Wells *',
                                  ),
                                ),
                              ),

                              borewellsDepth(),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Whether RWH Structure*",
                                  style:
                                      TextStyle(fontSize: 18, color: primary),
                                ),
                              ),
                              GroupButton(
                                controller: rwhController,
                                isRadio: true,
                                options: const GroupButtonOptions(
                                    groupingType: GroupingType.column),
                                buttons: _yesNoOptions,
                                buttonIndexedBuilder:
                                    (selected, index, context) {
                                  return RadioTile(
                                    title: _yesNoOptions[index],
                                    selected: rwhController.selectedIndex,
                                    index: index,
                                    onTap: () {
                                      rwhController.selectIndex(index);
                                      setState(() {
                                        rwhIndex = index;
                                        if (rwhIndex == 0) {
                                          isRwhPresent = true;
                                        } else {
                                          isRwhPresent = false;
                                        }
                                      });
                                    },
                                  );
                                },
                              ),
                              noOfPits(),
                              // _getDimension(),
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
                                  const Text(
                                    "Building Photo",
                                    style:
                                        TextStyle(fontSize: 16, color: primary),
                                  ),
                                ],
                              ),
                              // _setPitPhoto(),
                            ],
                          ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => isPitsForm
                          ? validatePitsDetails()
                          : validateSurveyDetails(),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: primary, // Text color
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text("Submit",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
                // ),
              );
  }

  void validateSurveyDetails() async {
    if (selectedHouseType == "Select House Type") {
      EasyLoading.showInfo("Select House Type");
      return;
    }
    if (plotController.text.toString().isEmpty) {
      EasyLoading.showInfo("Enter Plot Area (sqmtrs)");
      return;
    }
    if (tankersRequiredController.text.toString().isEmpty) {
      EasyLoading.showInfo("Enter Required Tankers");
      return;
    }
    if (borewellsController.text.toString().isEmpty) {
      EasyLoading.showInfo("Enter No of Borewells");
      return;
    }
    if (borewellsController.text.toString() == "1" &&
        maxDepthController.text.toString().isEmpty) {
      EasyLoading.showInfo("Enter Borewell Maxdepth");
      return;
    }
    if (int.parse(borewellsController.text.toString()) > 1 &&
        (maxDepthController.text.toString().isEmpty ||
            minDepthController.text.isEmpty)) {
      EasyLoading.showInfo("Enter Borewell Min and Max Depth");
      return;
    }
    if (int.parse(borewellsController.text.toString()) > 1 &&
        (int.parse(maxDepthController.text.toString())) <
            (int.parse(minDepthController.text.toString()))) {
      EasyLoading.showInfo("Max depth should be greater than min depth");
      return;
    }
    if (int.parse(borewellsController.text.toString()) > 0 &&
        workingBorewell.text.toString().isEmpty) {
      EasyLoading.showInfo("Enter Working Borewells count");
      return;
    }
    if (int.parse(borewellsController.text.toString()) > 0 &&
        int.parse(borewellsController.text.toString()) <
            int.parse(workingBorewell.text.toString())) {
      EasyLoading.showInfo(
          "Working Borewells should not be greater than total borewells");
      return;
    }
    if (rwhIndex == 0 && noOfPitsController.text.toString().isEmpty) {
      EasyLoading.showInfo("Enter No Of Pits");
      return;
    }
    if (buildingPhoto == null) {
      EasyLoading.showInfo("Select Building Photo");
      return;
    }
    if (_currentPosition == null) {
      EasyLoading.showInfo("Receiving GeoCoordinates Please Wait");
      determinePosition();
      return;
    }
    if (_currentPosition != null && _currentPosition?.latitude == null) {
      determinePosition();
      EasyLoading.showInfo("Receiving GeoCoordinates Please Wait");
      return;
    } else {
      addControllers();
      await saveSurveyDetailsApiCall();
    }
  }

  void validatePitsDetails() async {
    int lengthOfPits = int.tryParse(noOfPitsController.text.trim()) ?? 1;

    for (int idx = 0; idx < lengthOfPits; idx++) {
      if (isRwhPresent && (lengthController[idx].text.toString().isEmpty)) {
        EasyLoading.showInfo("Enter Length for Pit ${idx + 1}");
        return; // Stop further validation after showing the first error
      }
      if (isRwhPresent && (breadthController[idx].text.toString().isEmpty)) {
        EasyLoading.showInfo("Enter Breadth for Pit ${idx + 1}");
        return;
      }
      if (isRwhPresent && (widthController[idx].text.toString().isEmpty)) {
        EasyLoading.showInfo("Enter Depth for Pit ${idx + 1}");
        return;
      }
      if (isRwhPresent && (selectedPitsImagesData[idx] == null)) {
        EasyLoading.showInfo("Select PIT Photo for Pit ${idx + 1}");
        return;
      }
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

  // validate() {
  //   if (_currentPosition == null) {
  //     EasyLoading.showInfo("Receiving GeoCoordinates Please Wait");
  //     determinePosition();
  //     return;
  //   }
  //   if (_currentPosition != null && _currentPosition?.latitude == null) {
  //     EasyLoading.showInfo("Receiving GeoCoordinates Please Wait");
  //     determinePosition();
  //     return;
  //   }
  //   if (selectedHouseType == "Select House Type") {
  //     EasyLoading.showInfo("Select House Type");
  //     return;
  //   }
  //   if (plotController.text.toString().isEmpty) {
  //     EasyLoading.showInfo("Enter Plot Area");
  //     return;
  //   }
  //   if (isRwhPresent && lengthController.text.toString().isEmpty) {
  //     EasyLoading.showInfo("Enter Length");
  //     return;
  //   }
  //   if (isRwhPresent && breadthController.text.toString().isEmpty) {
  //     EasyLoading.showInfo("Enter Breadth");
  //     return;
  //   }
  //   if (isRwhPresent && widthController.text.toString().isEmpty) {
  //     EasyLoading.showInfo("Enter Depth");
  //     return;
  //   }
  //   if (buildingPhoto == null) {
  //     EasyLoading.showInfo("Select Building Photo");
  //     return;
  //   }
  //   //   if (isRwhPresent && photoBase641 == null) {
  //   //   EasyLoading.showInfo("Select PIT Photo");
  //   // }
  //   else {
  //     submit();
  //   }
  // }

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

        // print(_currentPosition?.latitude ?? "");
      });
    })
        // .catchError((e) {
        //   print(e);
        // })
        ;
  }

  // submit() async {
  //   dynamic response;
  //   var rwhExists = "";
  //   var rwhWorkExists = "";
  //   if (rwhIndex == 0) {
  //     rwhExists = "Yes";
  //   } else {
  //     rwhExists = "No";
  //   }
  //   if (rwhWorkingIndex == 0) {
  //     rwhWorkExists = "Yes";
  //   } else {
  //     rwhWorkExists = "No";
  //   }
  //   // SharedPreferences pref = await SharedPreferences.getInstance();
  //   try {
  //     var postData = {
  //       "can_number": LocalStorages.getCanno() ?? '',
  //       "plot_area": plotController.text.toString(),
  //       "house_type": selectedHouseType,
  //       "rwh_exists": rwhExists,
  //       "rwh_length": lengthController.text.toString(),
  //       "rwh_breadth": breadthController.text.toString(),
  //       "rwh_depth": widthController.text.toString(),
  //       "rwh_working_status": rwhWorkExists,
  //       "latitude": _currentPosition?.latitude,
  //       "longitude": _currentPosition?.longitude,
  //       "building_image": photoBase64,
  //       "image": photoBase641,
  //     };
  //     EasyLoading.show(status: "Loading...");
  //     response = await NetworkApiService().commonApiCall(
  //         url: Api.baseurlRwh, data: postData, isPostMethod: true);
  //     EasyLoading.dismiss();
  //     if (response.statusCode == 200) {
  //       var value = SubmitResponse.fromJson(response.data);
  //       if (value.error == 0) {
  //         EasyLoading.showSuccess(value.message ?? "");
  //         Navigator.pop(context);
  //       } else {
  //         EasyLoading.showSuccess(value.message ?? "");
  //       }
  //     }
  //   } on DioException catch (ex) {
  //     EasyLoading.dismiss();
  //     showException(ex);
  //   }
  // }

  Widget _getPitsDimension() {
    if (isRwhPresent) {
      int lengthOfPits = int.tryParse(noOfPitsController.text.trim()) ?? 1;
      log("lengthOfPits $lengthOfPits");
      return Column(
        children: [
          const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Dimensions of RWH",
                style: TextStyle(fontSize: 18, color: primary),
              )),
          Column(
            children: List<Widget>.generate(lengthOfPits, (int idx) {
              return Column(
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
                              controller: lengthController[idx],
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: false),
                              textInputAction: TextInputAction.done,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Length (ft)*',
                                hintText: 'Enter Length*',
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9.]'))
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: false),
                              controller: breadthController[idx],
                              textInputAction: TextInputAction.done,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Breadth (ft)*',
                                hintText: 'Enter Breadth*',
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9.]'))
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: false),
                              controller: widthController[idx],
                              textInputAction: TextInputAction.done,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Depth (ft)*',
                                hintText: 'Enter Depth* ',
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9.]'))
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
                    controller: workController[idx],
                    isRadio: true,
                    options: const GroupButtonOptions(
                        groupingType: GroupingType.column),
                    buttons: _yesNoOptions,
                    buttonIndexedBuilder: (selected, index, context) {
                      return RadioTile(
                        title: _yesNoOptions[index],
                        selected: workController[idx].selectedIndex,
                        index: index,
                        onTap: () {
                          workController[idx].selectIndex(index);
                          setState(() {
                            rwhWorkingIndex[idx] = index;
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
                            openPitsCamera(index: idx);
                          },
                          child: Center(
                            child: SizedBox(
                              width: 200,
                              height: 200,
                              child: selectedPitsImagesData[idx] == null
                                  ? Image.asset(
                                      "assets/images/water_harvest.png",
                                      height: 200,
                                      width: 200,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.memory(
                                      selectedPitsImagesData[idx],
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
              );
            }),
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget borewellsDepth() {
    if (borewellsController.text.toString().isNotEmpty &&
        int.parse(borewellsController.text.toString()) != 0) {
      int count = int.parse(borewellsController.text.toString());
      var showBoth = false;
      if (count == 1) {
        showBoth = false;
      } else {
        showBoth = true;
      }

      return Column(
        children: [
          Visibility(
            visible: showBoth,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: minDepthController,
                textInputAction: TextInputAction.done,
                maxLength: 6,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: false),
                decoration: const InputDecoration(
                  counterText: '',
                  border: OutlineInputBorder(),
                  labelText: 'Borewell Min Depth (ft below ground)*',
                  hintText: 'Borewell Min Depth (ft below ground) *',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: maxDepthController,
              textInputAction: TextInputAction.done,
              maxLength: 6,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: false),
              decoration: const InputDecoration(
                counterText: '',
                border: OutlineInputBorder(),
                labelText: 'Borewell Max Depth (ft below ground)*',
                hintText: 'Borewell Max Depth (ft below ground)*',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: workingBorewell,
              textInputAction: TextInputAction.done,
              maxLength: 6,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: false),
              decoration: const InputDecoration(
                counterText: '',
                border: OutlineInputBorder(),
                labelText: 'No Of Borewells Working*',
                hintText: 'No Of Borewells Working *',
              ),
            ),
          ),
          /*       Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              controller: notWorkingBorewell,
              textInputAction: TextInputAction.done,
              maxLength: 6,
              keyboardType: TextInputType.numberWithOptions(decimal: false),
              decoration: InputDecoration(
                counterText: '',
                border: OutlineInputBorder(),
                labelText: 'No Of Borewells Not Working*',
                hintText: 'No Of Borewells Not Working *',
              ),
            ),
          ),*/
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget noOfPits() {
    if (isRwhPresent) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          maxLength: 3,
          controller: noOfPitsController,
          keyboardType: const TextInputType.numberWithOptions(decimal: false),
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
            counterText: '',
            border: OutlineInputBorder(),
            labelText: 'Enter No of Pits *',
            hintText: 'Enter No of Pits *',
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

// class _GeoTagState extends State<GeoTag> {
//   var plotController = TextEditingController();
//   var lengthController = TextEditingController();
//   var breadthController = TextEditingController();
//   var widthController = TextEditingController();
//   var remarksController = TextEditingController();
//   var rwhController = GroupButtonController();
//   var workController = GroupButtonController();
//   final houseTypeKey = GlobalKey<DropdownSearchState<String>>();
//   Position? _currentPosition;
//   dynamic _image;
//   dynamic _image1;
//   String? photoBase64;
//   String? photoBase641;
//   bool isRwhPresent = true;
//   var rwhIndex = 0;
//   var rwhWorkingIndex = 0;
//   String selectedHouseType = 'Select House Type';
//   final _yesNoOptions = [
//     'Yes',
//     'No',
//   ];
//   var isValidated = false;
//   final _houseTypeOptions = ['Individual', 'Apartment', 'Commercial'];
//   var finalString = '';
//   var isCan = 0;
//   var canVisible = false;
//   // SharedPreferences? pref;
//   void openCamera(context, type) async {
//     final image = await CustomCamera.openCamera();
//     var base64Data = base64Encode(image);
//     setState(() {
//       if (type == 1) {
//         _image = image;
//         photoBase64 = base64Data;
//       } else {
//         _image1 = image;
//         photoBase641 = base64Data;
//       }
//     });
//   }
//   @override
//   void initState() {
//     super.initState();
//     // initPreferences();
//     determinePosition();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         backgroundColor: primaryColor,
//         title: const Text(
//           'Rainwater Harvest Pit',
//           style: TextStyle(
//             color: white,
//             fontSize: 20,
//           ),
//         ),
//         leading: IconButton(
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: DropdownSearch<String>(
//                   key: houseTypeKey,
//                   validator: (v) => v == null ? "required field" : null,
//                   hint: " House Type*",
//                   mode: Mode.BOTTOM_SHEET,
//                   showSelectedItem: true,
//                   items: _houseTypeOptions,
//                   label: " House Type*",
//                   showClearButton: false,
//                   onChanged: (dynamic print) => {selectedHouseType = print!}),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: TextField(
//                 controller: plotController,
//                 textInputAction: TextInputAction.done,
//                 keyboardType:
//                     const TextInputType.numberWithOptions(decimal: true),
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Plot Area*',
//                   hintText: 'Enter Plot Area(sq mts)*',
//                 ),
//                 inputFormatters: [
//                   FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
//                 ],
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text(
//                 "Whether RWH Structure*",
//                 style: TextStyle(fontSize: 18, color: primary),
//               ),
//             ),
//             GroupButton(
//               controller: rwhController,
//               isRadio: true,
//               options:
//                   const GroupButtonOptions(groupingType: GroupingType.column),
//               buttons: _yesNoOptions,
//               buttonIndexedBuilder: (selected, index, context) {
//                 return RadioTile(
//                   title: _yesNoOptions[index],
//                   selected: rwhController.selectedIndex,
//                   index: index,
//                   onTap: () {
//                     rwhController.selectIndex(index);
//                     setState(() {
//                       rwhIndex = index;
//                       if (rwhIndex == 0) {
//                         isRwhPresent = true;
//                       } else {
//                         isRwhPresent = false;
//                       }
//                     });
//                   },
//                 );
//               },
//             ),
//             getDimension(),
//             Column(
//               children: [
//                 SizedBox(
//                   child: GestureDetector(
//                     onTap: () {
//                       openCamera(context, 1);
//                     },
//                     child: Center(
//                       child: SizedBox(
//                         width: 200,
//                         height: 200,
//                         child: _image == null
//                             ? Image.asset(
//                                 "assets/images/building.png",
//                                 height: 200,
//                                 width: 200,
//                                 fit: BoxFit.fill,
//                               )
//                             : Image.memory(
//                                 _image,
//                                 fit: BoxFit.fill,
//                               ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const Text(
//                   "Building Photo",
//                   style: TextStyle(fontSize: 16, color: primary),
//                 ),
//                 setPitPhoto(),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 ElevatedButton(
//                   onPressed: () => validate(),
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.white,
//                     backgroundColor: primary, // Text color
//                   ),
//                   child: const Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 30.0),
//                     child:
//                         Text("Submit", style: TextStyle(color: Colors.white)),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   validate() {
//     if (_currentPosition == null) {
//       EasyLoading.showInfo("Receiving GeoCoordinates Please Wait");
//       determinePosition();
//     } else if (_currentPosition != null && _currentPosition?.latitude == null) {
//       EasyLoading.showInfo("Receiving GeoCoordinates Please Wait");
//       determinePosition();
//     } else if (selectedHouseType == "Select House Type") {
//       EasyLoading.showInfo("Select House Type");
//     } else if (plotController.text.toString().isEmpty) {
//       EasyLoading.showInfo("Enter Plot Area");
//     } else if (isRwhPresent && lengthController.text.toString().isEmpty) {
//       EasyLoading.showInfo("Enter Length");
//     } else if (isRwhPresent && breadthController.text.toString().isEmpty) {
//       EasyLoading.showInfo("Enter Breadth");
//     } else if (isRwhPresent && widthController.text.toString().isEmpty) {
//       EasyLoading.showInfo("Enter Depth");
//     } else if (photoBase64 == null) {
//       EasyLoading.showInfo("Select Building Photo");
//     } else if (isRwhPresent && photoBase641 == null) {
//       EasyLoading.showInfo("Select PIT Photo");
//     } else {
//       submit();
//     }
//   }
//   Future<void> determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       Geolocator.openLocationSettings();
//       return Future.error('Location services are disabled.');
//     }
//     permission = await Geolocator.checkPermission();
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       return Future.error('Location permissions are denied');
//     }
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//     Geolocator.getCurrentPosition(
//                 desiredAccuracy: LocationAccuracy.best,
//                 forceAndroidLocationManager: false)
//             .then((Position position) {
//       setState(() {
//         _currentPosition = position;
//         // print(_currentPosition?.latitude ?? "");
//       });
//     })
//         // .catchError((e) {
//         //   print(e);
//         // })
//         ;
//   }
//   submit() async {
//     dynamic response;
//     var rwhExists = "";
//     var rwhWorkExists = "";
//     if (rwhIndex == 0) {
//       rwhExists = "Yes";
//     } else {
//       rwhExists = "No";
//     }
//     if (rwhWorkingIndex == 0) {
//       rwhWorkExists = "Yes";
//     } else {
//       rwhWorkExists = "No";
//     }
//     // SharedPreferences pref = await SharedPreferences.getInstance();
//     try {
//       var postData = {
//         "can_number": LocalStorages.getCanno() ?? '',
//         "plot_area": plotController.text.toString(),
//         "house_type": selectedHouseType,
//         "rwh_exists": rwhExists,
//         "rwh_length": lengthController.text.toString(),
//         "rwh_breadth": breadthController.text.toString(),
//         "rwh_depth": widthController.text.toString(),
//         "rwh_working_status": rwhWorkExists,
//         "latitude": _currentPosition?.latitude,
//         "longitude": _currentPosition?.longitude,
//         "building_image": photoBase64,
//         "image": photoBase641,
//       };
//       EasyLoading.show(status: "Loading...");
//       response = await NetworkApiService().commonApiCall(
//           url: Api.baseurlRwh, data: postData, isPostMethod: true);
//       EasyLoading.dismiss();
//       if (response.statusCode == 200) {
//         var value = SubmitResponse.fromJson(response.data);
//         if (value.error == 0) {
//           EasyLoading.showSuccess(value.message ?? "");
//           Navigator.pop(context);
//         } else {
//           EasyLoading.showSuccess(value.message ?? "");
//         }
//       }
//     } on DioException catch (ex) {
//       EasyLoading.dismiss();
//       showException(ex);
//     }
//   }
//   Widget getDimension() {
//     if (isRwhPresent) {
//       return Column(
//         children: [
//           const Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Text(
//               "Dimensions of RWH",
//               style: TextStyle(fontSize: 18, color: primary),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   flex: 1,
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: TextField(
//                       controller: lengthController,
//                       keyboardType:
//                           const TextInputType.numberWithOptions(decimal: false),
//                       textInputAction: TextInputAction.done,
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Length (ft)*',
//                         hintText: 'Enter Length*',
//                       ),
//                       inputFormatters: [
//                         FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
//                       ],
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   flex: 1,
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: TextField(
//                       keyboardType:
//                           const TextInputType.numberWithOptions(decimal: false),
//                       controller: breadthController,
//                       textInputAction: TextInputAction.done,
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Breadth(ft)*',
//                         hintText: 'Enter Breadth*',
//                       ),
//                       inputFormatters: [
//                         FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
//                       ],
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   flex: 1,
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: TextField(
//                       keyboardType:
//                           const TextInputType.numberWithOptions(decimal: false),
//                       controller: widthController,
//                       textInputAction: TextInputAction.done,
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Depth(ft)*',
//                         hintText: 'Enter Depth* ',
//                       ),
//                       inputFormatters: [
//                         FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           const Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Text(
//               "Status of Existing RWHS Working Condition*",
//               style: TextStyle(fontSize: 18, color: primary),
//             ),
//           ),
//           GroupButton(
//             controller: workController,
//             isRadio: true,
//             options:
//                 const GroupButtonOptions(groupingType: GroupingType.column),
//             buttons: _yesNoOptions,
//             buttonIndexedBuilder: (selected, index, context) {
//               return RadioTile(
//                 title: _yesNoOptions[index],
//                 selected: workController.selectedIndex,
//                 index: index,
//                 onTap: () {
//                   workController.selectIndex(index);
//                   setState(() {
//                     rwhWorkingIndex = index;
//                   });
//                 },
//               );
//             },
//           ),
//         ],
//       );
//     } else {
//       return const Text("");
//     }
//   }
//   Widget setPitPhoto() {
//     if (isRwhPresent) {
//       return Column(
//         children: [
//           SizedBox(
//             child: GestureDetector(
//               onTap: () {
//                 openCamera(context, 2);
//               },
//               child: Center(
//                 child: SizedBox(
//                   width: 200,
//                   height: 200,
//                   child: _image1 == null
//                       ? Image.asset(
//                           "assets/images/water_harvest.png",
//                           height: 200,
//                           width: 200,
//                           fit: BoxFit.fill,
//                         )
//                       : Image.memory(
//                           _image1,
//                           fit: BoxFit.fill,
//                         ),
//                 ),
//               ),
//             ),
//           ),
//           const Text(
//             "Pit Photo",
//             style: TextStyle(fontSize: 16, color: primary),
//           ),
//         ],
//       );
//     } else {
//       return const Text("");
//     }
//   }
//   // void initPreferences() async {
//   //   pref = await SharedPreferences.getInstance();
//   // }
// }
