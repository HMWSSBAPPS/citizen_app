import 'package:hmwssb/core/api/shared_prefernce.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hmwssb/core/api/api.dart';
import 'package:hmwssb/core/api/network.dart';
import 'package:hmwssb/core/theme/app_color.dart';
import 'package:hmwssb/data/models/complaint_status.dart';

class ComplainStatus extends StatefulWidget {
  const ComplainStatus({super.key});

  @override
  State<ComplainStatus> createState() => _ComplainStatusState();
}

class _ComplainStatusState extends State<ComplainStatus> {
  List<MItem2> complaintsList = [];

  @override
  void initState() {
    super.initState();
    initPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: primaryColor,
          title: const Text(
            'Complaint Status',
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
        body: ListView.builder(
          itemCount: complaintsList.length,
          itemBuilder: (context, index) {
            final complaint = complaintsList[index];
            return Card(elevation: 4, child: statusCard(complaint));
          },
        ));
  }

  void initPreferences() async {
    getComplaints();
  }

  Widget statusCard(MItem2 complaint) {
    return
        //  Card(
        //   elevation: 4,
        //   child:
        Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withAlpha(127), offset: const Offset(1, 1)),
          BoxShadow(
              color: Colors.grey.withAlpha(127),
              offset: const Offset(-1, -1)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('CAN: ${complaint.can}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Complaint Number: ${complaint.complaintNumber}',
                style: const TextStyle(fontSize: 18)),

            Text('Reason: ${complaint.complaintReason}',
                style: const TextStyle(fontSize: 18)),
            Text('Received Date: ${complaint.recievedDate}',
                style: const TextStyle(fontSize: 18)),
            // Text('Contact Number: ${complaint.contactNo}',
            //     style: const TextStyle(fontSize: 18)),
            Text('Status: ${complaint.complStatus}',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryColor)),
          ],
        ),
      ),
      // ),
    );
  }

  getComplaints() async {
    try {
      EasyLoading.show(status: "Loading...");
      var response = await NetworkApiService().commonApiCall(
          url: Api.getComplaintsStatus,
          data: {'can': LocalStorages.getCanno() ?? ""});
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var value = ComplaintStatus.fromJson(response.data);
        if ((value.mItem1?.responseCode ?? "0") != "200") {
          EasyLoading.showError(
              value.mItem1?.description ?? "An error 0ccured");
        } else {
          if (value.mItem2?.isNotEmpty == true) {
            setState(() {
              complaintsList = value.mItem2!;
            });
          } else {
            EasyLoading.showInfo("No complaints Found");
          }
        }
      }
    } on DioException catch (ex) {
      EasyLoading.dismiss();
      showException(ex);
    }
  }
}
