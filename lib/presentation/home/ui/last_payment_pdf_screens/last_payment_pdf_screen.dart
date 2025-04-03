import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hmwssb/core/api/api.dart';
import 'package:hmwssb/core/api/network.dart';
import 'package:hmwssb/core/api/shared_prefernce.dart';
import 'package:hmwssb/core/theme/app_color.dart';
import 'package:hmwssb/data/models/last_payment_get_pdf_model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:url_launcher/url_launcher_string.dart';

class LastPaymentPdfScreen extends StatefulWidget {
  const LastPaymentPdfScreen({super.key});

  @override
  State<LastPaymentPdfScreen> createState() => _LastPaymentPdfScreenState();
}

// class _LastPaymentPdfScreenState extends State<LastPaymentPdfScreen> {
//   String pdfUrl = '';

//   @override
//   void initState() {
//     super.initState();
//     pdfUrl = '';
//     getLastTransactionPdfApiCall();
//   }

//   bool isLoading = false;

//   void isLoadData(bool val) {
//     setState(() {
//       isLoading = val;
//     });
//   }

//   Future<void> getLastTransactionPdfApiCall() async {
//     pdfUrl = '';
//     isLoadData(true);
//     try {
//       EasyLoading.show(status: "Loading...");
//       var response = await NetworkApiService().commonApiCall(
//         url: Api.getTransactionReceiptPDFUrl,
//         data: {'can': LocalStorages.getCanno() ?? ''},
//       );
//       EasyLoading.dismiss();
//       if (response.statusCode == 200) {
//         LastPaymentPdfGetModel value =
//             LastPaymentPdfGetModel.fromJson(response.data);
//         if (value.mItem2?.receiptPdfLink?.isNotEmpty ?? false) {
//           setState(() {
//             // Add a unique parameter to the URL
//             pdfUrl =
//                 '${value.mItem2?.receiptPdfLink}?t=${DateTime.now().millisecondsSinceEpoch}';
//           });
//         }
//       }
//       isLoadData(false);
//     } on DioException catch (ex) {
//       EasyLoading.dismiss();
//       showException(ex);
//     }
//   }

//   Future<void> _launchPdfUrl() async {
//     if (pdfUrl.isNotEmpty) {
//       // Check if the URL can be launched
//       if (await canLaunchUrlString(pdfUrl)) {
//         await launchUrlString(pdfUrl);
//       } else {
//         _showError("Could not launch the PDF");
//       }
//     } else {
//       _showError("No PDF URL found");
//     }
//   }

//   void _showError(String message) {
//     EasyLoading.showToast(message,
//         toastPosition: EasyLoadingToastPosition.bottom);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return isLoading
//         ? const SizedBox.shrink()
//         : pdfUrl.isEmpty
//             ? const Center(
//                 child: Text(
//                   'Last Payment Receipt Not Found',
//                   style: TextStyle(color: Colors.black, fontSize: 18),
//                 ),
//               )
//             : Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: InkWell(
//                       onTap: () {
//                         _launchPdfUrl();
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8.0),
//                           border: Border.all(color: Colors.blue),
//                         ),
//                         child: const Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Icon(Icons.download),
//                               SizedBox(width: 6),
//                               Text(
//                                 'Open PDF',
//                                 style: TextStyle(
//                                     color: Colors.black, fontSize: 18),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                    Expanded(
//                         child: const PDF().cachedFromUrl(
//                           pdfUrl,
//                           placeholder: (double progress) =>
//                               Center(child: Text('$progress %')),
//                           errorWidget: (dynamic error) =>
//                               Center(child: Text(error.toString())),
//                           // ),
//                         ),
//                       ),
//                     ],
//               );
//   }
// }

class _LastPaymentPdfScreenState extends State<LastPaymentPdfScreen> {
  String pdfUrl = '';

  @override
  void initState() {
    super.initState();
    pdfUrl = '';
    getLastTransactionPdfApiCall();
  }

  bool isLoading = false;
  void isLoadData(bool val) {
    setState(() {
      isLoading = val;
    });
  }

  Future<dynamic> getLastTransactionPdfApiCall() async {
    // setState(() {
    pdfUrl = '';
    isLoadData(true);
    // });
    try {
      EasyLoading.show(status: "Loading...");
      var response = await NetworkApiService().commonApiCall(
          url: Api.getTransactionReceiptPDFUrl,
          data: {'can': LocalStorages.getCanno() ?? ''});
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        // log(jsonEncode(response.data).toString());
        LastPaymentPdfGetModel value =
            LastPaymentPdfGetModel.fromJson(response.data);
        if (value.mItem2?.receiptPdfLink?.isNotEmpty ?? false) {
          setState(() {
            // Add a unique parameter to the URL
            pdfUrl =
                '${value.mItem2?.receiptPdfLink}?t=${DateTime.now().millisecondsSinceEpoch}';
          });
        }

        // CanInfoModel value = CanInfoModel.fromJson(response.data);
        // if (value.mItem3?.receiptPdfLink?.isNotEmpty ?? false) {
        //   // setState(() {
        //   //   pdfUrl = value.mItem3?.receiptPdfLink ?? '';
        //   // });
        //   setState(() {
        //     // Add a unique parameter to the URL
        //     pdfUrl =
        //         '${value.mItem3?.receiptPdfLink}?t=${DateTime.now().millisecondsSinceEpoch}';
        //   });
        // }
      }
      isLoadData(false);
      isLoadData(false);
    } on DioException catch (ex) {
      EasyLoading.dismiss();
      showException(ex);
    }
  }

  Future<void> _downloadPdf() async {
    if (await _requestPermission(Permission.storage)) {
      Directory? directory;
      if (Platform.isAndroid) {
        directory = await getExternalStorageDirectory();
      } else if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      }

      if (directory != null) {
        final String filePath =
            '${directory.path}/${LocalStorages.getCanno().toString().isNotEmpty ? 'payment_${LocalStorages.getCanno()}_receipt' : 'payment_receipt'}.pdf';
        File file = File(filePath);
        if (file.existsSync()) {
          file.deleteSync();
        }
        await _downloadFile(pdfUrl, filePath);
      } else {
        _showError("Unable to find storage directory");
      }
    } else {
      _showError("Storage permission denied");
    }
  }

  Future<void> _downloadFile(String url, String savePath) async {
    try {
      final dio = Dio();
      final response = await dio.download(url, savePath);
      if (response.statusCode == 200) {
        OpenFile.open(savePath);
      } else {
        _showError("Download failed with status: ${response.statusCode}");
      }
    } catch (e) {
      _showError("Download failed: $e");
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      final result = await permission.request();
      return result == PermissionStatus.granted;
    }
  }

  void _showError(String message) {
    EasyLoading.showToast(message,
        toastPosition: EasyLoadingToastPosition.bottom);
  }

  @override
  Widget build(BuildContext context) {
    // print("pdfUrl : $pdfUrl");
    return
        // Scaffold(
        //   appBar: AppBar(
        //     backgroundColor: primaryColor,
        //     iconTheme: const IconThemeData(color: Colors.white),
        //     title: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         const Text('Last Payment Receipt',
        //             style: TextStyle(
        //               color: white,
        //               fontSize: 18,
        //             )),
        //         if (pdfUrl.isNotEmpty)
        //           IconButton(
        //             icon: const Icon(Icons.download),
        //             onPressed: () {
        //               _downloadPdf();
        //             },
        //           ),
        //       ],
        //     ),
        //   ),
        //   body:
        isLoading
            ? const SizedBox.shrink()
            : pdfUrl.isEmpty
                ? const Center(
                    child: Text(
                    'Last Payment Receipt Not Found',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // SizedBox(height: 10.h),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            _downloadPdf();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: primary,
                                )),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.download),
                                  SizedBox(width: 6),
                                  Text('Download',
                                      style: TextStyle(
                                        color: black,
                                        fontSize: 18,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: const PDF().cachedFromUrl(
                          pdfUrl,
                          placeholder: (double progress) =>
                              Center(child: Text('$progress %')),
                          errorWidget: (dynamic error) =>
                              Center(child: Text(error.toString())),
                          // ),
                        ),
                      ),
                    ],
                  );
  }
}
