import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hmwssb/core/api/api.dart';
import 'package:hmwssb/core/api/network.dart';
import 'package:hmwssb/core/camera.dart';
import 'package:hmwssb/core/theme/app_color.dart';

class NoticeReplySubmitScreen extends StatefulWidget {
  final String noticeId;

  const NoticeReplySubmitScreen({super.key, required this.noticeId});

  @override
  State<NoticeReplySubmitScreen> createState() =>
      _NoticeReplySubmitScreenState();
}

class _NoticeReplySubmitScreenState extends State<NoticeReplySubmitScreen> {
  dynamic _image;
  String? photoBase64;
  var remarksController = TextEditingController();

  void openCamera(context) async {
    final image = await CustomCamera.openCamera();
    var base64Data = base64Encode(image);
    setState(() {
      _image = image;
      photoBase64 = base64Data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            "Notice Reply",
            style: TextStyle(color: white),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                openCamera(context);
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
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: remarksController,
                textInputAction: TextInputAction.done,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ]"))
                ],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Remarks',
                  hintText: 'Enter Remarks',
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(primaryColor),
                ),
                onPressed: () async {
                  submitData();
                },
                child: const Text('Submit', style: TextStyle(color: white)),
              ),
            ),
          ],
        ));
  }

  void submitData() {
    if (_image == null) {
      EasyLoading.showToast("Capture Image",
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    }
    if (remarksController.text.isEmpty) {
      EasyLoading.showToast("Enter Remarks",
          toastPosition: EasyLoadingToastPosition.bottom);
      return;
    } else {
      sendData();
    }
  }

  Future<void> sendData() async {
    var postData = {
      "notice_type": "consumer",
      "notice_id": widget.noticeId,
      "remarks": remarksController.text.toString(),
      "image": photoBase64,
    };

    try {
      EasyLoading.init();
      EasyLoading.show(status: 'Loading..');
      dynamic response = await NetworkApiService().commonApiCall(
          url: Api.replyNoticeUrl, data: postData, isPostMethod: true);
      EasyLoading.dismiss();

      if (response.data["error"] == 0) {
        EasyLoading.showSuccess("Notice Reply Submitted Successfully");
        // EasyLoading.showSuccess(response.data['message'] ?? "");
      } else {
        EasyLoading.showError(response.data['message'] ?? "");
      }
      Navigator.pop(context);
    } on DioException catch (ex) {
      EasyLoading.dismiss();
      showException(ex);
    }
  }
}
