import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hmwssb/core/api/api.dart';
import 'package:hmwssb/core/api/network.dart';
import 'package:hmwssb/core/api/shared_prefernce.dart';
import 'package:hmwssb/core/theme/app_color.dart';
import 'package:hmwssb/data/models/notices_models/consumer_get_notices.dart';
import 'package:hmwssb/presentation/home/ui/services_ui/notices_screens/notices_screens_index.dart';

class NoticesListScreen extends StatefulWidget {
  const NoticesListScreen({super.key});

  @override
  State<NoticesListScreen> createState() => _NoticesListScreenState();
}

class _NoticesListScreenState extends State<NoticesListScreen> {
  List<NoticesModel> noticeList = [];

  @override
  void initState() {
    super.initState();
    getNoticesListApiCall();
  }

  bool isLoading = false;
  bool isLoadData(bool val) {
    isLoading = val;
    return isLoading;
  }

  Future<void> getNoticesListApiCall() async {
    noticeList = [];
    isLoadData(true);
    try {
      EasyLoading.show(status: "Loading...");
      var postData = {"can_number": LocalStorages.getCanno() ?? ''};

      var response = await NetworkApiService().commonApiCall(
          url: Api.noticesListUrl, data: postData, isPostMethod: true);

      if (response.statusCode == 200) {
        var responsedata = ConsumerGetNoticesModel.fromJson(response.data);
        if (responsedata.error == 0) {
          setState(() {
            noticeList = responsedata.notices ?? [];
          });
        } else {
          EasyLoading.showInfo("Error Occured");
        }
      } else {
        throw Exception('Failed to load data');
      }

      EasyLoading.dismiss();
      setState(() {
        isLoadData(false);
      });
    } on DioException catch (ex) {
      EasyLoading.dismiss();
      showException(ex);
      setState(() {
        isLoadData(false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: primaryColor,
          title: const Text(
            'Notices',
            style: TextStyle(color: white),
          )),
      body: isLoading
          ? const SizedBox.shrink()
          : noticeList.isEmpty
              ? const Center(
                  child: Text('No Notices Found',
                      style: TextStyle(
                        fontSize: 20,
                      )),
                )
              : Column(
                  children: List.generate(
                  noticeList.length,
                  (index) => noticesItemDataWidget(
                      context: context, notice: noticeList[index]),
                )),
    );
  }

  Widget noticesItemDataWidget({
    required BuildContext context,
    required NoticesModel notice,
  }) {
    return Card(
        elevation: 3,
        color: white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   notice.canNumber.toString(),
              //   style: const TextStyle(fontSize: 14, color: primaryColor),
              // ),
              // const SizedBox(
              //   height: 5,
              // ),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  "Date : ${notice.sentDate ?? ''}",
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
              Text(
                "Agency Name: ${notice.agency ?? ''}",
                style: const TextStyle(fontSize: 18, color: Colors.black),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Pipe Size: ${notice.pipeSize ?? ''}",
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Text(
                    "Reading: ${notice.reading ?? ''}",
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "Meter Make : ${notice.meterMake ?? ''}",
                style: const TextStyle(fontSize: 18, color: Colors.black),
              ),

              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(primaryColor),
                    ),
                    onPressed: () async {
                      Route route = MaterialPageRoute(
                        builder: (context) =>
                            NoticesPDFViewScreen(details: notice),
                      );
                      Navigator.push(context, route);
                    },
                    child: const Text('View Notice',
                        style: TextStyle(color: white)),
                  ),
                  if (int.parse(notice.takeReply ?? '0') == 1)
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(primaryColor),
                      ),
                      onPressed: () async {
                        // shareNotice();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NoticeReplySubmitScreen(
                                    noticeId: '${notice.id ?? 0}')));
                      },
                      child:
                          const Text('Reply', style: TextStyle(color: white)),
                    )
                  else
                    const Text('Reply Submitted',
                        style: TextStyle(fontSize: 18, color: Colors.green)),
                ],
              )
            ],
          ),
        ));
  }
}
