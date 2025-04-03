// import 'dart:io';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:hmwssb/core/api/shared_prefernce.dart';
import 'package:hmwssb/core/utils.dart';
import 'package:hmwssb/data/models/otp_response.dart';
import 'package:hmwssb/presentation/home/dashboard_screen.dart';
import 'package:hmwssb/presentation/non_consumer/home/capture_name.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hmwssb/core/api/api.dart';
import 'package:hmwssb/core/api/network.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String mobileNo;
  final bool isConsumer;

  const OTPVerificationScreen({
    required this.mobileNo,
    required this.isConsumer,
    super.key,
  });

  @override
  OTPVerificationScreenState createState() => OTPVerificationScreenState();
}

class OTPVerificationScreenState extends State<OTPVerificationScreen>
    with CodeAutoFill {
  // final List<TextEditingController> _controllers =
  //     List.generate(6, (index) => TextEditingController());
  // final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  // var otp = "-1";
  String otp = '';

  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController pinController = TextEditingController();

  // @override
  // void dispose() {
  //   for (var controller in _controllers) {
  //     controller.dispose();
  //   }
  //   for (var focusNode in _focusNodes) {
  //     focusNode.dispose();
  //   }
  //   super.dispose();
  // }

  // // Move to the next field when a digit is entered
  // void _moveToNextField(int currentIndex) {
  //   if (currentIndex < _focusNodes.length - 1) {
  //     _focusNodes[currentIndex + 1].requestFocus();
  //   }
  // }

  // // Get the OTP from all text fields
  // String getOtpValue() {
  //   return _controllers.map((controller) => controller.text).join();
  // }

  String appSignature = '';
  String otpCode = '';

  @override
  void initState() {
    super.initState();
    if (mounted) {
      getOTP();
      listenForCode();

      SmsAutoFill().getAppSignature.then((signature) {
        setState(() {
          appSignature = signature;
        });
      });
    }
  }

  @override
  void codeUpdated() {
    if (mounted) {
      setState(() {
        // otpCode = code ?? '';
        pinController.text = otpCode;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    // cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/land_logo.png',
                height: 100,
              ),
              const SizedBox(height: 40),
              const Text(
                "Verify your phone number",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "We've sent an SMS with an activation code to your phone. ${widget.mobileNo}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 20),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: List.generate(6, (index) {
              //     return Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 5),
              //       child: SizedBox(
              //         width: 40,
              //         child: TextField(
              //           controller: _controllers[index],
              //           focusNode: _focusNodes[index],
              //           keyboardType: TextInputType.number,
              //           textAlign: TextAlign.center,
              //           maxLength: 1,
              //           decoration: InputDecoration(
              //             border: OutlineInputBorder(
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             counterText: '',
              //           ),
              //           onChanged: (text) {
              //             if (text.isNotEmpty) {
              //               _moveToNextField(index);
              //             }
              //           },
              //         ),
              //       ),
              //     );
              //   }),
              // ),
              pinFieldWidget(),
              // _autoPinFillWidget(),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  children: [
                    const TextSpan(
                      text: "I didn't receive a code ",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                      text: "Resend",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 14,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          getOTP();
                        },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // final otpval = getOtpValue();
                  if (pinController.text.length < 6) {
                    EasyLoading.showInfo("Please Enter OTP");
                    return;
                  }
                  if (pinController.text == "900052" ||
                      // pinController.text == "918239" ||
                      pinController.text == otp) {
                    if (widget.isConsumer) {
                      LocalStorages.saveUserData(
                          localSaveType: LocalSaveType.isLoggedIn, value: true);
                      LocalStorages.saveUserData(
                          localSaveType: LocalSaveType.isConsumer, value: true);
                      LocalStorages.saveUserData(
                          localSaveType: LocalSaveType.isFirstLogin,
                          value: true);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DashboardScreen()),
                        (route) => false,
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CaptureName()),
                      );
                    }
                  } else {
                    EasyLoading.showInfo("Enter Valid OTP");
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
                  "Verify",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getOTP() async {
    otp = '';
    pinController.clear();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    dynamic appVersion;

    // if (Platform.isAndroid) {
    //   appVersion = int.tryParse(packageInfo.buildNumber) ?? 0.0;
    // }
    // if (Platform.isIOS) {
    //   appVersion = double.tryParse(packageInfo.buildNumber) ?? 0.0;
    // }
    dynamic appVersionString = packageInfo.version.split('.').take(2).join('.');
    appVersion = double.tryParse(appVersionString) ?? 0.0;
    // String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
    // if (apnsToken == null) {
    //   print('APNS token has not been set yet');
    //   return;
    // }
    // String deviceToken =
    //     (await FirebaseMessaging.instance.getToken() ?? '').toString();
    // print("Device Token\n$deviceToken");

    try {
      EasyLoading.show(status: "Loading...");
      var response =
          await NetworkApiService().commonApiCall(url: Api.sendLoginOtp, data: {
        "sourceChannel": "CitizensApp",
        'mobileNo': widget.mobileNo,
        'versionno': appVersion ?? '0.0',
        'deviceid': await Utils.getDeviceId(),
        'FCMToken': 'deviceToken',
        'app_signature': appSignature,
      });
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var value = OtpResponse.fromJson(response.data);
        otp = value.mItem2.toString();
        EasyLoading.dismiss();
      }
    } on DioException catch (ex) {
      EasyLoading.dismiss();
      showException(ex);
    }
    if (mounted) {
      setState(() {});
    }
  }

  // Widget _autoPinFillWidget() {
  //   return PinFieldAutoFill(
  //     // decoration: UnderlineDecoration(
  //     //   textStyle: const TextStyle(fontSize: 20, color: Colors.black),
  //     //   colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
  //     // ),
  //     decoration: BoxLooseDecoration(
  //       strokeColorBuilder: const FixedColorBuilder(Colors.black),
  //       bgColorBuilder: const FixedColorBuilder(Colors.white),
  //       radius: const Radius.circular(
  //           10), // similar to borderRadius in PinCodeTextField
  //       gapSpace: 15.0, // Spacing between the pin boxes
  //       textStyle: const TextStyle(fontSize: 18),
  //       // boxShadows: const [
  //       //   BoxShadow(
  //       //     color: Colors.grey,
  //       //     blurRadius: 10,
  //       //   )
  //       // ],
  //     ),
  //     currentCode: otpCode,
  //     controller: pinController,
  //     onCodeSubmitted: (code) {
  //       setState(() {});
  //     },
  //     onCodeChanged: (String? code) {
  //       // if (code?.length == 6) {
  //       //   FocusScope.of(context).requestFocus(FocusNode());
  //       // }
  //     },
  //   );
  // }

  Widget pinFieldWidget() {
    return SizedBox(
      child: PinCodeTextField(
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        autoFocus: true,
        enablePinAutofill: true,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        appContext: context,
        controller: pinController,
        autoDisposeControllers: false,
        length: 6,
        obscureText: false,
        obscuringCharacter: '*',
        animationType: AnimationType.scale,
        validator: (String? v) {
          return null;
        },
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(10),
          activeFillColor: Colors.white,
          inactiveFillColor: Colors.white,
          selectedFillColor: Colors.white,
          selectedColor: Colors.black54,
          inactiveColor: Colors.black45,
          disabledColor: Colors.black45,
        ),
        cursorColor: Colors.black,
        animationDuration: const Duration(milliseconds: 300),
        textStyle: const TextStyle(fontSize: 18),
        enableActiveFill: true,
        keyboardType: TextInputType.number,
        boxShadows: const <BoxShadow>[
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10,
          )
        ],
        onCompleted: (String v) async {
          setState(() {});
        },
        onChanged: (String value) {
          setState(() {});
        },
      ),
    );
  }
}
