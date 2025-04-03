import 'package:hmwssb/core/api/shared_prefernce.dart';
import 'package:hmwssb/presentation/complaints/nav_complaint_status.dart';
import 'package:hmwssb/presentation/home/dashboard_screen.dart';
import 'package:hmwssb/presentation/non_consumer/home/non_consumer_home.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'package:hmwssb/core/theme/app_color.dart';
import 'package:hmwssb/presentation/auth/login_screen.dart';

void _checkFirstLogin({required BuildContext context}) async {
  // log("message: ${LocalStorages.getIsFirstLogin()}");
  if (LocalStorages.getIsFirstLogin() == true) {
    DashboardScreen.targets.clear;
    _nonConsumerTargets();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => showTutorial(context: context));
    LocalStorages.saveUserData(
        localSaveType: LocalSaveType.isFirstLogin, value: false);
  }
}

void _nonConsumerTargets() {
  DashboardScreen.targets.add(customTargetFocus(
    keyTarget: NonConsumerDashboard.nonHomeTabKey,
    identify: "Home Tab",
    description: "This is Home Screen. Tap to see the home screen.",
  ));
  DashboardScreen.targets.add(customTargetFocus(
    keyTarget: NonConsumerDashboard.nonGreivancesKey,
    identify: "Greivances Status Tab",
    description:
        "This is View Complaint status Screen. Tap to see the status screen.",
  ));
  DashboardScreen.targets.add(customTargetFocus(
    isShapeCircle: false,
    isAlignTop: false,
    keyTarget: NonConsumerDashboard.nonBannerKey,
    identify: "Banner",
    description: "This is Banner section. Tap to see the banner section.",
  ));
  DashboardScreen.targets.add(customTargetFocus(
    isShapeCircle: false,
    isAlignTop: false,
    keyTarget: NonConsumerDashboard.nonPayAreaKey,
    identify: "Pay Area",
    description:
        "This is Pay/View Bill section. Tap to see the pay and view bill section.",
  ));
  DashboardScreen.targets.add(customTargetFocus(
    isShapeCircle: false,
    keyTarget: NonConsumerDashboard.nonServicesKey,
    identify: "Services Tab",
    description: "This is Services section. Tap to see the services section.",
  ));
}

class NonConsumerDashboard extends StatefulWidget {
  const NonConsumerDashboard({super.key});
  static late GlobalKey nonHomeTabKey;
  static late GlobalKey nonBannerKey;
  static late GlobalKey nonGreivancesKey;
  static late GlobalKey nonPayAreaKey;
  static late GlobalKey nonServicesKey;

  @override
  State<NonConsumerDashboard> createState() => _NonConsumerDashboardState();
}

class _NonConsumerDashboardState extends State<NonConsumerDashboard> {
  var _currentIndex = 0;

  final List<Widget> _screens = [
    const NonConsumerHome(),
    const NavComplainStatus(isConsumer: false)
  ];

  @override
  void initState() {
    defineFunc();
    _checkFirstLogin(context: context);
    _fetchAppVersion();
    super.initState();
  }

  void defineFunc() {
    DashboardScreen.targets = [];
    DashboardScreen.currentTargetIndexForTutorial = 0;
    NonConsumerDashboard.nonHomeTabKey = GlobalKey();
    NonConsumerDashboard.nonBannerKey = GlobalKey();
    NonConsumerDashboard.nonGreivancesKey = GlobalKey();
    NonConsumerDashboard.nonPayAreaKey = GlobalKey();
    NonConsumerDashboard.nonServicesKey = GlobalKey();
  }

  String version = '';

  Future<void> _fetchAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(LocalStorages.getMobileNumber() ?? "",
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white)),
                    Text(
                      LocalStorages.getName() ?? "",
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
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
                    // currentAccountPicture: const CircleAvatar(
                    //   backgroundImage: NetworkImage(
                    //     'https://via.placeholder.com/150', // Replace with an appropriate URL or asset
                    //   ),
                    // ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: () {
                      // Handle tap
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
                                    // await pref?.clear(); /**/
                                    if (context.mounted) {
                                      LocalStorages.logOutUser();
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
          /// Home
          SalomonBottomBarItem(
            icon: Icon(
              Icons.home,
              key: NonConsumerDashboard.nonHomeTabKey,
            ),
            title: const Text("Home"),
            selectedColor: primaryColor,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: Icon(
              Icons.pending_actions_outlined,
              key: NonConsumerDashboard.nonGreivancesKey,
            ),
            title: const Text("Grievance Status"),
            selectedColor: primaryColor,
          ),
        ],
      ),
      body: _screens[_currentIndex],
    );
  }

  // void initPreferences() async {
  //   pref = await SharedPreferences.getInstance();
  //   setState(() {});
  // }

  // void _updateData(int newData) {
  //   setState(() {
  //     _currentIndex = newData;
  //   });
  // }
}
