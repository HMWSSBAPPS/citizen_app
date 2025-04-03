import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:group_button/group_button.dart';
import 'package:hmwssb/core/api/api.dart';
import 'package:hmwssb/core/api/network.dart';
import 'package:hmwssb/core/api/shared_prefernce.dart';
import 'package:hmwssb/core/camera.dart';
import 'package:hmwssb/core/theme/app_color.dart';
import 'package:hmwssb/presentation/rwh/model/get_pits_details_model.dart';
import 'package:hmwssb/presentation/rwh/model/pits_save_post_model.dart';
import 'package:hmwssb/presentation/rwh/ui/edit_single_pits_screen.dart';
import 'package:hmwssb/presentation/rwh/ui/geo_tag_pit.dart';
import 'package:hmwssb/presentation/rwh/ui/radio_tile.dart';

class AlreadySubmittedPitScreen extends StatefulWidget {
  const AlreadySubmittedPitScreen({super.key});

  @override
  State<AlreadySubmittedPitScreen> createState() =>
      _AlreadySubmittedPitScreenState();
}

class _AlreadySubmittedPitScreenState extends State<AlreadySubmittedPitScreen> {
  final TextEditingController noOfPitsController = TextEditingController();
  final List<GroupButtonController> workController = <GroupButtonController>[];
  final List<TextEditingController> lengthController =
      <TextEditingController>[];
  final List<TextEditingController> breadthController =
      <TextEditingController>[];
  final List<TextEditingController> widthController = <TextEditingController>[];
  List<int> rwhWorkingIndex = <int>[];
  List<dynamic> selectedPitsImagesData = <dynamic>[];
  List<String> storedPitsImagesData = <String>[];

  final List<String> _yesNoOptions = [
    'Yes',
    'No',
  ];
  Position? _currentPosition;
  Survey? survey;
  bool isAddPits = false;

  @override
  void initState() {
    super.initState();
    getSurveyDetailsApiCall();
  }

  void openPitsCamera({required int index}) async {
    final image = await CustomCamera.openCamera();
    String base64Data = base64Encode(image);

    setState(() {
      selectedPitsImagesData[index] = image;
      storedPitsImagesData[index] = base64Data;
    });
  }

  Future<void> getSurveyDetailsApiCall() async {
    isLoadData(true);
    EasyLoading.show(status: 'Loading...');
    try {
      var response =
          await NetworkApiService().commonApiCall(url: Api.getSurveyUrl, data: {
        'can_number':
            // '11100241'
            LocalStorages.getCanno() ?? ''
      });
      if (response.statusCode == 200) {
        RWHPitsDetailsGetModel value =
            RWHPitsDetailsGetModel.fromJson(response.data);
        setState(() {
          survey = value.survey;
        });
      }
      isLoadData(false);
      EasyLoading.dismiss();
    } on DioException catch (ex) {
      isLoadData(false);
      EasyLoading.dismiss();
      showException(ex);
    }
    determinePosition();
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
        _calculateDistance();
        // print(_currentPosition?.latitude ?? "");
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

  double distanceFromPitsToSurverior = 101.0;
  void _calculateDistance() async {
    double startLatitude = _currentPosition?.latitude ?? 0.0;
    double startLongitude = _currentPosition?.longitude ?? 0.0;
    double endLatitude = double.tryParse(survey?.latitude ?? '0.0') ?? 0.0;
    double endLongitude = double.tryParse(survey?.longitude ?? '0.0') ?? 0.0;

    log("message $startLatitude $startLongitude $endLatitude $endLongitude");

    double distanceInMeters = Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);

    setState(() {
      distanceFromPitsToSurverior = distanceInMeters.roundToDouble();
      // log("distanceFromPitsToSurverior $distanceFromPitsToSurverior $startLatitude $startLongitude $endLatitude $endLongitude");
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            if (isAddPits) {
              setState(() {
                isAddPits = false;
              });
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: isLoading
          ? const SizedBox.shrink()
          : survey == null
              ? const GeoTag()
              : SingleChildScrollView(
                  child: isAddPits
                      ? _getPitsDimension()
                      : Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: lightBlack,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    _customLabelAndBodyText(
                                        label: 'CAN No.',
                                        body: survey?.canNumber),
                                    _customLabelAndBodyText(
                                        label: 'PLot Area',
                                        body: survey?.plotArea),
                                    _customLabelAndBodyText(
                                        label: 'House Type',
                                        body: survey?.houseType),
                                    _customLabelAndBodyText(
                                        label: 'No. of Tankers Required',
                                        body: survey?.noOfTankersRequired),
                                    _customLabelAndBodyText(
                                        label: 'No. of Borewells',
                                        body: survey?.noOfBorewells),
                                    _customLabelAndBodyText(
                                        label: 'No. of Borewells Working',
                                        body: survey?.noOfBorewellsWorking),
                                    if (survey?.borewellMinDepth?.isNotEmpty ??
                                        false)
                                      _customLabelAndBodyText(
                                          label: 'Borewell Min Depth',
                                          body: survey?.borewellMinDepth),
                                    _customLabelAndBodyText(
                                        label: 'Borewell Max Depth',
                                        body: survey?.borewellMaxDepth),
                                    const SizedBox(height: 10)
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            if (survey?.rwhExists != 'Yes') noOfPits(),
                            if (survey?.surveyPits?.isNotEmpty ?? false)
                              _getPitsDetails(),
                            const SizedBox(height: 20),
                          ],
                        ),
                ),
    );
  }

  //?If Pits details are already present
  Widget _getPitsDetails() {
    return Column(children: [
      Text(
        'Total ${survey?.surveyPits?.length ?? 0} RWH Pits Submitted',
        style: TextStyle(
          color: primary,
          fontSize: 20.sp,
          // fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 10),
      SingleChildScrollView(
        child: Column(
          children: List.generate(survey?.surveyPits?.length ?? 0, (index) {
            return _getCustomPitDetails(survey?.surveyPits?[index]);
          }),
        ),
      ),
    ]);
  }

  Widget _getCustomPitDetails(GetSurveyPits? surveyPit) {
    // log("distanceFromPitsToSurverior $distanceFromPitsToSurverior");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: lightGrey,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _customLabelAndBodyText(
                label: 'RWH No.',
                body: surveyPit?.rwhNumber,
                isSurveyPitsCard: true),
            _customLabelAndBodyText(
                label: 'Length',
                body: '${surveyPit?.rwhLength} Mtrs',
                isSurveyPitsCard: true),
            _customLabelAndBodyText(
                label: 'Breadth',
                body: '${surveyPit?.rwhBreadth} Mtrs',
                isSurveyPitsCard: true),
            _customLabelAndBodyText(
                label: 'Depth',
                body: '${surveyPit?.rwhDepth} Mtrs',
                isSurveyPitsCard: true),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Status : ${surveyPit?.rwhWorkingStatus}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            const SizedBox(height: 10),
            if (surveyPit?.imagePath?.isNotEmpty ?? false)
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.network(
                      "https://rwh.hyderabadwater.gov.in/files/surveys/${surveyPit?.imagePath}",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox.shrink();
                      },
                    ),
                    if ((distanceFromPitsToSurverior <= 100) &&
                        surveyPit?.recapture == 1)
                      TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditPitsScreen(
                                      getSurveyPits: surveyPit,
                                      position: _currentPosition)));
                        },
                        icon: const Icon(Icons.edit, color: Colors.orange),
                        label: const Text(
                          "Re-Visit",
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  //?custom label and body text
  Widget _customLabelAndBodyText({
    required String label,
    required String? body,
    bool isSurveyPitsCard = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
      child: Row(
        children: [
          Text(
            '$label : ',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: black,
              fontSize: isSurveyPitsCard ? 12.sp : 16.sp,
            ),
          ),
          Flexible(
              child: Text(
            body ?? '',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: primary,
              fontSize: isSurveyPitsCard ? 14.sp : 18.sp,
            ),
          )),
        ],
      ),
    );
  }

  Widget noOfPits() {
    return Column(
      children: [
        Padding(
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
        ),
        ElevatedButton(
          onPressed: () async {
            if (noOfPitsController.text.isNotEmpty) {
              addControllers();
              await saveSurveyDetailsApiCall();
            } else {
              EasyLoading.showToast("Enter No of Pits",
                  toastPosition: EasyLoadingToastPosition.bottom);
            }
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: primary, // Text color
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Text("Submit", style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }

  Widget _getPitsDimension() {
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
                            keyboardType: const TextInputType.numberWithOptions(
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
                            keyboardType: const TextInputType.numberWithOptions(
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
                            keyboardType: const TextInputType.numberWithOptions(
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
    );
  }

  void validatePitsDetails() async {
    int lengthOfPits = int.tryParse(noOfPitsController.text.trim()) ?? 1;

    for (int idx = 0; idx < lengthOfPits; idx++) {
      if (lengthController[idx].text.toString().isEmpty) {
        EasyLoading.showInfo("Enter Length for Pit ${idx + 1}");
        return; // Stop further validation after showing the first error
      }
      if (breadthController[idx].text.toString().isEmpty) {
        EasyLoading.showInfo("Enter Breadth for Pit ${idx + 1}");
        return;
      }
      if (widthController[idx].text.toString().isEmpty) {
        EasyLoading.showInfo("Enter Depth for Pit ${idx + 1}");
        return;
      }

      if (selectedPitsImagesData[idx] == null) {
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

  Future<bool> saveSurveyDetailsApiCall() async {
    isLoadData(true);
    EasyLoading.show(status: 'Loading...');

    try {
      final Response response = await NetworkApiService().commonApiCall(
        url: Api.saveSurveyUrl,
        data: {
          'can_number': LocalStorages.getCanno() ?? '',
          "rwh_exists": "Yes",
          "no_of_pits": int.tryParse(noOfPitsController.text.trim()) ?? 0,
        },
      );
      if (response.statusCode == 200 && response.data['error'] == 0) {
        setState(() {
          isAddPits = true;
        });

        EasyLoading.dismiss();
        isLoadData(false);
        // EasyLoading.showSuccess(response.data['message'].toString());
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

  List<SurveyPits> surveyPitsList() {
    List<SurveyPits> pits = [];

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
}
