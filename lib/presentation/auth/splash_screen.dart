import 'dart:developer';
import 'dart:io';
import 'package:hmwssb/core/api/shared_prefernce.dart';
import 'package:hmwssb/core/theme/app_color.dart';
import 'package:hmwssb/presentation/home/dashboard_screen.dart';
import 'package:hmwssb/presentation/non_consumer/home/non_consumer_dashboard.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hmwssb/core/api/api.dart';
import 'package:hmwssb/core/api/network.dart';
import 'package:hmwssb/data/models/can_info_model.dart';
import 'package:hmwssb/presentation/auth/intro_screen.dart';
import 'package:hmwssb/presentation/auth/login_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:safe_device/safe_device.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  // SharedPreferences? pref;

  @override
  void initState() {
    super.initState();
    configLoading();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkDeviceSecurity();
      initPreferences(context: context);
    });
  }

  void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withAlpha(128)
      ..userInteractions = false
      ..dismissOnTap = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 300,
                width: 300,
                child: Image.asset("assets/images/splash_logo.png")),
          ],
        ),
      ),
    );
  }

  validateMobile() async {
    if (LocalStorages.getMobileNumber().toString().isNotEmpty) {
      try {
        // EasyLoading.show(status: "Loading...");
        var response = await NetworkApiService()
            .commonApiCall(url: Api.canInfoByMobileandCan, data: {
          'can': LocalStorages.getCanno() ?? '',
          'mobileNo': LocalStorages.getMobileNumber() ?? '',
        });

        // EasyLoading.dismiss();
        if (response.statusCode == 200) {
          CanInfoModel value = CanInfoModel.fromJson(response.data);
          LocalStorages.saveUserData(
              localSaveType: LocalSaveType.isAmr,
              value: value.mItem2?.iSAMR ?? false);
          LocalStorages.saveUserData(
              localSaveType: LocalSaveType.latLongEdit,
              value: value.mItem2?.isLatLongEditible ?? false);
          if ((value.mItem1?.responseCode ?? "0") != "200") {
            LocalStorages.logOutUser();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                ModalRoute.withName("/login"));
          } else {
            navigateToHome();
            // EasyLoading.showError(
            //     value.mItem1?.description ?? "An error 0ccured");
          }
        }
      } on DioException catch (ex) {
        EasyLoading.dismiss();
        showException(ex);
        navigateToHome();
      }
    } else {
      navigateToHome();
    }
  }

  Future<bool> getAppVersion({required BuildContext context}) async {
    // EasyLoading.show(status: 'Loading...');
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    dynamic appVersionString = packageInfo.version
        .split('.')
        .take(2)
        .join('.'); // Extract the first two parts
    dynamic appVersion = double.tryParse(appVersionString) ?? 0.0;
    // log("packageInfo.version ${packageInfo.version} ${packageInfo.buildNumber} $appVersion");

    try {
      var response = await NetworkApiService()
          .commonApiCall(url: Api.getAppVersionUrl, isGetAppVersion: true);
      // EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (response.data['m_Item1']['ResponseCode'] == "200") {
          if (response.data['m_Item2'] != null &&
              response.data['m_Item2'] != "0|Unable to get latest version") {
            final double version =
                double.tryParse(response.data['m_Item2'] ?? '0') ?? 0;
            // !TODO: LATER CHANGE TO > FROM < BEFORE RELEASE
            log("version $version $appVersion");
            if (version > appVersion) {
              showAlertDialog(context: context);
              return false;
            }
            return true;
          }
        }
      }
      return true;
    } on DioException catch (ex) {
      // EasyLoading.dismiss();
      showException(ex);
      return true;
    }
  }

  void showAlertDialog({required BuildContext context}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Row(
              children: <Widget>[
                Image.asset(
                  "assets/images/splash_logo.png",
                  fit: BoxFit.fill,
                  height: 30,
                  width: 30,
                ),
                const SizedBox(width: 8),
                const Text(
                  'NEW VERSION AVAILABLE',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            content: Text(
                'Dear Consumer, Please update the HMWSSB app from ${Platform.isAndroid ? 'Play Store' : 'App Store'} to latest version for new features and better performance.',
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                )),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  await launchInBrowser(Uri.parse(Platform.isAndroid
                      ? "https://play.google.com/store/apps/details?id=com.hyderabadwater.hmwssb&hl=en"
                      : "https://apps.apple.com/in/app/hmwssb/id1047843388"));
                },
                child: const Text('OK'),
              )
            ],
          );
        });
  }

  void initPreferences({required BuildContext context}) async {
    // pref = await SharedPreferences.getInstance();
    await getAppVersion(context: context).then((value) {
      if (value) {
        validateMobile();
      }
    });

    // navigateToHome();
  }

  navigateToHome() {
    if (LocalStorages.getIsLoggedIn() == true) {
      if (LocalStorages.getIsConsumer() == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NonConsumerDashboard()),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const IntroScreen()),
      );
    }
  }

  Future<void> _checkDeviceSecurity() async {
    bool isRooted = await _isDeviceRooted();

    if (isRooted && mounted) {
      _showRootedDeviceAlert();
    }
  }

  Future<bool> _isDeviceRooted() async {
    bool isJailBroken = await SafeDevice.isJailBroken;
    // bool developerMode = await FlutterJailbreakDetection.developerMode;

    return isJailBroken
        // || developerMode
        ;
  }

  void _showRootedDeviceAlert() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Security Alert'),
          content: const Text(
              'This device is rooted. For security reasons, the application will now close.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
