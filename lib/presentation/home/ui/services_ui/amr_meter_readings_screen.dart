import 'dart:io';
import 'package:dio/dio.dart';
import 'package:excel/excel.dart' as excl;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hmwssb/core/api/api.dart';
import 'package:hmwssb/core/api/network.dart';
import 'package:hmwssb/core/api/shared_prefernce.dart';
import 'package:hmwssb/core/extensions.dart';
import 'package:hmwssb/core/theme/app_color.dart';
import 'package:hmwssb/data/models/amr_reading_models/amr_readings_model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AMRMeterReadingScreen extends StatefulWidget {
  const AMRMeterReadingScreen({super.key});

  @override
  State<AMRMeterReadingScreen> createState() => _AMRMeterReadingScreenState();
}

class _AMRMeterReadingScreenState extends State<AMRMeterReadingScreen> {
  List<CanReadings> readingsList = [];

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
    readingsList = [];
    isLoadData(true);
    try {
      EasyLoading.show(status: "Loading...");
      var postData = {
        "can_number":
            //  '061124886'
            LocalStorages.getCanno() ?? '',
      };

      var response = await NetworkApiService().commonApiCall(
          url: Api.amrReadingsUrl, data: postData, isPostMethod: true);

      if (response.statusCode == 200) {
        AmrReadingsGetModel responsedata =
            AmrReadingsGetModel.fromJson(response.data);
        if (responsedata.error == 0) {
          setState(() {
            readingsList = responsedata.canReadings ?? [];
            filterCanReading = readingsList;
            initalCalStartDate = DateTime.tryParse(
                    readingsList.first.readingDate ??
                        DateTime.now().toString()) ??
                DateTime.now();
            initalCalEndDate = DateTime.tryParse(
                    readingsList.last.readingDate ??
                        DateTime.now().toString()) ??
                DateTime.now();
            lastDate = initalCalStartDate;
            firstDate = initalCalEndDate;

            // if (readingsList.isNotEmpty) {
            //   readingsList.sort((a, b) =>
            //       DateTime.parse(b.readingDate ?? DateTime.now().toString())
            //           .compareTo(DateTime.parse(
            //               a.readingDate ?? DateTime.now().toString())));
            // }
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

  final Map<int, TableColumnWidth>? gridViewColumnWidths =
      <int, TableColumnWidth>{
    0: const FlexColumnWidth(0.20),
    1: const FlexColumnWidth(0.4),
    2: const FlexColumnWidth(0.4),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: primaryColor,
            title: const Text(
              'Readings',
              style: TextStyle(color: white),
            )),
        body: isLoading
            ? const SizedBox.shrink()
            : readingsList.isEmpty
                ? const Center(
                    child: Text('No Data Found',
                        style: TextStyle(
                          fontSize: 18,
                        )),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                openCalenderRange(
                                  context,
                                  initalCalEndDate,
                                  initalCalStartDate,

                                  //  DateTime.now().add(const Duration(days: 30))
                                ).then((DateTimeRange? value) {
                                  if (value != null) {
                                    firstDate = value.start;
                                    lastDate = value.end;
                                    filterBasedOnDates();
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
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 12.0, 16.0, 12.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(
                                        Icons.calendar_month,
                                        color: primaryColor,
                                        size: 24.sp,
                                      ),
                                      Text(
                                          '  ${firstDate.toString().dMFormatedDate} to ${lastDate.toString().dMFormatedDate}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                exportToExcel();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: white,
                                    border: Border.all(
                                      color: primaryColor,
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 12.0,
                                    bottom: 12.0,
                                    left: 8.0,
                                    right: 8.0,
                                  ),
                                  child: Icon(
                                    Icons.file_download_outlined,
                                    color: primaryColor,
                                    size: 18.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                          child: Table(
                              columnWidths: gridViewColumnWidths,
                              border: TableBorder.all(
                                color: lightBlack.withAlpha(153),
                              ),
                              children: <TableRow>[
                                TableRow(children: <Widget>[
                                  _tableHeaderElement(name: 'S No.'),
                                  _tableHeaderElement(name: 'Date'),
                                  _tableHeaderElement(name: 'Readings (KL)'),
                                ])
                              ])),
                      Expanded(
                          child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 2.0, right: 2.0),
                              child: ListView(
                                  shrinkWrap: true,
                                  children: List<Widget>.generate(
                                      filterCanReading.length, (int index) {
                                    CanReadings data = filterCanReading[index];
                                    return Table(
                                      border: TableBorder.all(
                                        color: lightBlack.withAlpha(153),
                                      ),
                                      // border: TableBorder.lerp(
                                      //   const TableBorder(
                                      //     verticalInside: BorderSide.none,
                                      //     // top: BorderSide(color: lightBlack),
                                      //   ),
                                      //   // TableBorder(),
                                      //   TableBorder(
                                      //     // verticalInside: BorderSide.none,
                                      //     top: BorderSide(
                                      //         color:
                                      //             lightBlack.withOpacity(0.6)),
                                      //   ),

                                      //   1.0,
                                      //   // color: lightBlack.withOpacity(0.4),
                                      // ),
                                      columnWidths: gridViewColumnWidths,
                                      children: <TableRow>[
                                        TableRow(
                                          children: <Widget>[
                                            _tableValueElement(
                                                name: '${index + 1}.'),
                                            _tableValueElement(
                                                name: data.readingDate
                                                        ?.dmyFormatedDate ??
                                                    ''),
                                            _tableValueElement(
                                                name: data.reading
                                                        // .toString()
                                                        ?.toStringAsFixed(2) ??
                                                    '0.0'),
                                          ],
                                        ),
                                      ],
                                    );
                                  }))))
                    ],
                  ));
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

  //?FILTER DATA BASED ON DATES SELECTED
  DateTime lastDate = DateTime.now();
  DateTime firstDate = DateTime.now();
  DateTime initalCalStartDate = DateTime.now();
  DateTime initalCalEndDate = DateTime.now();
  List<CanReadings> filterCanReading = <CanReadings>[];
  Future<void> filterBasedOnDates() async {
    if (readingsList.isNotEmpty) {
      filterCanReading = readingsList
          .where((CanReadings element) =>
              (DateTime.parse(element.readingDate!)
                      .isAfterOrEqualTo(firstDate) ??
                  false) &&
              (DateTime.parse(element.readingDate!)
                      .isBeforeOrEqualTo(lastDate) ??
                  false))
          .toList();
    } else {
      filterCanReading = readingsList;
    }

    setState(() {});
  }

  Future<void> exportToExcel() async {
    // Create an Excel document
    if (filterCanReading.isNotEmpty) {
      filterCanReading.sort((CanReadings a, CanReadings b) =>
          DateTime.parse(b.readingDate!)
              .compareTo(DateTime.parse(a.readingDate!)));
      excl.Excel excel = excl.Excel.createExcel();
      excl.Sheet sheetObject = excel['Sheet1'];

      // Append the header row
      sheetObject.appendRow(<excl.CellValue>[
        excl.TextCellValue('S No.'),
        excl.TextCellValue('Date'),
        excl.TextCellValue('Readings'),
      ]);

      // Append data rows
      for (final CanReadings entry in filterCanReading) {
        sheetObject.appendRow(<excl.CellValue>[
          excl.IntCellValue(filterCanReading.indexOf(entry) + 1),
          // TextCellValue('${filterCanReading.indexOf(entry) + 1}'),
          excl.TextCellValue(entry.readingDate ?? ''),
          excl.TextCellValue(
              double.parse('${entry.reading ?? 0.0}').toStringAsFixed(2)),
        ]);
      }

      // Save the file to the device

      if (await Permission.storage.request().isGranted) {
        Directory? downloadsFolder = await getDownloadsDirectory();
        if (downloadsFolder != null) {
          String fileName = 'amr_meter_readings.xlsx';
          String filePath = '${downloadsFolder.path}/$fileName';
          List<int>? fileBytes = excel.encode();
          File file = File(filePath);
          if (file.existsSync()) {
            file.deleteSync();
          }
          await file.writeAsBytes(fileBytes!);

          EasyLoading.showToast('File saved: $filePath',
              toastPosition: EasyLoadingToastPosition.bottom);
          // printDebug("filePath $filePath");

          await OpenFile.open(filePath);
        } else {
          EasyLoading.showToast(
              'Something went wrong while downloading the file',
              toastPosition: EasyLoadingToastPosition.bottom);
        }
      } else {
        EasyLoading.showToast('Allow Storage Permission Manually',
            toastPosition: EasyLoadingToastPosition.bottom);
      }
    } else {
      EasyLoading.showToast('No Data Found',
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  Widget _tableHeaderElement({required String name}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        name,
        style: const TextStyle(
          color: primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _tableValueElement({required String? name}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        name?.trim().isEmpty ?? true ? '-' : name!.trim(),
        style: const TextStyle(),
      ),
    );
  }
}
