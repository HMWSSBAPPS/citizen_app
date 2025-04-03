import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hmwssb/core/api/api.dart';
import 'package:hmwssb/core/api/network.dart';
import 'package:hmwssb/core/api/shared_prefernce.dart';
import 'package:hmwssb/core/theme/app_color.dart';
import 'package:hmwssb/presentation/complaints/complaint_status.dart';
import 'package:hmwssb/presentation/complaints/raise_complaint.dart';
import 'package:hmwssb/presentation/home/dashboard_screen.dart';
import 'package:hmwssb/presentation/home/models/banner_response.dart';
import 'package:hmwssb/presentation/home/ui/services_ui/amr_meter_readings_screen.dart';
import 'package:hmwssb/presentation/home/ui/services_ui/contact_us_screen.dart';
import 'package:hmwssb/presentation/home/ui/services_ui/notices_screens/notices_list_screen.dart';
import 'package:hmwssb/presentation/meter_fixation/meter_fixation.dart';
import 'package:hmwssb/presentation/payment/pay_for_others.dart';
import 'package:hmwssb/presentation/payment/payment_info.dart';
import 'package:hmwssb/presentation/rwh/ui/already_submitted_pit_screen.dart';
import 'package:hmwssb/presentation/side_menu/info_screen.dart';
import 'package:hmwssb/presentation/side_menu/map_selection_appbar.dart';
import 'package:hmwssb/presentation/side_menu/water_bill_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<MItem> bannerImages = [];

  List<Map<String, dynamic>> items = [
    {
      "icon": "assets/svg/tanker.svg",
      "label": "Book \nTanker",
      "action": "bookTanker"
    },
    {
      "icon": "assets/svg/ic_man_hole.svg",
      "label": "Meter \nFixation",
      "action": "meterFixation"
    },
    {
      "icon": "assets/svg/ic_geo_tag.svg",
      "label": "Geo Tag\n Pit",
      "action": "geoTagPit"
    },
    {
      "icon": "assets/svg/ic_greiv.svg",
      "label": "Grievance \nStatus",
      "action": "grievanceStatus"
    },
    // {
    //   "icon": "assets/svg/ic_fws_reg.svg",
    //   "label": "FWS \nRegistration",
    //   "action": "fwsRegistration"
    // },
    {
      "icon": "assets/svg/contact_us.svg",
      "label": "Contact \nUs",
      "action": "contactUs"
    },
    {
      "icon": "assets/svg/tariff.svg",
      "label": "Notices\n",
      "action": "notices"
    },
    if (Platform.isAndroid)
      {
        "icon": "assets/svg/tariff.svg",
        "label": "Self Billing\n",
        "action": "selfBilling"
      },
    if (LocalStorages.getCanno().toString().isNotEmpty &&
        LocalStorages.isAmrCan() == true)
      {
        "icon": "assets/svg/ic_man_hole.svg",
        "label": "Readings\n",
        "action": "meterReadings"
      },
    {"icon": "assets/svg/info.svg", "label": "Info\n", "action": "info"},
  ];

  @override
  void initState() {
    super.initState();
    getBannerImages();
    // _checkFirstLogin();
    // print("currentTargetIndexForTutorial : $currentTargetIndexForTutorial");
    // print(
    //     "local saev is ${(LocalStorages.getCanno().toString().isNotEmpty && LocalStorages.isAmrCan() == true)} and local storage is ${LocalStorages.isAmrCan()}");
  }

  // void _checkFirstLogin() async {
  //   if (LocalStorages.getIsFirstLogin() == true &&
  //       currentTargetIndexForTutorial == 5) {
  //     targets.clear;
  //     menuTargets();
  //     WidgetsBinding.instance.addPostFrameCallback((_) => _showTutorial());
  //     // LocalStorages.saveUserData(
  //     //     localSaveType: LocalSaveType.isFirstLogin, value: false);
  //     // prefs.setBool('isFirstLogin', false);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: lightGrey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            SizedBox(
              key: DashboardScreen.bannerKey,
              height: 110.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: bannerImages.length,
                itemBuilder: (context, index) {
                  return _buildImageBanner(
                    context: context,
                    item: bannerImages[index],
                    index: index,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Card(
                key: DashboardScreen.greivancesKey,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Grievences ',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RaiseComplaint("", ""),
                                  ));
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'View All ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RaiseComplaint(
                                        "Water Supply", "LOW WATER PRESSURE"),
                                  ));
                            },
                            child: _buildIconWithText(
                                'Low\n Water ', "assets/svg/ic_low_water.svg"),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RaiseComplaint(
                                    "Sewerage",
                                    "SEWERAGE OVERFLOWS-ON THE ROAD",
                                    allowImageCapture: false, // Pass false to disable image capture
                                  ),
                                ),
                              );
                            },
                            child: _buildIconWithText(
                              'Sewerage Overflow',
                              "assets/svg/ic_over_flow.svg",
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RaiseComplaint(
                                        "Sewerage",
                                        "DAMAGED/REPAIR/RAISING OF MANHOLE COVER"),
                                  ));
                            },
                            child: _buildIconWithText('Man Hole\nCover',
                                "assets/svg/ic_man_hole.svg"),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RaiseComplaint(
                                        "Water Supply",
                                        "POLLUTED WATER SUPPLY"),
                                  ));
                            },
                            child: _buildIconWithText('Polluted \n Water',
                                "assets/svg/ic_polluted_water.svg"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                key: DashboardScreen.payAreaKey,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Paymentinfo(),
                            ));
                      },
                      child:
                          _buildExpandedContainer('Pay Bill', Icons.bar_chart)),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PayForOthers(),
                            ));
                      },
                      child: _buildExpandedContainer(
                          'Pay for Others', Icons.person_pin_outlined)),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WaterBillScreen(),
                            ));
                      },
                      child: _buildExpandedContainer(
                          'View Bill', Icons.receipt_long_rounded)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                key: DashboardScreen.servicesKey,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Services ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height:
                            (LocalStorages.getCanno().toString().isNotEmpty &&
                                    LocalStorages.isAmrCan() == true)
                                ? 360.h
                                : 260.h,
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          // Disable scroll
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, // Number of columns
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () => handleItemTap(
                                  context, items[index]['action']),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: SvgPicture.asset(
                                      items[index]["icon"],
                                      // color: primaryColor,
                                      // colorBlendMode: BlendMode.srcIn,
                                      colorFilter: const ColorFilter.mode(
                                        primaryColor,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    width: 80,
                                    child: Text(
                                      items[index]["label"],
                                      style: const TextStyle(fontSize: 12),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleItemTap(BuildContext context, String action) {
    switch (action) {
      case 'bookTanker':
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SelectLocationApp(),
            ));
        break;
      case 'meterFixation':
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MeterFixation(),
            ));
        break;
      case 'geoTagPit':
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AlreadySubmittedPitScreen(),
              // GeoTag(),
            ));
        break;
      case 'grievanceStatus':
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ComplainStatus(),
            ));
        break;
      // case 'fwsRegistration':
      //   _launchURL(
      //       "https://bms.hyderabadwater.gov.in/20kl/FreeWaterSupplyRegistration");
      //   break;
      case 'contactUs':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ContactUsScreenWidget()));
        break;
      case 'notices':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NoticesListScreen()));
        break;
      case 'selfBilling':
        _redirectToPlayStore();
        break;

      case 'meterReadings':
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AMRMeterReadingScreen()));
        break;
      case 'info':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const InfoScreen()));
        break;
      default:
        // print('Unknown action');
        break;
    }
  }

  final String selfBillingPackageName = 'in.coral.met';
  final String selfBillingPlayStoreUrl =
      'https://play.google.com/store/apps/details?id=in.coral.met';
  Future<void> _redirectToPlayStore() async {
    if (await canLaunchUrl(Uri.parse(selfBillingPlayStoreUrl))) {
      await launchUrl(Uri.parse(selfBillingPlayStoreUrl));
    } else {
      EasyLoading.showError('Could not launch $selfBillingPlayStoreUrl');
    }
  }

  Widget _buildImageBanner({
    required BuildContext context,
    required MItem item,
    required int index,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {
          if (index == 1) {
            // if (item.url?.isNotEmpty ?? false) {
            // _launchURL(item.url.toString());
            // CustomWebViewScreen(url: item.url.toString()),
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Paymentinfo()));
          }
          if (index == 0) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SelectLocationApp()));
          }
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            item.image.toString(),
            fit: BoxFit.fill,
            width: 300.w,
            errorBuilder: (context, error, stackTrace) =>
                // const SizedBox.shrink(),
                Container(color: Colors.grey[400], width: 300.w),
          ),
        ),
      ),
    );
  }

  Widget _buildIconWithText(String label, String iconData) {
    return Column(
      children: [
        SizedBox(
          width: 45.w,
          height: 45.h,
          child: CircleAvatar(
            backgroundColor: primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                iconData, // Update with your SVG path
                // color: Colors.white,
                // colorBlendMode: BlendMode.srcIn,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 70,
          child: Text(
            label,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildExpandedContainer(String label, IconData iconData) {
    return SizedBox(
      width: 110.w,
      child: Container(
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Icon(iconData, color: Colors.white),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // _launchURL(String url) async {
  //   if (await canLaunchUrl(Uri.parse(url))) {
  //     await launchUrl(Uri.parse(url));
  //   } else {
  //     // ScaffoldMessenger.of(context).showSnackBar(
  //     //   const SnackBar(content: Text('Failed to open')),
  //     // );
  //     EasyLoading.showError('Failed to open');
  //   }
  // }

  Future<void> getBannerImages() async {
    try {
      EasyLoading.show(status: "Loading...");
      var response = await NetworkApiService().commonApiCall(
          url: Api.bannerImages, data: {'appName': 'CitizensApp'});
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        var value = BannerResponse.fromJson(response.data);
        if ((value.mItem1?.responseCode ?? "0") == "200") {
          setState(() {
            bannerImages = value.mItem2!;
          });
        } else {
          EasyLoading.showError(
              value.mItem1?.description ?? "An error Occured");
        }
      }
    } on DioException catch (ex) {
      EasyLoading.dismiss();
      showException(ex);
    }
  }
}
