import 'package:hmwssb/core/api/shared_prefernce.dart';
import 'package:hmwssb/presentation/home/dashboard_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hmwssb/core/api/api.dart';
import 'package:hmwssb/core/api/network.dart';
import 'package:hmwssb/core/theme/app_color.dart';
import 'package:hmwssb/data/models/cans_by_mobile.dart';

// import 'package:hmwssb/data/models/can_info_model.dart' as canInfo;
// import 'package:hmwssb/data/models/cans_by_mobile.dart' as cansByMobile;

class SwitchCan extends StatefulWidget {
  const SwitchCan({super.key});

  @override
  State<SwitchCan> createState() => _SwitchCanState();
}

class _SwitchCanState extends State<SwitchCan> {
  List<MItem2> cansList = [];

  @override
  void initState() {
    super.initState();
    getCanInfoByMobile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: primaryColor,
        title: const Text(
          'Switch CAN',
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
      body: isLoading
          ? const SizedBox.shrink()
          : cansList.isEmpty
              ? const Center(
                  child: Text(
                    'No Cans Found',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              : ListView.builder(
                  itemCount: cansList.length,
                  itemBuilder: (context, index) {
                    final payment = cansList[index];
                    return Card(elevation: 4, child: statusCard(payment));
                  },
                ),
    );
  }

  Widget statusCard(MItem2 value) {
    return GestureDetector(
      onTap: () async {
        // SharedPreferences pref = await SharedPreferences.getInstance();
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text(
                  'Do you want to switch the CAN?',
                  style: TextStyle(fontSize: 16),
                ),
                content: const Text(''),
                actions: <Widget>[
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text('No'),
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      if (context.mounted) {
                        // pref.setString(
                        //     ShareKey.MOBILE_NUMBER, value.mobileno ?? "");
                        // pref.setString(ShareKey.NAME, value.name ?? "");
                        // pref.setString(ShareKey.CANNO, value.can ?? "");
                        // pref.setString(
                        //     ShareKey.PIPESIZE, value.waterPipesizeInMM ?? "");
                        // pref.setString(ShareKey.ADDRESS, value.address ?? "");
                        // pref.setString(ShareKey.LATITUDE, value.latitude ?? "");
                        // pref.setString(
                        //     ShareKey.LONGITUDE, value.longitude ?? "");
                        // LocalStorage.saveUserData(
                        //   mobileNumber: value.mobileno,
                        //   name: value.name,
                        //   canno: value.can,
                        //   pipeSize: value.waterPipesizeInMM,
                        //   address: value.address,
                        //   latitude: value.latitude,
                        //   longitude: value.longitude,
                        // );

                        LocalStorages.saveUserData(
                          localSaveType: LocalSaveType.mobileNumber,
                          value: value.mobileno,
                        );
                        LocalStorages.saveUserData(
                          localSaveType: LocalSaveType.name,
                          value: value.name,
                        );
                        LocalStorages.saveUserData(
                          localSaveType: LocalSaveType.canno,
                          value: value.cAN,
                        );
                        LocalStorages.saveUserData(
                          localSaveType: LocalSaveType.pipeSize,
                          value: value.waterPipesizeInMM,
                        );
                        LocalStorages.saveUserData(
                          localSaveType: LocalSaveType.address,
                          value: value.address,
                        );
                        LocalStorages.saveUserData(
                          localSaveType: LocalSaveType.latitude,
                          value: value.latitude,
                        );
                        LocalStorages.saveUserData(
                          localSaveType: LocalSaveType.longitude,
                          value: value.longitude,
                        );
                        LocalStorages.saveUserData(
                            localSaveType: LocalSaveType.isFirstLogin,
                            value: false);
                        LocalStorages.saveUserData(
                            localSaveType: LocalSaveType.rwhFlag,
                            value: value.rWHFlag);
                        LocalStorages.saveUserData(
                            localSaveType: LocalSaveType.latLongEdit,
                            value: value.isLatLongEditible);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DashboardScreen()),
                          // ModalRoute.withName("/dashboard")
                          // (Route<dynamic> route) => false,
                        );
                      }
                    },
                    child: const Text('Yes'),
                  ),
                ],
              );
            });
      },
      child:
          // Card(
          //   elevation: 4,
          //   child:
          Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withAlpha(128), offset: const Offset(1, 1)),
            BoxShadow(
                color: Colors.grey.withAlpha(128),
                offset: const Offset(-1, -1)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('CAN: ${value.cAN}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              Text('Name: ${value.name}',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
              Text('Address: ${value.address}',
                  style: const TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
      // ),
    );
  }

  bool isLoading = false;
  bool loadData(bool val) {
    isLoading = val;
    setState(() {});
    return isLoading;
  }

  getCanInfoByMobile() async {
    loadData(true);
    try {
      EasyLoading.show(status: "Loading...");
      // SharedPreferences pref = await SharedPreferences.getInstance();
      var response = await NetworkApiService().commonApiCall(
          url: Api.canInfoByMobile,
          data: {'mobileNo': LocalStorages.getMobileNumber() ?? ''});
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var value = CansByMobile.fromJson(response.data);
        if ((value.mItem1?.responseCode ?? "0") != "200") {
          EasyLoading.showError(
              value.mItem1?.description ?? "An error 0ccured");
        } else {
          setState(() {
            cansList = value.mItem2!;
          });
        }
      }
      loadData(false);
    } on DioException catch (ex) {
      loadData(false);
      EasyLoading.dismiss();
      showException(ex);
    }
  }
}
