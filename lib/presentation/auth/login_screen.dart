import 'package:flutter/services.dart';
import 'package:hmwssb/core/api/shared_prefernce.dart';
import 'package:hmwssb/core/utils.dart';
import 'package:hmwssb/presentation/auth/otp_verification.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hmwssb/core/api/api.dart';
import 'package:hmwssb/core/api/network.dart';
import 'package:hmwssb/data/models/cans_by_mobile.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController mobileController = TextEditingController();
  // TextEditingController canController = TextEditingController();
  bool isConsumer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/land_logo.png',
                height: 120,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),
              TextField(
                controller: mobileController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: InputDecoration(
                  labelText: "Mobile Number",
                  hintText: "Enter Your Mobile Number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                enableInteractiveSelection: false, // Disable copy
                // inputFormatters: [
                //   FilteringTextInputFormatter.deny(
                //       RegExp(r'.*')), // Reject paste
                // ],
                onTap: () {
                  Clipboard.setData(
                      const ClipboardData(text: '')); // Clear clipboard on tap
                },
              ),

              const SizedBox(height: 20),
              //? Send OTP button
              ElevatedButton(
                onPressed: () async {
                  if (mobileController.text.isEmpty ||
                      mobileController.text.length < 10) {
                    EasyLoading.showInfo("Enter Valid Mobile Number");
                  } else {
                    await getTokenApiCall().then((_) {
                      if (LocalStorages.getToken().isNotEmpty) {
                        getCanInfoByMobile();
                      } else {
                        EasyLoading.showInfo(
                            'Something went wrong, Please try again later ');
                      }
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Send OTP',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getTokenApiCall() async {
    Response response = await NetworkApiService().commonApiCall(
        url: Api.generateTokenUrl,
        isTokenNotPassing: true,
        data: {
          "MobileNo": mobileController.text.trim(),
          "DeviceID": await Utils.getDeviceId(),
        });

    if (response.statusCode == 200) {
      String token = response.data["Token"] ?? '';
      LocalStorages.saveUserData(
          localSaveType: LocalSaveType.token, value: token);
    }
  }

  getCanInfoByMobile() async {
    try {
      EasyLoading.show(status: "Loading...");
      var response = await NetworkApiService().commonApiCall(
          url: Api.canInfoByMobile,
          data: {'mobileNo': mobileController.text.trim()});
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var value = CansByMobile.fromJson(response.data);
        if ((value.mItem1?.responseCode ?? "0") == "311") {
          isConsumer = false;
          LocalStorages.saveUserData(
              localSaveType: LocalSaveType.mobileNumber,
              value: mobileController.text.trim());

          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => OTPVerificationScreen(
                      mobileNo: mobileController.text.toString(),
                      isConsumer: isConsumer)),
            );
          }
        } else if ((value.mItem1?.responseCode ?? "0") == "200") {
          if (value.mItem2?.isNotEmpty == true) {
            isConsumer = true;
            LocalStorages.saveUserData(
                localSaveType: LocalSaveType.mobileNumber,
                value: value.mItem2?[0].mobileno);
            LocalStorages.saveUserData(
                localSaveType: LocalSaveType.name,
                value: value.mItem2?[0].name);
            LocalStorages.saveUserData(
                localSaveType: LocalSaveType.isAmr,
                value: value.mItem2?.firstOrNull?.iSAMR ?? false);
            LocalStorages.saveUserData(
                localSaveType: LocalSaveType.canno,
                value: value.mItem2?[0].cAN);
            LocalStorages.saveUserData(
                localSaveType: LocalSaveType.pipeSize,
                value: value.mItem2?[0].waterPipesizeInMM);
            LocalStorages.saveUserData(
                localSaveType: LocalSaveType.address,
                value: value.mItem2?[0].address);
            LocalStorages.saveUserData(
                localSaveType: LocalSaveType.latitude,
                value: value.mItem2?[0].latitude);
            LocalStorages.saveUserData(
                localSaveType: LocalSaveType.longitude,
                value: value.mItem2?[0].longitude);
            LocalStorages.saveUserData(
                localSaveType: LocalSaveType.rwhFlag,
                value: value.mItem2?[0].rWHFlag);
            LocalStorages.saveUserData(
                localSaveType: LocalSaveType.latLongEdit,
                value: value.mItem2?[0].isLatLongEditible);
          }
          if (mounted) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => OTPVerificationScreen(
                        mobileNo: mobileController.text.toString(),
                        isConsumer: isConsumer)));
          }
        } else {
          EasyLoading.showInfo(value.mItem1!.description!.toString());
        }
      }
    } on DioException catch (ex) {
      EasyLoading.dismiss();
      showException(ex);
    }
  }
}
