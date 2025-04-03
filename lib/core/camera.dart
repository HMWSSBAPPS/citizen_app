import 'dart:convert';

import 'package:image_picker/image_picker.dart';

class CustomCamera {
  static Future<dynamic> openCamera({bool getBase64 = true}) async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 30);
      if (getBase64 == true) {
        final base64Byte = await image?.readAsBytes();
        String base64Encoded = base64Encode(base64Byte!);
        final imageBase64 = base64.decode(base64Encoded.toString());
        // print('base64 -> $imageBase64');
        return imageBase64;
      }
      return image;
    } on Exception catch (_) {}
  }

  static Future<dynamic> openGallery({bool getBase64 = true}) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (getBase64 == true) {
      List<int> base64Byte = image?.readAsBytes() as List<int>;
      String base64Encoded = base64Encode(base64Byte);
      final imageBase64 = base64.decode(base64Encoded.toString());
      // print('base64 -> $imageBase64');
      return imageBase64;
    }
    return image;
  }
}
