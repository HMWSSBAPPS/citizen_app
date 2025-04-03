import 'package:hmwssb/presentation/non_consumer/home/non_consumer_dashboard.dart';
import 'package:hmwssb/presentation/non_consumer/services/drainage_cover_screen.dart';
import 'package:hmwssb/presentation/non_consumer/services/sewerage_overflow.dart';
import 'package:hmwssb/presentation/non_consumer/services/water_leakage.dart';
import 'package:hmwssb/presentation/payment/pay_for_others.dart';
import 'package:hmwssb/presentation/side_menu/info_screen.dart';
import 'package:hmwssb/presentation/side_menu/link_can_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hmwssb/core/api/api.dart';
import 'package:hmwssb/core/api/network.dart';
import 'package:hmwssb/core/theme/app_color.dart';
import 'package:hmwssb/presentation/home/models/banner_response.dart';

class NonConsumerHome extends StatefulWidget {
  const NonConsumerHome({super.key});

  @override
  State<NonConsumerHome> createState() => _NonConsumerHomeState();
}

class _NonConsumerHomeState extends State<NonConsumerHome> {
  List<MItem> bannerImages = [];

  @override
  void initState() {
    super.initState();
    getBannerImages();
  }

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
              height: 150,
              key: NonConsumerDashboard.nonBannerKey,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: bannerImages.length,
                itemBuilder: (context, index) {
                  return _buildImageBanner(bannerImages[index]);
                },
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                key: NonConsumerDashboard.nonPayAreaKey,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PayForOthers(),
                            ));
                      },
                      child: _buildExpandedContainer(
                          context, 'Pay Bill', Icons.bar_chart)),
                  // GestureDetector(
                  //     onTap: () {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (context) => const PayForOthers(),
                  //           ));
                  //     },
                  //     child: _buildExpandedContainer(
                  //         'Pay for Others', Icons.person_pin_outlined)),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LinkCanScreen(),
                            ));
                      },
                      child: _buildExpandedContainer(
                          context, 'Link Can', Icons.link)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                key: NonConsumerDashboard.nonServicesKey,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
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
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const DrainageCoverScreen(),
                                  ));
                            },
                            child: _buildIconNoWithText('Drainage Cover Miss',
                                "assets/svg/ic_miss_cover.svg"),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SewerageOverflow(),
                                  ));
                            },
                            child: _buildIconNoWithText('Sewerage Overflow',
                                "assets/svg/ic_over_flow.svg"),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const WaterLeakage(),
                                  ));
                            },
                            child: _buildIconNoWithText('Water pipe Leakage',
                                "assets/svg/ic_water_leak.svg"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _launchURL(
                                  "https://www.hyderabadwater.gov.in/en/index.php/services/prospective-consumer-services/apply-water-and-sewarage-connection");
                            },
                            child: _buildIconNoWithText('New Water Connection',
                                "assets/svg/ic_new_water.svg"),
                          ),
                          GestureDetector(
                            onTap: () {
                              _launchURL(
                                  "https://www.hyderabadwater.gov.in/en/index.php/contact-us");
                            },
                            child: _buildIconNoWithText(
                                'Contact \nus', "assets/svg/contact_us.svg"),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const InfoScreen(),
                                  ));
                            },
                            child: _buildIconNoWithText(
                                'Info \n', "assets/svg/info.svg"),
                          ),
                        ],
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

  Widget _buildImageBanner(MItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {
          if (item.url?.isNotEmpty ?? false) {
            _launchURL(item.url.toString());
          }
        },
        child: Container(
          width: 300, // Adjust the width as needed
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item.image.toString(),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildIconWithText(String label, String iconData) {
  //   return Column(
  //     children: [
  //       SizedBox(
  //         height: 70,
  //         width: 70,
  //         child: CircleAvatar(
  //           backgroundColor: primaryColor,
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Image.asset(iconData),
  //           ),
  //         ),
  //       ),
  //       const SizedBox(height: 8),
  //       SizedBox(
  //         width: 80, // Set a width constraint for wrapping
  //         child: Text(
  //           label,
  //           textAlign: TextAlign.center,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildIconNoWithText(String label, String iconData) {
    return Column(
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: SvgPicture.asset(
            iconData,
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
            label,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildExpandedContainer(
      BuildContext context, String label, IconData iconData) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.2,
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
          const SizedBox(height: 8)
        ],
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Failed to open')),
      EasyLoading.showError('Failed to open');
    }
  }

  getBannerImages() async {
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
              value.mItem1?.description ?? "An error 0ccured");
        }
      }
    } on DioException catch (ex) {
      EasyLoading.dismiss();
      showException(ex);
    }
  }
}
