import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Utils {
  /// Define a global key for the navigator
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Future<String> getDeviceId() async {
    String deviceId = '';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId =
          '${androidInfo.id}-${androidInfo.brand}-${androidInfo.model}'; // Unique ID for Android devices
    }
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = (iosInfo.identifierForVendor?.isNotEmpty ?? false)
          ? iosInfo.identifierForVendor ?? ''
          : '${iosInfo.name}-${iosInfo.model}-${iosInfo.utsname.machine}-${iosInfo.utsname.version}'; // Unique ID for iOS devices
    }

    return deviceId;
  }

  static Future<String> imageAssetToBase64(String imagePath) async {
    log("imagePath $imagePath");
    try {
      // Load the image as a ByteData object
      ByteData bytes = await rootBundle.load(imagePath);

      // Convert ByteData to Uint8List
      Uint8List byteData = bytes.buffer.asUint8List();

      // Encode bytes to Base64 string
      String base64String = base64Encode(byteData);

      return base64String;
    } on Exception catch (e) {
      // Handle the error
      log("Unable to load asset: $e");
      return '';
    }
  }
}
