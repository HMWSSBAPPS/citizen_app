import 'dart:developer';
import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hmwssb/core/api/shared_prefernce.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hmwssb/core/api/api.dart';
import 'package:hmwssb/core/api/network.dart';
import 'package:hmwssb/core/theme/app_color.dart';
import 'package:hmwssb/presentation/side_menu/models/payment_history_model.dart';
import 'package:intl/intl.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({super.key});

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  List<MItem2> paymentHistory = [];

  @override
  void initState() {
    super.initState();
    getBillHistory();
  }

  bool isLoading = false;
  bool isLoadData(bool val) {
    isLoading = val;
    return isLoading;
  }

  ///Here:
  ///pass: 0 ->5 columns
  ///pass: 1 ->4 columns
  ///pass: 2 ->3 columns
  int isTotalColumnWidgets = 0;
  //?These bools are for view and hide columns
  bool isRebateColumn = false;
  bool isAdjustColumn = false;
  bool isBothColumn = false;

  getBillHistory() async {
    isLoadData(true);
    try {
      EasyLoading.show(status: "Loading...");
      var response = await NetworkApiService().commonApiCall(
          url: Api.getPaymentHitory,
          data: {'can': LocalStorages.getCanno() ?? ""});
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        // log(jsonEncode(response.data).toString());
        var value = PaymentHistoryModel.fromJson(response.data);
        if ((value.mItem1?.responseCode ?? "0") == "200") {
          if (value.mItem2!.isEmpty) {
            EasyLoading.showInfo("No History Found");
          }
          setState(() {
            paymentHistory = value.mItem2!;
            isAdjustColumn = paymentHistory.every((e) => e.adjustments == 0.0);
            isRebateColumn = paymentHistory.every((e) => e.rebate == 0.0);
            isBothColumn = isRebateColumn && isAdjustColumn;
            isTotalColumnWidgets = isAdjustColumn ? 3 : 0;
            isTotalColumnWidgets = isBothColumn
                ? 2
                : isAdjustColumn || isRebateColumn
                    ? 1
                    : 0;
          });
          _filterPaymentHisGraphData();
        } else {
          EasyLoading.showError(
              value.mItem1?.description ?? "An error 0ccured");
        }
      }
      isLoadData(false);
    } on DioException catch (ex) {
      EasyLoading.dismiss();
      showException(ex);
      isLoadData(false);
    }
  }

  double maxValue = 500.0;
  List<CustomBarChartModel> dailyGraphData = <CustomBarChartModel>[];

  void _filterPaymentHisGraphData() async {
    final DateFormat format = DateFormat('MMM-yyyy');
    dailyGraphData = <CustomBarChartModel>[];

    if (paymentHistory.isNotEmpty) {
      paymentHistory.sort((a, b) {
        DateTime dateA = format.parse(a.billMonth ?? DateTime.now().toString());
        DateTime dateB = format.parse(b.billMonth ?? DateTime.now().toString());
        return dateB.compareTo(dateA); // Sort in descending order
      });

      final List<MItem2> latestReadings = paymentHistory.length > 6
          ? paymentHistory.take(6).toList()
          : paymentHistory;

      for (final MItem2 element in latestReadings) {
        // log("message ${element.billMonth} ${element.collection} ${element.demand}");
        double demandValue = element.demand ?? 0.0;
        if (!demandValue.isInfinite && !demandValue.isNaN) {
          dailyGraphData.add(CustomBarChartModel(
            month: element.billMonth ?? '',
            demand: demandValue,
            collection: element.collection ?? 0.0,
            color: _getRandomColor(),
          ));
        }
      }
      double highestCollectionValue = dailyGraphData
          .map((bill) => bill.collection as double? ?? 0.0)
          .reduce((curr, next) => curr > next ? curr : next);
      double highestDemandValue = dailyGraphData
          .map((bill) => bill.demand as double? ?? 0.0)
          .reduce((curr, next) => curr > next ? curr : next);
      bool isFirstDemandHighVal = highestDemandValue > highestCollectionValue;
      // dailyGraphData.forEach((e) => log('collection: ${e.collection}'));

      // if (dailyGraphData
      //     .every((e) => e.collection == 0.0 || e.collection == 0)) {
      //   // Filter out 0.0 or 0 from dailyGraphData
      //   final List<CustomBarChartModel> nonZeroDemandData = dailyGraphData
      //       .where((e) => e.demand != 0 && e.demand != 0.0)
      //       .toList();

      //   if (nonZeroDemandData.isNotEmpty) {
      //     maxValue = nonZeroDemandData.first.demand;

      //     for (final CustomBarChartModel ele in nonZeroDemandData) {
      //       double units = ele.demand;
      //       if (!units.isInfinite && !units.isNaN) {
      //         if (units > maxValue) {
      //           maxValue = units;
      //         }
      //       }
      //     }
      //   }
      //   // print("e.collection maxValue $maxValue");
      //   //else {
      //   //   maxValue = 0.0; // Default to 0 if no non-zero values are found
      //   // }
      // } else {
      //   // Filter out 0.0 or 0 from dailyGraphData
      //   final List<CustomBarChartModel> nonZeroCollectionData = dailyGraphData
      //       .where((e) => e.collection != 0 && e.collection != 0.0)
      //       .toList();

      //   if (nonZeroCollectionData.isNotEmpty) {
      //     maxValue = nonZeroCollectionData.first.collection;

      //     for (final CustomBarChartModel ele in nonZeroCollectionData) {
      //       double units = ele.collection;
      //       if (!units.isInfinite && !units.isNaN) {
      //         if (units > maxValue) {
      //           maxValue = units;
      //         }
      //       }
      //     }
      //   }
      //   // print("e.demand maxValue $maxValue");
      //   //  else {
      //   //   maxValue = 0.0; // Default to 0 if no non-zero values are found
      //   // }
      // }

      maxValue = isFirstDemandHighVal
          ? highestDemandValue // Use highestDemandValue
          : highestCollectionValue; // Use highestCollectionValue

      if (maxValue.isNaN || maxValue.isInfinite) {
        maxValue = 0.0;
      }
    }
    log("maxValue $maxValue");

    setState(() {});
  }

  Color _getRandomColor() {
    // Define a minimum value for RGB to avoid light colors
    const int minColorValue = 50; // Minimum RGB value
    const int maxColorValue =
        200; // Maximum RGB value to avoid very dark colors

    int r =
        minColorValue + math.Random().nextInt(maxColorValue - minColorValue);
    int g =
        minColorValue + math.Random().nextInt(maxColorValue - minColorValue);
    int b =
        minColorValue + math.Random().nextInt(maxColorValue - minColorValue);

    return Color.fromARGB(255, r, g, b);
  }

  Map<int, TableColumnWidth>? threeWidgetsWidths = <int, TableColumnWidth>{
    0: const FlexColumnWidth(0.34),
    1: const FlexColumnWidth(0.33),
    2: const FlexColumnWidth(0.33),
    // 3: const FlexColumnWidth(0.25),
  };

  Map<int, TableColumnWidth>? fourWidgetsWidths = <int, TableColumnWidth>{
    0: const FlexColumnWidth(0.28),
    1: const FlexColumnWidth(0.24),
    2: const FlexColumnWidth(0.24),
    3: const FlexColumnWidth(0.24),
    // 4: const FlexColumnWidth(0.20),
  };

  Map<int, TableColumnWidth>? fiveWidgetsWidths = <int, TableColumnWidth>{
    0: const FlexColumnWidth(0.24),
    1: const FlexColumnWidth(0.19),
    2: const FlexColumnWidth(0.19),
    3: const FlexColumnWidth(0.19),
    4: const FlexColumnWidth(0.19),
    // 5: const FlexColumnWidth(0.15),
  };

  Map<int, TableColumnWidth>? totalWidgetWidth() {
    return isTotalColumnWidgets == 2
        ? threeWidgetsWidths
        : isTotalColumnWidgets == 1
            ? fourWidgetsWidths
            : fiveWidgetsWidths;
  }

  bool isGridView = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const SizedBox.shrink()
        : paymentHistory.isEmpty
            ? const Center(
                child: Text(
                  'No Payment History Found',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton.icon(
                      onPressed: () {
                        setState(() {
                          isGridView = !isGridView;
                          _filterPaymentHisGraphData();
                        });
                      },
                      icon: Icon(
                        isGridView
                            ? Icons.table_rows_sharp
                            : Icons.graphic_eq_rounded,
                        color: primaryColor,
                      ),
                      label: Text(isGridView ? 'Grid View' : 'Graph View'),
                    ),
                  ),
                  Expanded(
                    child: isGridView
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                      height: 14.h,
                                      width: 14.w,
                                      decoration: const BoxDecoration(
                                          color: primaryColor,
                                          shape: BoxShape.rectangle)),
                                  const SizedBox(width: 8),
                                  const Text('Demand   ',
                                      style: TextStyle(
                                        color: black,
                                        fontWeight: FontWeight.w500,
                                      )),
                                  Container(
                                      height: 14.h,
                                      width: 14.w,
                                      decoration: const BoxDecoration(
                                          color: Colors.green,
                                          shape: BoxShape.rectangle)),
                                  const SizedBox(width: 8),
                                  const Text('Collection   ',
                                      style: TextStyle(
                                          color: black,
                                          fontWeight: FontWeight.w500))
                                ],
                              ),
                              Expanded(
                                  child:
                                      // Row(children: [
                                      //   const SizedBox(width: 8),
                                      //   // The centered "Consumption" text
                                      //   const RotatedBox(
                                      //     quarterTurns: 3,
                                      //     child: Text(
                                      //       'Demand & Collection',
                                      //       style: TextStyle(
                                      //         color: Colors.black,
                                      //         fontSize: 16,
                                      //         fontWeight: FontWeight.bold,
                                      //       ),
                                      //     ),
                                      //   ),
                                      //   Expanded(
                                      //       child:
                                      // BarChart(BarChartData(
                                      //     borderData: FlBorderData(
                                      //       border: const Border(
                                      //           left: BorderSide(),
                                      //           bottom: BorderSide()),
                                      //     ),
                                      //     maxY: (maxValue / 10).ceil() * 10 + 50,
                                      //     minY: 0,
                                      //     gridData: const FlGridData(show: false),
                                      //     titlesData: FlTitlesData(
                                      //       bottomTitles: AxisTitles(
                                      //           sideTitles: SideTitles(
                                      //         showTitles: true,
                                      //         getTitlesWidget:
                                      //             (double value, TitleMeta meta) {
                                      //           int index = value.toInt();
                                      //           if (index < 0 ||
                                      //               index >=
                                      //                   dailyGraphData.length) {
                                      //             return const Text('');
                                      //           }
                                      //           return Text(
                                      //             dailyGraphData[index]
                                      //                 .month
                                      //                 .split('-')
                                      //                 .first,
                                      //             style: const TextStyle(
                                      //                 color: Colors.black,
                                      //                 fontSize: 12),
                                      //           );
                                      //         },
                                      //       )),
                                      //       topTitles: const AxisTitles(),
                                      //       rightTitles: const AxisTitles(),
                                      //       // leftTitles: AxisTitles(
                                      //       //     sideTitles: SideTitles(
                                      //       //   showTitles: true,
                                      //       //   reservedSize: 30,
                                      //       //   interval: 10,
                                      //       //   getTitlesWidget: (double value,
                                      //       //       TitleMeta meta) {
                                      //       //     return Row(
                                      //       //       children: [
                                      //       //         Text(
                                      //       //           ' ${value.toInt()}',
                                      //       //           style: const TextStyle(
                                      //       //               color: Colors.black,
                                      //       //               fontSize: 12),
                                      //       //         ),
                                      //       //       ],
                                      //       //     );
                                      //       //   },
                                      //       // ))
                                      //     ),
                                      //     barGroups: dailyGraphData
                                      //         .map((CustomBarChartModel e) {
                                      //       double collectionValue = e.collection;
                                      //       return BarChartGroupData(
                                      //         x: dailyGraphData.indexOf(e),
                                      //         barRods: <BarChartRodData>[
                                      //           BarChartRodData(
                                      //               borderRadius: BorderRadius.zero,
                                      //               toY: collectionValue,
                                      //               width: (MediaQuery.of(context)
                                      //                           .size
                                      //                           .width *
                                      //                       .6) /
                                      //                   dailyGraphData.length,
                                      //               color: primaryColor
                                      //               // e.color,
                                      //               ),
                                      //         ],
                                      //       );
                                      //     }).toList(),
                                      //     barTouchData: BarTouchData(
                                      //         touchTooltipData: BarTouchTooltipData(
                                      //       getTooltipColor:
                                      //           (BarChartGroupData group) {
                                      //         return Colors.white;
                                      //       },
                                      //       tooltipBorder: const BorderSide(),
                                      //       // getTooltipItem:
                                      //       //     (BarChartGroupData group,
                                      //       //         int groupIndex,
                                      //       //         BarChartRodData rod,
                                      //       //         int rodIndex) {
                                      //       //   final String month =
                                      //       //       dailyGraphData[group.x]
                                      //       //           .month
                                      //       //           .split('-')
                                      //       //           .first;
                                      //       //   final double demand =
                                      //       //       dailyGraphData[group.x].demand;
                                      //       //   final double collection =
                                      //       //       dailyGraphData[group.x]
                                      //       //           .collection;
                                      //       //   // final double value = rod.toY;
                                      //       //   return BarTooltipItem(
                                      //       //       'Month: $month\nDemand: $demand\nCollection: $collection',
                                      //       //       TextStyle(
                                      //       //         color:
                                      //       //             rod.color ?? Colors.black,
                                      //       //         fontSize: 14,
                                      //       //         fontWeight: FontWeight.bold,
                                      //       //       ));
                                      //       // },
                                      //       getTooltipItem:
                                      //           (BarChartGroupData group,
                                      //               int groupIndex,
                                      //               BarChartRodData rod,
                                      //               int rodIndex) {
                                      //         final String month =
                                      //             dailyGraphData[group.x]
                                      //                 .month
                                      //                 .split('-')
                                      //                 .first;
                                      //         final double demand =
                                      //             dailyGraphData[group.x].demand;
                                      //         final double collection =
                                      //             dailyGraphData[group.x]
                                      //                 .collection;
                                      //         return BarTooltipItem(
                                      //           '',
                                      //           const TextStyle(),
                                      //           children: <TextSpan>[
                                      //             const TextSpan(
                                      //               text: 'Month: ',
                                      //               style: TextStyle(
                                      //                 color: Colors
                                      //                     .black, // or any default color
                                      //                 fontSize: 14,
                                      //                 // fontWeight: FontWeight.bold,
                                      //               ),
                                      //             ),
                                      //             TextSpan(
                                      //               text: '$month\n',
                                      //               style: const TextStyle(
                                      //                 color:
                                      //                     black, // color for month
                                      //                 fontSize: 14,
                                      //                 fontWeight: FontWeight.bold,
                                      //               ),
                                      //             ),
                                      //             const TextSpan(
                                      //               text: 'Demand: ',
                                      //               style: TextStyle(
                                      //                 color: Colors
                                      //                     .black, // or any default color
                                      //                 fontSize: 14,
                                      //                 // fontWeight: FontWeight.bold,
                                      //               ),
                                      //             ),
                                      //             TextSpan(
                                      //               text: '$demand\n',
                                      //               style: const TextStyle(
                                      //                 color:
                                      //                     primaryColor, // color for demand
                                      //                 fontSize: 14,
                                      //                 fontWeight: FontWeight.bold,
                                      //               ),
                                      //             ),
                                      //             const TextSpan(
                                      //               text: 'Collection: ',
                                      //               style: TextStyle(
                                      //                 color: Colors
                                      //                     .black, // or any default color
                                      //                 fontSize: 14,
                                      //                 // fontWeight: FontWeight.bold,
                                      //               ),
                                      //             ),
                                      //             TextSpan(
                                      //               text: '$collection',
                                      //               style: const TextStyle(
                                      //                 color:
                                      //                     primary, // color for collection
                                      //                 fontSize: 14,
                                      //                 fontWeight: FontWeight.bold,
                                      //               ),
                                      //             ),
                                      //           ],
                                      //         );
                                      //       },
                                      //     )))))
                                      Padding(
                                padding: EdgeInsets.only(top: 20.sp),
                                child: BarChart(
                                  BarChartData(
                                    borderData: FlBorderData(
                                        border: const Border(
                                            left: BorderSide(),
                                            bottom: BorderSide())),
                                    maxY: (maxValue / 10).ceil() * 10 + 50,
                                    minY: 0,
                                    gridData: const FlGridData(show: false),
                                    titlesData: FlTitlesData(
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          getTitlesWidget:
                                              (double value, TitleMeta meta) {
                                            int index = value.toInt();
                                            if (index < 0 ||
                                                index >=
                                                    dailyGraphData.length) {
                                              return const Text('');
                                            }
                                            return Text(
                                              dailyGraphData[index]
                                                  .month
                                                  .split('-')
                                                  .first,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                            );
                                          },
                                        ),
                                      ),
                                      topTitles: const AxisTitles(),
                                      rightTitles: const AxisTitles(),
                                      // leftTitles: AxisTitles(
                                      //   sideTitles: SideTitles(
                                      //     showTitles: true,
                                      //     reservedSize: 30,
                                      //     interval: 10,
                                      //     getTitlesWidget:
                                      //         (double value, TitleMeta meta) {
                                      //       return Text(
                                      //         value.toInt().toString(),
                                      //         style: const TextStyle(
                                      //             color: Colors.black,
                                      //             fontSize: 12),
                                      //       );
                                      //     },
                                      //   ),
                                      // ),
                                    ),
                                    barGroups: dailyGraphData
                                        .map((CustomBarChartModel e) {
                                      return BarChartGroupData(
                                        x: dailyGraphData.indexOf(e),
                                        barRods: [
                                          BarChartRodData(
                                            borderRadius: BorderRadius.zero,
                                            toY: e.demand,
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .6) /
                                                (dailyGraphData.length * 2),
                                            color: primaryColor,
                                            //  Colors.red, // Color for demand
                                            // Adding value on top of the demand bar
                                            backDrawRodData:
                                                BackgroundBarChartRodData(
                                              show: true,
                                              toY: e.demand,
                                              color: Colors.transparent,
                                            ),
                                            rodStackItems: [
                                              BarChartRodStackItem(
                                                0,
                                                e.demand,
                                                primaryColor,
                                                // TextSpan(
                                                //   text: e.demand.toString(),
                                                //   style: TextStyle(color: Colors.red, fontSize: 12),
                                                // ),
                                              ),
                                            ],
                                          ),
                                          BarChartRodData(
                                            borderRadius: BorderRadius.zero,
                                            toY: e.collection,
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .6) /
                                                (dailyGraphData.length * 2),
                                            color: Colors
                                                .green, // Color for collection
                                            // Adding value on top of the collection bar
                                            backDrawRodData:
                                                BackgroundBarChartRodData(
                                              show: true,
                                              toY: e.collection,
                                              color: Colors.transparent,
                                            ),
                                            rodStackItems: [
                                              BarChartRodStackItem(
                                                e.collection,
                                                e.collection,
                                                Colors.green,
                                                // BorderSide(
                                                //   color: Colors.black,
                                                // )
                                                // TextSpan(
                                                //   text: e.collection.toString(),
                                                //   style: TextStyle(color: Colors.green, fontSize: 12),
                                                // ),
                                              ),
                                            ],
                                          ),
                                        ],
                                        barsSpace:
                                            4, // Space between demand and collection bars
                                      );
                                    }).toList(),
                                    barTouchData: BarTouchData(
                                      touchTooltipData: BarTouchTooltipData(
                                        getTooltipColor:
                                            (BarChartGroupData group) {
                                          return Colors.white;
                                        },
                                        tooltipBorder: const BorderSide(),
                                        getTooltipItem:
                                            (BarChartGroupData group,
                                                int groupIndex,
                                                BarChartRodData rod,
                                                int rodIndex) {
                                          final String month =
                                              dailyGraphData[group.x]
                                                  .month
                                                  .split('-')
                                                  .first;
                                          final double demand =
                                              dailyGraphData[group.x].demand;
                                          final double collection =
                                              dailyGraphData[group.x]
                                                  .collection;

                                          return BarTooltipItem(
                                            '',
                                            const TextStyle(),
                                            children: <TextSpan>[
                                              const TextSpan(
                                                text: 'Month: ',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              TextSpan(
                                                text: '$month\n',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const TextSpan(
                                                text: 'Demand: ',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              TextSpan(
                                                text: '$demand\n',
                                                style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const TextSpan(
                                                text: 'Collection: ',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              TextSpan(
                                                text: '$collection',
                                                style: const TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                              // ]),
                              // ),
                            ],
                          )
                        : Column(
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 2.0, right: 2.0),
                                  child: Table(
                                      border: isTotalColumnWidgets != 0
                                          ? TableBorder.all(
                                              color: lightBlack,
                                            )
                                          : null,
                                      columnWidths: totalWidgetWidth(),
                                      children: <TableRow>[
                                        TableRow(children: <Widget>[
                                          _tableHeaderElement(name: 'Month'),
                                          // _tableHeaderElement(
                                          //     name: 'Bill Date'),
                                          _tableHeaderElement(name: 'Bill'),
                                          if (!isRebateColumn)
                                            _tableHeaderElement(name: 'Rebate'),
                                          _tableHeaderElement(name: 'Paid'),
                                          if (!isAdjustColumn)
                                            _tableHeaderElement(name: 'Adjust'),
                                        ])
                                      ])),
                              Expanded(
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 2.0, right: 2.0),
                                      child: ListView(
                                          shrinkWrap: true,
                                          children: List<Widget>.generate(
                                              paymentHistory.length,
                                              (int index) {
                                            MItem2 data = paymentHistory[index];
                                            return Table(
                                              border: isTotalColumnWidgets != 0
                                                  ? TableBorder.all(
                                                      color: lightBlack)
                                                  : TableBorder.lerp(
                                                      const TableBorder(
                                                        verticalInside:
                                                            BorderSide.none,
                                                        // top: BorderSide(color: lightBlack),
                                                      ),
                                                      // TableBorder(),
                                                      TableBorder(
                                                        // verticalInside: BorderSide.none,
                                                        top: BorderSide(
                                                            color: lightBlack
                                                                .withAlpha(
                                                                    153)),
                                                      ),

                                                      1.0,
                                                      // color: lightBlack.withOpacity(0.4),
                                                    ),
                                              columnWidths: totalWidgetWidth(),
                                              children: <TableRow>[
                                                TableRow(
                                                  children: <Widget>[
                                                    _tableValueElement(
                                                        name: data.billMonth),
                                                    // _tableValueElement(
                                                    //     name: data.billDate),
                                                    _tableValueElement(
                                                        name: data.demand
                                                            .toString()),
                                                    if (!isRebateColumn)
                                                      _tableValueElement(
                                                          name: data.rebate
                                                              .toString()),
                                                    _tableValueElement(
                                                        name: data.collection
                                                            .toString()),
                                                    if (!isAdjustColumn)
                                                      _tableValueElement(
                                                          name: data.adjustments
                                                              .toString()),
                                                  ],
                                                ),
                                              ],
                                            );
                                          }))))
                            ],
                          ),
                  ),
                ],
              );
  }

  // Widget _buildLegend() {
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.horizontal,
  //     child: Row(
  //       // mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         const Text("  Note: ", style: TextStyle(fontWeight: FontWeight.bold)),
  //         _buildLegendItem('1K', '1000'),
  //         const SizedBox(width: 10),
  //         _buildLegendItem('10K', '10000'),
  //         const SizedBox(width: 10),
  //         _buildLegendItem('1M', '100000'),
  //         const SizedBox(width: 10),
  //         _buildLegendItem('10M', '1000000'),
  //         const SizedBox(width: 10),
  //         _buildLegendItem('100M', '10000000'),
  //         const SizedBox(width: 10),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildLegendItem(String label, String description) {
  //   return Row(
  //     children: [
  //       Text(
  //         label,
  //         style: const TextStyle(
  //           color: Colors.black,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       const SizedBox(width: 5),
  //       Text(
  //         '= $description',
  //         style: const TextStyle(
  //           color: Colors.black54,
  //         ),
  //       ),
  //     ],
  //   );
  // }

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

//? Custom Class for Bar Chart
class CustomBarChartModel {
  final String month;
  final double collection;
  final double demand;
  final Color color;

  CustomBarChartModel({
    required this.color,
    required this.month,
    required this.collection,
    required this.demand,
  });
}

extension TakeLast on List<dynamic> {
  List<dynamic> takeLast(int n) => skip(length - n).toList();
}
