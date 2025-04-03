// import 'package:hmwssb/core/api/shared_prefernce.dart';
// import 'package:hmwssb/data/models/common_response.dart';
// import 'package:hmwssb/data/models/consumer_info.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:hmwssb/core/api/api.dart';
// import 'package:hmwssb/core/api/network.dart';
// import 'package:hmwssb/core/theme/app_color.dart';

// class ProfileInfo extends StatefulWidget {
//   const ProfileInfo({super.key});

//   @override
//   State<ProfileInfo> createState() => _ProfileInfoState();
// }

// class _ProfileInfoState extends State<ProfileInfo> {
//   // SharedPreferences? pref;
//   MItem2? canInfo;

//   final TextEditingController updateEmailController = TextEditingController();
//   final FocusNode updateEmailFocus = FocusNode();

//   @override
//   void initState() {
//     super.initState();
//     getPrefrences();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//         child: Padding(padding: const EdgeInsets.all(16.0), child: showData()));
//   }

//   getConsumerInfo() async {
//     try {
//       EasyLoading.show(status: "Loading...");
//       var response = await NetworkApiService().commonApiCall(
//           url: Api.getConsumerInfo,
//           data: {'can': LocalStorages.getCanno() ?? ""});
//       EasyLoading.dismiss();
//       if (response.statusCode == 200) {
//         var value = ConsumerInfoData.fromJson(response.data);
//         if ((value.mItem1?.responseCode ?? "0") != "200") {
//           EasyLoading.showError(
//               value.mItem1?.description ?? "An error 0ccured");
//         } else {
//           setState(() {
//             canInfo = value.mItem2!;
//           });
//         }
//       }
//     } on DioException catch (ex) {
//       EasyLoading.dismiss();
//       showException(ex);
//     }
//   }

//   void getPrefrences() async {
//     // pref = await SharedPreferences.getInstance();
//     getConsumerInfo();
//   }

//   Widget showData() {
//     final canInfo = this.canInfo;
//     if (canInfo != null) {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'CAN: ${canInfo.can ?? ""}',
//             style: const TextStyle(
//                 fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Name: ${canInfo.name}',
//             style: const TextStyle(fontSize: 16),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Address: ${canInfo.address}',
//             style: const TextStyle(fontSize: 16),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Category: ${canInfo.category}',
//             style: const TextStyle(
//               fontSize: 16,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Water Pipe Size in MM: ${canInfo.waterPipesizeInMM}',
//             style: const TextStyle(fontSize: 16),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Outstanding Amount: ${canInfo.outstandingAmount}',
//             style: const TextStyle(fontSize: 16),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Mobile No.: ${canInfo.mobileno}',
//             style: const TextStyle(fontSize: 16),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Email: ${canInfo.email!.isNotEmpty ? canInfo.email : "N/A"}',
//             style: const TextStyle(fontSize: 16, color: Colors.purple),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: TextField(
//               controller: updateEmailController,
//               focusNode: updateEmailFocus,
//               maxLines: 1,
//               textInputAction: TextInputAction.done,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: ' Update Email-Id',
//                 hintText: 'Update Email-Id',
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Center(
//             child: ElevatedButton(
//               onPressed: () => validate(),
//               style: ElevatedButton.styleFrom(
//                 foregroundColor: Colors.white,
//                 backgroundColor: primaryColor, // Text color
//               ),
//               child: const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 80.0),
//                 child: Text("Update Email-Id",
//                     style: TextStyle(color: Colors.white)),
//               ),
//             ),
//           ),
//         ],
//       );
//     } else {
//       return const SizedBox();
//     }
//   }

//   bool _isValidEmail(String email) {
//     final regex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
//     return regex.hasMatch(email);
//   }

//   validate() {
//     if (updateEmailController.text.isEmpty) {
//       EasyLoading.showInfo("Enter Email-Id");
//     } else if (!_isValidEmail(updateEmailController.text)) {
//       EasyLoading.showInfo("Enter Valid Email");
//     } else {
//       updateEmailId();
//     }
//   }

//   updateEmailId() async {
//     try {
//       EasyLoading.show(status: "Loading...");
//       var response =
//           await NetworkApiService().commonApiCall(url: Api.updateEmail, data: {
//         'can': LocalStorages.getCanno() ?? "",
//         'newEmail': updateEmailController.text.trim(),
//       });
//       EasyLoading.dismiss();
//       if (response.statusCode == 200) {
//         var value = CommonResponse.fromJson(response.data);
//         if ((value.mItem1?.responseCode ?? "0") == "200") {
//           if (value.mItem1?.description!.contains("1|") == true) {
//             setState(() {
//               getConsumerInfo();
//               updateEmailController.clear();
//               updateEmailFocus.unfocus();
//             });
//             EasyLoading.showInfo(
//                 value.mItem1?.description?.replaceAll("1|", "") ?? "");
//           } else {
//             EasyLoading.showInfo(
//                 value.mItem1?.description?.replaceAll("0|", "") ?? "");
//           }
//         } else {
//           EasyLoading.showError(
//               value.mItem1?.description ?? "An error 0ccured");
//         }
//       }
//     } on DioException catch (ex) {
//       EasyLoading.dismiss();
//       showException(ex);
//     }
//   }
// }
