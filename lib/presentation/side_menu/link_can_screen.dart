import 'package:hmwssb/core/api/shared_prefernce.dart';
import 'package:hmwssb/data/models/common_response.dart';
import 'package:hmwssb/presentation/home/dashboard_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hmwssb/core/api/api.dart';
import 'package:hmwssb/core/api/network.dart';
import 'package:hmwssb/core/theme/app_color.dart';
import 'package:hmwssb/data/models/cans_by_mobile.dart';

class LinkCanScreen extends StatefulWidget {
  const LinkCanScreen({super.key});

  @override
  State<LinkCanScreen> createState() => _LinkCanScreenState();
}

class _LinkCanScreenState extends State<LinkCanScreen> {
  // SharedPreferences? pref;

  var canController = TextEditingController();
  var billController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // initPrefernces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: primaryColor,
        title: const Text(
          'Link Can',
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLength: 9,
                controller: canController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: false),
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  counterText: '',
                  border: OutlineInputBorder(),
                  labelText: 'Enter CAN   *',
                  hintText: 'Enter CAN  *',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: 1,
                controller: billController,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  counterText: '',
                  border: OutlineInputBorder(),
                  labelText: 'Enter Bill No *(Last 6Months)',
                  hintText: 'Enter Bill No (Last 6Months)',
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                // SharedPreferences pref = await SharedPreferences.getInstance();
                if (canController.text.isEmpty ||
                    canController.text.length != 9) {
                  EasyLoading.showInfo("Enter Valid Can No");
                } else if (billController.text.isEmpty) {
                  EasyLoading.showInfo('Enter Bill No');
                } else {
                  linkCan();
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: primaryColor, // Text color
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.0),
                child: Text("Link Can", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void initPrefernces() async {
  //   pref = await SharedPreferences.getInstance();
  // }

  linkCan() async {
    try {
      EasyLoading.show(status: "Loading...");
      var response =
          await NetworkApiService().commonApiCall(url: Api.linkCan, data: {
        'can': canController.text.trim(),
        'mobileNo': LocalStorages.getMobileNumber() ?? '',
        'billNo': billController.text.trim(),
      });
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var value = CommonResponse.fromJson(response.data);
        if (value.mItem1?.responseCode == "200") {
          getCanInfoByMobile();
        } else {
          getCanInfoByMobile(); /**/
          EasyLoading.showInfo(value.mItem1!.description.toString());
        }
      }
    } on DioException catch (ex) {
      EasyLoading.dismiss();
      showException(ex);
    }
  }

  getCanInfoByMobile() async {
    try {
      EasyLoading.show(status: "Loading...");
      // SharedPreferences pref = await SharedPreferences.getInstance();
      var response = await NetworkApiService().commonApiCall(
          url: Api.canInfoByMobile,
          data: {'mobileNo': LocalStorages.getMobileNumber() ?? ''});
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var value = CansByMobile.fromJson(response.data);
        if ((value.mItem1?.responseCode ?? "0") == "200") {
          if (value.mItem2?.isNotEmpty == true) {
            // pref.setBool(ShareKey.ISLOGGEDIN, true);
            // pref.setBool(ShareKey.ISCONSUMER, true);
            // pref.setString(
            //     ShareKey.MOBILE_NUMBER, value.mItem2?[0].mobileno ?? "");
            // pref.setString(ShareKey.NAME, value.mItem2?[0].name ?? "");
            // pref.setString(ShareKey.CANNO, value.mItem2?[0].can ?? "");
            // pref.setString(
            //     ShareKey.PIPESIZE, value.mItem2?[0].waterPipesizeInMM ?? "");
            // pref.setString(ShareKey.ADDRESS, value.mItem2?[0].address ?? "");
            // pref.setString(ShareKey.LATITUDE, value.mItem2?[0].latitude ?? "");
            // pref.setString(
            //     ShareKey.LONGITUDE, value.mItem2?[0].longitude ?? "");
            // LocalStorage.saveUserData(
            //   isLoggedIn: true,
            //   isConsumer: true,
            //   mobileNumber: value.mItem2?[0].mobileno,
            //   name: value.mItem2?[0].name,
            //   canno: value.mItem2?[0].can,
            //   pipeSize: value.mItem2?[0].waterPipesizeInMM,
            //   address: value.mItem2?[0].address,
            //   latitude: value.mItem2?[0].latitude,
            //   longitude: value.mItem2?[0].longitude,
            // );
            LocalStorages.saveUserData(
              localSaveType: LocalSaveType.isConsumer,
              value: true,
            );
            LocalStorages.saveUserData(
              localSaveType: LocalSaveType.isLoggedIn,
              value: true,
            );

            LocalStorages.saveUserData(
              localSaveType: LocalSaveType.mobileNumber,
              value: value.mItem2?[0].mobileno,
            );
            LocalStorages.saveUserData(
              localSaveType: LocalSaveType.name,
              value: value.mItem2?[0].name,
            );
            LocalStorages.saveUserData(
              localSaveType: LocalSaveType.canno,
              value: value.mItem2?[0].cAN,
            );
            LocalStorages.saveUserData(
              localSaveType: LocalSaveType.pipeSize,
              value: value.mItem2?[0].waterPipesizeInMM,
            );
            LocalStorages.saveUserData(
              localSaveType: LocalSaveType.address,
              value: value.mItem2?[0].address,
            );
            LocalStorages.saveUserData(
              localSaveType: LocalSaveType.latitude,
              value: value.mItem2?[0].latitude,
            );
            LocalStorages.saveUserData(
              localSaveType: LocalSaveType.longitude,
              value: value.mItem2?[0].longitude,
            );
            LocalStorages.saveUserData(
                localSaveType: LocalSaveType.isFirstLogin, value: true);
            // Navigator.pushReplacement(
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const DashboardScreen()),
              (route) => false,
            );
          } else {
            EasyLoading.showInfo(value.mItem1!.description!.toString());
          }
        }
      }
    } on DioException catch (ex) {
      EasyLoading.dismiss();
      showException(ex);
    }
  }
}
