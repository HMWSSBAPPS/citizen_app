import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hmwssb/core/api/api.dart';
import 'package:hmwssb/core/api/network.dart';
import 'package:hmwssb/core/api/shared_prefernce.dart';
import 'package:hmwssb/core/extensions.dart';
import 'package:hmwssb/core/theme/app_color.dart';
import 'package:hmwssb/presentation/tanker_booking/models/tanker_booked_history_get_model.dart';

class TankersHistoryScreen extends StatefulWidget {
  const TankersHistoryScreen({super.key});

  @override
  State<TankersHistoryScreen> createState() => _TankersHistoryScreenState();
}

class _TankersHistoryScreenState extends State<TankersHistoryScreen> {
  List<TankersHistoryContent> tankersList = <TankersHistoryContent>[];

  @override
  void initState() {
    super.initState();
    isWithDates = false;
    getTankersHistDataApiCall();
  }

  bool isWithDates = false;
  bool isLoading = false;
  void isLoadData(bool val) {
    setState(() {
      isLoading = val;
    });
  }

  Future<void> getTankersHistDataApiCall() async {
    tankersList = <TankersHistoryContent>[];
    isLoadData(true);
    EasyLoading.show(status: 'Loading...');
    try {
      final Response response = await NetworkApiService().commonApiCall(
          url: Api.getTankersHistoryUrl,
          data: isWithDates
              ? {
                  "can": LocalStorages.getCanno() ?? '',
                  "FromDate": firstDate.toString().dmyFormatedDate,
                  "ToDate": lastDate.toString().dmyFormatedDate
                }
              : {"can": LocalStorages.getCanno() ?? ''});
      if (response.statusCode == 200) {
        TankerBookedHistoryGetModel tankerBookedHistoryGetModel =
            TankerBookedHistoryGetModel.fromJson(response.data);
        if (tankerBookedHistoryGetModel.mItem2?.isNotEmpty ?? false) {
          setState(() {
            tankersList = tankerBookedHistoryGetModel.mItem2!;
          });
        }
      }
      isLoadData(false);
      EasyLoading.dismiss();
    } on DioException catch (e) {
      isLoadData(false);
      EasyLoading.dismiss();
      showException(e);
    }
  }

  //?FILTER DATA BASED ON DATES SELECTED
  DateTime lastDate = DateTime.now();
  DateTime firstDate = DateTime.now();
  DateTime initalCalStartDate = DateTime.now();
  DateTime initalCalEndDate = DateTime.now().add(const Duration(days: -180));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              'Tankers History',
              style: TextStyle(color: white),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    isWithDates = false;
                    firstDate = DateTime.now();
                    lastDate = DateTime.now();
                  });
                  getTankersHistDataApiCall();
                },
                icon: const Icon(
                  Icons.refresh,
                  color: white,
                ))
          ],
        ),
      ),
      body: isLoading
          ? const SizedBox.shrink()
          : tankersList.isEmpty
              ? Center(
                  child: Text('No Tankers History Found',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      )))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // SizedBox(height: 10.h),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          openCalenderRange(
                            context,
                            initalCalEndDate,
                            initalCalStartDate,
                            //  DateTime.now().add(const Duration(days: 30))
                          ).then((DateTimeRange? value) {
                            if (value != null) {
                              setState(() {
                                firstDate = value.start;
                                lastDate = value.end;
                                isWithDates = true;
                                getTankersHistDataApiCall();
                              });
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: white,
                              border: Border.all(
                                color: primaryColor,
                              )),
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(
                                  Icons.calendar_month,
                                  color: primaryColor,
                                  size: 20.sp,
                                ),
                                Text(
                                    '${firstDate.toString().dMFormatedDate} to ${lastDate.toString().dMFormatedDate}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(tankersList.length, (index) {
                            return _customCard(
                              context: context,
                              tankerData: tankersList[index],
                            );
                          }),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
    );
  }

  //?Custom History card
  Widget _customCard({
    required BuildContext context,
    required TankersHistoryContent tankerData,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
      child: Container(
        decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(8.0),
            // boxShadow: const <BoxShadow>[
            //   BoxShadow(
            //     color: lightGrey,
            //     blurRadius: 4.0,
            //     spreadRadius: 2.0,
            //     offset: Offset(1, 1),
            //   ),
            //   BoxShadow(
            //     color: lightGrey,
            //     blurRadius: 4.0,
            //     spreadRadius: 2.0,
            //     offset: Offset(-1, -1),
            //   ),
            // ],
            border: Border.all(color: lightBlack)),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          const Text(
                            'CAN : ',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: black,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              tankerData.can ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primary,
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(8.0)),
                        border: Border.all(
                          color: lightBlack,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        tankerData.bookingStatus ?? 'NIL',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: tankerData.bookingStatus == 'DELIVERED'
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              _customLabelAndBodyText(
                label: 'Booking Date',
                body: tankerData.bookingDate,
              ),
              _customLabelAndBodyText(
                label: 'Required Date',
                body: tankerData.requiredDate,
              ),
              _customLabelAndBodyText(
                label: tankerData.bookingStatus == 'CANCELED'
                    ? 'Cancelled Date'
                    : 'Delivered Date',
                body: tankerData.rectifiedDate?.isNotEmpty ?? false
                    ? tankerData.rectifiedDate?.dmyFormattedDateTime ?? ''
                    : '',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: _customLabelAndBodyText(
                      label: 'Pin No.',
                      body: tankerData.pINNo,
                    ),
                  ),
                  Expanded(
                    child: _customLabelAndBodyText(
                      label: 'Tanker Qty',
                      body: tankerData.tankerQty,
                    ),
                  ),
                ],
              ),
              _customLabelAndBodyText(
                label: 'Vehicle No.',
                body: tankerData.vehicleNo,
              ),
              _customLabelAndBodyText(
                label: 'Name',
                body: tankerData.name,
              ),
              _customLabelAndBodyText(
                label: 'Address',
                body: tankerData.address,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //?custom label and body Text
  Widget _customLabelAndBodyText({
    required String label,
    required String? body,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label : ',
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              color: black,
            ),
          ),
          Flexible(
            child: Text(
              body ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<DateTimeRange?> openCalenderRange(
    BuildContext context,
    DateTime? firstDate,
    DateTime? lastDate,
  ) async {
    // printDebug("lastDate is $lastDate and firstDate is $firstDate");
    return await showDateRangePicker(
      saveText: 'Search',
      context: context,
      firstDate: firstDate ?? DateTime.now(),
      lastDate: lastDate ?? DateTime(2050),
      currentDate: lastDate ?? DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );
  }
}
