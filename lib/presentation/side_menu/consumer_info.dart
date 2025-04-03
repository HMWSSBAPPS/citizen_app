import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:hmwssb/core/api/shared_prefernce.dart';
import 'package:hmwssb/data/models/common_response.dart';
import 'package:hmwssb/data/models/consumer_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hmwssb/core/api/api.dart';
import 'package:hmwssb/core/api/network.dart';
import 'package:hmwssb/core/theme/app_color.dart';

class ConsumerInfo extends StatefulWidget {
  const ConsumerInfo({super.key});

  @override
  State<ConsumerInfo> createState() => _ConsumerInfoState();
}

class _ConsumerInfoState extends State<ConsumerInfo> {
  // SharedPreferences? pref;
  MItem2? canInfo;

  final TextEditingController updateEmailController = TextEditingController();
  final FocusNode updateEmailFocus = FocusNode();
  final TextEditingController otpController = TextEditingController();
  final FocusNode otpFocus = FocusNode();

  bool isOtpSendToEmail = false;
  bool isResendOtp = false;
  Timer? _timer;
  int _start = 60;

  void startTimer() {
    _start = 60;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
        oneSec,
        (Timer timer) => setState(() {
              if (_start < 1) {
                timer.cancel();
              } else {
                _start = _start - 1;
              }
            }));
  }

  @override
  void initState() {
    super.initState();
    getPrefrences();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: primaryColor,
        title: const Text(
          'My Profile',
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
          child:
              Padding(padding: const EdgeInsets.all(16.0), child: showData())),
    );
  }

  getConsumerInfo() async {
    try {
      EasyLoading.show(status: "Loading...");
      var response = await NetworkApiService().commonApiCall(
          url: Api.getConsumerInfo,
          data: {'can': LocalStorages.getCanno() ?? ""});
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var value = ConsumerInfoData.fromJson(response.data);
        if ((value.mItem1?.responseCode ?? "0") != "200") {
          EasyLoading.showError(
              value.mItem1?.description ?? "An error 0ccured");
        } else {
          setState(() {
            canInfo = value.mItem2!;
          });
        }
      }
    } on DioException catch (ex) {
      EasyLoading.dismiss();
      showException(ex);
    }
  }

  void getPrefrences() async {
    // pref = await SharedPreferences.getInstance();
    getConsumerInfo();
  }

  Widget showData() {
    final canInfo = this.canInfo;
    if (canInfo != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CAN: ${canInfo.can ?? ""}',
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue),
          ),
          const SizedBox(height: 8),
          Text(
            'Name: ${canInfo.name}',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 8),
          Text(
            'Address: ${canInfo.address}',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 8),
          Text(
            'Category: ${canInfo.category}',
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Water Pipe Size in MM: ${canInfo.waterPipesizeInMM}',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 8),
          Text(
            'Outstanding Amount: ${canInfo.outstandingAmount}',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 8),
          Text(
            'Mobile No.: ${canInfo.mobileno}',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 8),
          Text(
            'Email: ${canInfo.email!.isNotEmpty ? canInfo.email : "N/A"}',
            style: const TextStyle(fontSize: 20, color: Colors.purple),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: updateEmailController,
              focusNode: updateEmailFocus,
              maxLines: 1,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: ' Update Email-Id',
                hintText: 'Update Email-Id',
              ),
            ),
          ),
          if (isOtpSendToEmail)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: otpController,
                focusNode: otpFocus,
                maxLines: 1,
                textInputAction: TextInputAction.done,
                keyboardType: Platform.isIOS
                    ? const TextInputType.numberWithOptions(signed: true)
                    : TextInputType.number,
                // maxLength: 10,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '  OTP',
                  hintText: ' Enter OTP',
                ),
              ),
            ),
          const SizedBox(height: 20),
          if (isOtpSendToEmail)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text('Time Left : ',
                        style: TextStyle(
                          fontSize: 16,
                          color: black,
                        )),
                    Text('$_start Sec',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                        )),
                  ],
                ),
                if (_start == 0)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isOtpSendToEmail = false;
                      });
                      validate();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: primaryColor, // Text color
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text("Resend OTP",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
              ],
            ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () => validate(),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: primaryColor, // Text color
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80.0),
                child: Text(isOtpSendToEmail ? "Update Email-Id" : 'Verify OTP',
                    style: const TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  bool _isValidEmail(String email) {
    final regex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return regex.hasMatch(email);
  }

  // validate() {
  //   if (updateEmailController.text.isEmpty) {
  //     EasyLoading.showInfo("Enter Email-Id");
  //   } else if (!_isValidEmail(updateEmailController.text)) {
  //     EasyLoading.showInfo("Enter Valid Email");
  //   } else {
  //     updateEmailId();
  //   }
  // }

  // updateEmailId() async {
  //   try {
  //     EasyLoading.show(status: "Loading...");
  //     var response = await NetworkApiService()..commonApiCall(url:
  //         "${Api.updateEmail + (LocalStorage.getCanno() ?? "")}&newEmail=${updateEmailController.text}");
  //     EasyLoading.dismiss();
  //     if (response.statusCode == 200) {
  //       var value = CommonResponse.fromJson(response.data);
  //       if ((value.mItem1?.responseCode ?? "0") == "200") {
  //         EasyLoading.showInfo(value.mItem1?.description ?? "");
  //         Navigator.pop(context);
  //       } else {
  //         EasyLoading.showError(
  //             value.mItem1?.description ?? "An error 0ccured");
  //       }
  //     }
  //   } on DioException catch (ex) {
  //     EasyLoading.dismiss();
  //     showException(ex);
  //   }
  // }

  validate() {
    if (updateEmailController.text.isEmpty) {
      EasyLoading.showInfo("Enter Email-Id");
    } else if (!_isValidEmail(updateEmailController.text)) {
      EasyLoading.showInfo("Enter Valid Email");
    } else {
      updateEmailId();
    }
  }

  updateEmailId() async {
    try {
      EasyLoading.show(status: "Loading...");
      dynamic initalEmailSendData = {
        'can': LocalStorages.getCanno() ?? "",
        'newEmail': updateEmailController.text.trim(),
      };
      dynamic otpSendEmailData = {
        'can': LocalStorages.getCanno() ?? "",
        'newEmail': updateEmailController.text.trim(),
        "emailotp": otpController.text.trim(),
      };

      var response = await NetworkApiService().commonApiCall(
          url: Api.updateEmail,
          data: isOtpSendToEmail ? otpSendEmailData : initalEmailSendData);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var value = CommonResponse.fromJson(response.data);
        if ((value.mItem1?.responseCode ?? "0") == "200") {
          if (value.mItem1?.description!.contains("1|") == true) {
            setState(() {
              if (isOtpSendToEmail) {
                getConsumerInfo();
                updateEmailController.clear();
                updateEmailFocus.unfocus();
                isOtpSendToEmail = false;
                otpController.clear();
                otpFocus.unfocus();
              } else {
                isOtpSendToEmail = true;
                startTimer();
              }
            });
            EasyLoading.showInfo(
                value.mItem1?.description?.replaceAll("1|", "") ?? "");
          } else {
            EasyLoading.showInfo(
                value.mItem1?.description?.replaceAll("0|", "") ?? "");
          }
          if ((value.mItem1?.description?.replaceAll("0|", "") ?? "") ==
              'Email OTP Validation Failed') {
            setState(() {
              otpController.clear();
            });
          }
          if ((value.mItem1?.description?.replaceAll("0|", "") ?? "") ==
              "Not changed: both old and new email addresses are the same") {
            setState(() {
              updateEmailController.clear();
              updateEmailFocus.unfocus();
              isOtpSendToEmail = false;
              otpController.clear();
              otpFocus.unfocus();
            });
          }
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
}
