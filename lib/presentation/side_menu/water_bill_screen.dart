import 'package:hmwssb/core/api/shared_prefernce.dart';
import 'package:hmwssb/core/extensions.dart';
import 'package:hmwssb/presentation/side_menu/models/water_bill_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:internet_file/internet_file.dart';
import 'package:internet_file/storage_io.dart';
import 'package:hmwssb/core/api/api.dart';
import 'package:hmwssb/core/api/network.dart';
import 'package:hmwssb/core/theme/app_color.dart';

class WaterBillScreen extends StatefulWidget {
  const WaterBillScreen({super.key});

  @override
  State<WaterBillScreen> createState() => _WaterBillScreenState();
}

class _WaterBillScreenState extends State<WaterBillScreen> {
  // SharedPreferences? pref;
  MItem2? billInfo;

  @override
  void initState() {
    super.initState();
    initpreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: primaryColor,
          title: const Text(
            'Water Bill',
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
        body: showData());
  }

  Widget showData() {
    final canInfo = billInfo;

    if (isLoading) {
      return const SizedBox.shrink();
    } else if (canInfo != null) {
      return SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CAN: ${canInfo.can ?? ""}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.blue),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'NetPay: ${canInfo.payableTotal}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    canInfo.billDate.toString() != 'null' &&
                            (canInfo.billDate?.isNotEmpty ?? false)
                        ? canInfo.billDate?.formatedTime != '00:00'
                            ? 'Bill Date : ${canInfo.billDate?.dmyFormatedDate ?? ''}-${canInfo.billDate?.formatedTime ?? ''}'
                            : 'Bill Date : ${canInfo.billDate?.dmyFormatedDate ?? ''}'
                        : 'Bill Date : null',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Arrears  : ${canInfo.arrears}',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '20KL Free Water Rebate : ${canInfo.fwsNetPayableAmount}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Water Cess : ${canInfo.waterCess}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sewerage Cess : ${canInfo.sewerageCess}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Previous Reading : ${canInfo.previousReading}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Present Reading : ${canInfo.presentReading}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Arrear Interest : ${canInfo.arrearIntrest}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Total Amount: ${canInfo.total}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                ],
              )));
    } else {
      return const Center(
        child: Text(
          'No bills found for provided CAN',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    }
  }

  void initpreferences() async {
    // pref = await SharedPreferences.getInstance();
    getWaterBill();
  }

  bool isLoading = false;
  bool loadData(bool val) {
    isLoading = val;
    setState(() {});
    return isLoading;
  }

  getWaterBill() async {
    loadData(true);
    try {
      EasyLoading.show(status: "Loading...");
      var response = await NetworkApiService().commonApiCall(
          url: Api.getWaterBill, data: {'can': LocalStorages.getCanno() ?? ""});
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var value = WaterBillResponse.fromJson(response.data);
        if ((value.mItem1?.responseCode ?? "0") == "200") {
          setState(() {
            billInfo = value.mItem2!;
          });
        } else {
          EasyLoading.showError(
              value.mItem1?.description ?? "An error 0ccured");
        }
      }
      loadData(false);
    } on DioException catch (ex) {
      loadData(false);
      EasyLoading.dismiss();
      showException(ex);
    }
  }

  download(String pDFlink) async {
    final storageIO = InternetFileStorageIO();

    await InternetFile.get(
      pDFlink,
      storage: storageIO,
      force: true,
      progress: (receivedLength, contentLength) {
        // final percentage = receivedLength / contentLength * 100;
        // print(
        //     'download progress: $receivedLength of $contentLength ($percentage%)');
      },
    );
  }
}
