import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hmwssb/core/api/shared_prefernce.dart';
import 'package:hmwssb/core/theme/app_color.dart';
import 'package:hmwssb/presentation/home/home_screen.dart';
import 'package:hmwssb/presentation/home/ui/last_payment_pdf_screens/last_payment_pdf_screen.dart';
import 'package:hmwssb/presentation/side_menu/consumer_info.dart';
import 'package:hmwssb/presentation/side_menu/map_selection.dart';
import 'package:hmwssb/presentation/side_menu/switch_can.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hmwssb/presentation/tanker_booking/screens/tankers_history_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:hmwssb/presentation/auth/login_screen.dart';
import 'package:hmwssb/presentation/side_menu/payment_history_screen.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

void _consumerCheckFirstLogin({required BuildContext context}) async {
  // log("message: ${LocalStorages.getIsFirstLogin()}");
  if (LocalStorages.getIsFirstLogin() == true) {
    DashboardScreen.targets.clear;
    _consumerTargets();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        showTutorial(context: context);
      }
    });
    LocalStorages.saveUserData(
        localSaveType: LocalSaveType.isFirstLogin, value: false);
  }
}

void _consumerTargets() {
  DashboardScreen.targets.add(customTargetFocus(
    keyTarget: DashboardScreen.homeTabKey,
    identify: "Home Tab",
    description: "This is Home Screen. Tap to see next.",
  ));
  DashboardScreen.targets.add(customTargetFocus(
    keyTarget: DashboardScreen.tankerTabKey,
    identify: "Tanker Tab",
    description: "This is Tanker Booking and Track Screen. Tap to see next.",
  ));
  DashboardScreen.targets.add(customTargetFocus(
    keyTarget: DashboardScreen.historyTabKey,
    identify: "History Tab",
    description: "This is Bill History Screen. Tap to see next.",
  ));
  DashboardScreen.targets.add(customTargetFocus(
    keyTarget: DashboardScreen.profileTabKey,
    identify: "Last Payment Tab",
    description: "This is Last Payment Screen. Tap to see the next.",
  ));
  // DashboardScreen.targets.add(customTargetFocus(
  //   isShapeCircle: false,
  //   isAlignTop: false,
  //   keyTarget: menuTabKey,
  //   identify: "Menu Tab",
  //   description:
  //       "This is for to view profile, Switch CAN and Logout. Tap to see the menu screen.",
  // ));
  _homeTargets();
}

void _homeTargets() {
  DashboardScreen.targets.add(customTargetFocus(
    isShapeCircle: false,
    isAlignTop: false,
    keyTarget: DashboardScreen.bannerKey,
    identify: "Banner",
    description: "This is Banner section. Tap to see next.",
  ));
  DashboardScreen.targets.add(customTargetFocus(
    isShapeCircle: false,
    isAlignTop: false,
    keyTarget: DashboardScreen.greivancesKey,
    identify: "Grievances",
    description: "This is Greivances section. Tap to see next.",
  ));
  DashboardScreen.targets.add(customTargetFocus(
    isShapeCircle: false,
    isAlignTop: false,
    keyTarget: DashboardScreen.payAreaKey,
    identify: "Pay Area",
    description: "This is Pay/View Bill section. Tap to see next.",
  ));
  DashboardScreen.targets.add(customTargetFocus(
    isShapeCircle: false,
    keyTarget: DashboardScreen.servicesKey,
    identify: "Services Tab",
    description: "This is Services section. Tap to see next.",
  ));
}

void _next() {
  DashboardScreen.currentTargetIndexForTutorial++;
  if (DashboardScreen.currentTargetIndexForTutorial <
      DashboardScreen.targets.length) {
    DashboardScreen.tutorialCoachMark.next();
  } else {
    DashboardScreen.tutorialCoachMark.finish();
  }
}

void showTutorial({required BuildContext context}) {
  Future.delayed(const Duration(milliseconds: 500), () {
    DashboardScreen.tutorialCoachMark = TutorialCoachMark(
      // skipWidget:
      hideSkip: true,
      targets: DashboardScreen.targets,
      colorShadow: Colors.black,
      // textSkip: "SKIP",
      paddingFocus: 10,
      alignSkip: Alignment.bottomRight,
      onFinish: () {
        // log("Tutorial finished");
      },
      onClickTarget: (target) {
        // log('target ${target.keyTarget} clicked $target');
      },
      onSkip: () {
        // log("Tutorial skipped");
        return true;
      },
    );

    DashboardScreen.tutorialCoachMark.show(context: context);
  });
}

TargetFocus customTargetFocus(
    {required GlobalKey keyTarget,
    required String identify,
    required String description,
    bool isAlignTop = true,
    bool isShapeCircle = true}) {
  return TargetFocus(
    identify: identify,
    keyTarget: keyTarget,
    shape: isShapeCircle ? ShapeLightFocus.Circle : ShapeLightFocus.RRect,
    contents: [
      TargetContent(
        align: ContentAlign.custom,
        customPosition: isAlignTop
            ? CustomTargetContentPosition(
                right: 0,
                left: 0,
                top: 5,
              )
            : CustomTargetContentPosition(
                bottom: 35,
                right: 0,
                left: 0,
              ),
        child: Column(
          children: [
            Text(
              description,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _next();
                  },
                  child: const Text("NEXT"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    DashboardScreen.tutorialCoachMark.finish();
                  },
                  child: const Text("SKIP"),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  static late TutorialCoachMark tutorialCoachMark;
  static late int currentTargetIndexForTutorial;
  static late List<TargetFocus> targets;
  static late GlobalKey homeTabKey;
  static late GlobalKey tankerTabKey;
  static late GlobalKey historyTabKey;
  static late GlobalKey profileTabKey;
  static late GlobalKey bannerKey;
  static late GlobalKey greivancesKey;
  static late GlobalKey payAreaKey;
  static late GlobalKey servicesKey;
  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  var _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    defineFunc();
    configLoading();
    _consumerCheckFirstLogin(context: context);
    _fetchAppVersion();
  }

  void defineFunc() {
    DashboardScreen.targets = [];
    DashboardScreen.currentTargetIndexForTutorial = 0;
    DashboardScreen.homeTabKey = GlobalKey();
    DashboardScreen.tankerTabKey = GlobalKey();
    DashboardScreen.historyTabKey = GlobalKey();
    DashboardScreen.profileTabKey = GlobalKey();
    DashboardScreen.bannerKey = GlobalKey();
    DashboardScreen.greivancesKey = GlobalKey();
    DashboardScreen.payAreaKey = GlobalKey();
    DashboardScreen.servicesKey = GlobalKey();
  }

  String version = '';

  Future<void> _fetchAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });
  }

  @override
  void dispose() {
    super.dispose();
    DashboardScreen.homeTabKey.currentState?.dispose();
    DashboardScreen.tankerTabKey.currentState?.dispose();
    DashboardScreen.historyTabKey.currentState?.dispose();
    DashboardScreen.profileTabKey.currentState?.dispose();
    DashboardScreen.bannerKey.currentState?.dispose();
    DashboardScreen.greivancesKey.currentState?.dispose();
    DashboardScreen.payAreaKey.currentState?.dispose();
    DashboardScreen.servicesKey.currentState?.dispose();
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
      ..maskColor = Colors.blue.withAlpha(127)
      ..userInteractions = false
      ..dismissOnTap = false;
  }

  List<Widget> screens = const <Widget>[
    HomeScreen(),
    SelectLocation(),
    PaymentHistoryScreen(),
    // const ProfileInfo(),
    LastPaymentPdfScreen(),
  ];

  // Future<void> openAppOrRedirect() async {
  //   // Attempt to open the app directly with the intent URL
  //   final String appUrl =
  //       'intent://$packageName#Intent;package=$packageName;end';

  //   try {
  //     // Attempt to open the app using its package name
  //     if (await canLaunchUrl(Uri.parse(appUrl))) {
  //       await launchUrl(Uri.parse(appUrl));
  //     } else {
  //       // Fallback to Play Store if the app is not installed
  //       await _redirectToPlayStore();
  //     }
  //   } catch (e) {
  //     EasyLoading.showError("Failed to open app: ${e.toString()}");
  //   }
  // }

  // Future<void> _redirectToPlayStore() async {
  //   if (await canLaunchUrl(Uri.parse(playStoreUrl))) {
  //     await launchUrl(Uri.parse(playStoreUrl));
  //   } else {
  //     EasyLoading.showError('Could not launch $playStoreUrl');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // print("LocalStorages.getName() ${LocalStorages.getName()}");
    // print("LocalStorages.getRwhFlag() ${LocalStorages.getRwhFlag()}");
    // print("LocalStorages.getLatLongEdit() ${LocalStorages.getLatLongEdit()}");
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocalStorages.getCanno() ?? "",
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
            Text(
              LocalStorages.getName() ?? "",
              style: const TextStyle(fontSize: 14, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis, // Ensures text doesn't overflow
            ),
          ],
        ),
        actions: [
          if (_currentIndex == 1)
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => const TankersHistoryScreen()),
                );
              },
              icon: Icon(
                Icons.history_toggle_off_sharp,
                color: Colors.white,
                size: 22.sp,
              ),
            ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(LocalStorages.getName() ?? ""),
                    accountEmail: Text(LocalStorages.getMobileNumber() ?? ""),
                  ),
                  ListTile(
                    // key: menuProfileKey,
                    leading: const Icon(Icons.phone),
                    title: const Text('My Profile'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ConsumerInfo(),
                          ));
                    },
                  ),
                  // ListTile(
                  //   // key: menuProfileKey,
                  //   leading: const Icon(Icons.picture_as_pdf_outlined),
                  //   title: const Text('Last Payment'),
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) =>
                  //                 const LastPaymentPdfScreen()));
                  //   },
                  // ),
                  ListTile(
                      // key: menuSwitchKey,
                      leading: const Icon(Icons.swap_horiz_sharp),
                      title: const Text('Switch CAN'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SwitchCan()));
                      }),
                  // if (Platform.isAndroid)
                  //   ListTile(
                  //     // key: menuProfileKey,
                  //     leading: const Icon(Icons.gas_meter_rounded),
                  //     title: const Text('Self Billing'),
                  //     onTap: () async {
                  //       await _redirectToPlayStore();
                  //     },
                  //   ),
                  ListTile(
                    // key: menuLogoutKey,
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                  'Do you want to logout from application?'),
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
                                      await LocalStorages.logOutUser();
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginScreen()),
                                          ModalRoute.withName("/login"));
                                    }
                                  },
                                  child: const Text('Yes'),
                                ),
                              ],
                            );
                          });
                    },
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Version: $version",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
        unselectedItemColor: primaryColor,
        selectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          SalomonBottomBarItem(
            icon: Icon(Icons.home, key: DashboardScreen.homeTabKey),
            title: const Text("Home"),
            selectedColor: primaryColor,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.fire_truck, key: DashboardScreen.tankerTabKey),
            title: const Text("Tanker"),
            selectedColor: primaryColor,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.receipt_long_rounded,
                key: DashboardScreen.historyTabKey),
            title: const Text("History"),
            selectedColor: primaryColor,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.picture_as_pdf_outlined,
                key: DashboardScreen.profileTabKey),
            title: const Text("Last Payment"),
            selectedColor: primaryColor,
          ),
          // SalomonBottomBarItem(
          //   icon: Icon(Icons.person, key: DashboardScreen.profileTabKey),
          //   title: const Text("Profile"),
          //   selectedColor: primaryColor,
          // ),
        ],
      ),
      body: screens[_currentIndex],
    );
  }
}

// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({super.key});
//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }
// class _DashboardScreenState extends State<DashboardScreen> {
//   var _currentIndex = 0;
//   @override
//   void initState() {
//     super.initState();
//     configLoading();
//   }
//   void configLoading() {
//     EasyLoading.instance
//       ..displayDuration = const Duration(milliseconds: 2000)
//       ..indicatorType = EasyLoadingIndicatorType.fadingCircle
//       ..loadingStyle = EasyLoadingStyle.dark
//       ..indicatorSize = 45.0
//       ..radius = 10.0
//       ..progressColor = Colors.yellow
//       ..backgroundColor = Colors.green
//       ..indicatorColor = Colors.yellow
//       ..textColor = Colors.yellow
//       ..maskColor = Colors.blue.withOpacity(0.5)
//       ..userInteractions = false
//       ..dismissOnTap = false;
//   }
//   @override
//   Widget build(BuildContext context) {
//     List<Widget> screens = [
//       const HomeScreen(),
//       const SelectLocation(),
//       const PaymentHistoryScreen(),
//       const ProfileInfo(),
//     ];
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(
//           color: Colors.white,
//         ),
//         backgroundColor: primaryColor,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(LocalStorages.getCanno() ?? "",
//                         style:
//                             const TextStyle(fontSize: 16, color: Colors.white)),
//                     Text(
//                       LocalStorages.getName() ?? "",
//                       style: const TextStyle(fontSize: 14, color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       drawer: Drawer(
//         backgroundColor: Colors.white,
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             UserAccountsDrawerHeader(
//               accountName: Text(LocalStorages.getName() ?? ""),
//               accountEmail: Text(LocalStorages.getMobileNumber() ?? ""),
//               // currentAccountPicture: const CircleAvatar(
//               //   backgroundImage: NetworkImage(
//               //     'https://via.placeholder.com/150',
//               //   ),
//               // ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.phone),
//               title: const Text('My Profile'),
//               onTap: () {
//                 // Handle tap
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const ConsumerInfo(),
//                     ));
//               },
//             ),
//             ListTile(
//                 leading: const Icon(Icons.swap_horiz_sharp),
//                 title: const Text('Switch CAN'),
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const SwitchCan()));
//                 }),
//             ListTile(
//               leading: const Icon(Icons.logout),
//               title: const Text('Logout'),
//               onTap: () {
//                 showDialog(
//                     context: context,
//                     builder: (context) {
//                       return AlertDialog(
//                         title: const Text(
//                             'Do you want to logout from application?'),
//                         content: const Text(''),
//                         actions: <Widget>[
//                           OutlinedButton(
//                             onPressed: () {
//                               Navigator.of(context).pop(false);
//                             },
//                             child: const Text('No'),
//                           ),
//                           OutlinedButton(
//                             onPressed: () async {
//                               if (context.mounted) {
//                                 LocalStorages.logOutUser();
//                                 Navigator.pushAndRemoveUntil(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             const LoginScreen()),
//                                     ModalRoute.withName("/login"));
//                               }
//                             },
//                             child: const Text('Yes'),
//                           ),
//                         ],
//                       );
//                     });
//               },
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: SalomonBottomBar(
//         unselectedItemColor: primaryColor,
//         selectedItemColor: Colors.white,
//         currentIndex: _currentIndex,
//         onTap: (i) => setState(() => _currentIndex = i),
//         items: [
//           /// Home
//           SalomonBottomBarItem(
//             icon: const Icon(Icons.home),
//             title: const Text("Home"),
//             selectedColor: primaryColor,
//           ),
//           /// Likes
//           SalomonBottomBarItem(
//             icon: const Icon(Icons.fire_truck),
//             title: const Text("Tanker"),
//             selectedColor: primaryColor,
//           ),
//           /// Search
//           SalomonBottomBarItem(
//             icon: const Icon(Icons.receipt_long_rounded),
//             title: const Text("History"),
//             selectedColor: primaryColor,
//           ),
//           /// Profile
//           SalomonBottomBarItem(
//             icon: const Icon(Icons.person),
//             title: const Text("Profile"),
//             selectedColor: primaryColor,
//           ),
//         ],
//       ),
//       body: screens[_currentIndex],
//     );
//   }
// }
