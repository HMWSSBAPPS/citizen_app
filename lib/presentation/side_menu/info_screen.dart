import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hmwssb/core/api/shared_prefernce.dart';
import 'package:hmwssb/presentation/home/dashboard_screen.dart';
import 'package:hmwssb/presentation/non_consumer/home/non_consumer_dashboard.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hmwssb/core/theme/app_color.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: primaryColor,
        title: const Text(
          'Information',
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
      body: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _launchURL(
                        "https://hyderabadwater.gov.in/en/application/themes/hmwssb/images/Tariff_Content.pdf");
                  },
                  child:
                      _buildIconNoWithText('Tariff\n', "assets/svg/tariff.svg"),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _launchURL(
                        "https://hyderabadwater.gov.in/en/application/themes/hmwssb/images/Revised-Tariff-For-Commercial-Industrial.pdf");
                  },
                  child: _buildIconNoWithText(
                      'Industrial\nTariff', "assets/svg/tariff.svg"),
                ),
              ),
              Expanded(
                /**/
                child: GestureDetector(
                  onTap: () {
                    _launchURL(
                        "https://www.hyderabadwater.gov.in/en/index.php/services/information-services/guidelines-new-connections");
                  },
                  child: _buildIconNoWithText(
                      'New Conn \nInfo', "assets/svg/ic_new_water.svg"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _launchURL(
                        "https://local.hyderabadwater.gov.in/FWS-UI-Aadhaar/ReportsHome/Settings/UserManualforAadhaarlinking.pdf");
                  },
                  child: _buildIconNoWithText(
                      'FWS \n Guide Lines', "assets/svg/ic_fws_reg.svg"),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _launchURL(
                        "https://bms.hyderabadwater.gov.in/20kl/EmpanelledAgencies");
                  },
                  child: _buildIconNoWithText(
                      'Meters\n Info', "assets/svg/ic_man_hole.svg"),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    await LocalStorages.saveUserData(
                        localSaveType: LocalSaveType.isFirstLogin, value: true);

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              LocalStorages.getIsConsumer() == true
                                  ? const DashboardScreen()
                                  : const NonConsumerDashboard()),
                      (route) => false,
                    );
                  },
                  child: _buildIconNoWithText(
                      'Replay\nTutorial', "assets/svg/info.svg"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconNoWithText(String label, String iconData) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: SvgPicture.asset(
            iconData, // Update with your SVG path
            width: 200.0,
            height: 200.0,
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
          width: 80, // Set a width constraint for wrapping
          child: Text(
            label,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      EasyLoading.showToast('Failed to open',
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }
}
