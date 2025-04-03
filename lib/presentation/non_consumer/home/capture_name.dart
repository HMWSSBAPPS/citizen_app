import 'package:flutter/services.dart';
import 'package:hmwssb/core/api/shared_prefernce.dart';
import 'package:hmwssb/presentation/non_consumer/home/non_consumer_dashboard.dart';
import 'package:hmwssb/presentation/side_menu/link_can_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hmwssb/core/theme/app_color.dart';

class CaptureName extends StatefulWidget {
  const CaptureName({super.key});

  @override
  State<CaptureName> createState() => _CaptureNameState();
}

class _CaptureNameState extends State<CaptureName> {
  var fullNameController = TextEditingController();
  var addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: primaryColor,
          title: const Text(
            'Fill Information',
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
        body: SingleChildScrollView(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLines: 1,
              controller: fullNameController,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                counterText: '',
                border: OutlineInputBorder(),
                labelText: 'Enter Full Name  *',
                hintText: 'Enter Full Name  *',
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(
                    RegExp(r"^([a-zA-Z\s]+)*[a-zA-Z\s]+")),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLines: 3,
              controller: addressController,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                counterText: '',
                border: OutlineInputBorder(),
                labelText: 'Enter Address *',
                hintText: 'Enter Address  *',
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9,./\s]+')),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              if (fullNameController.text.isEmpty) {
                EasyLoading.showInfo("Enter Name");
              } else if (addressController.text.isEmpty) {
                EasyLoading.showInfo('Enter Address');
              } else {
                LocalStorages.saveUserData(
                    localSaveType: LocalSaveType.isConsumer, value: false);
                LocalStorages.saveUserData(
                    localSaveType: LocalSaveType.isLoggedIn, value: true);
                LocalStorages.saveUserData(
                    localSaveType: LocalSaveType.isFirstLogin, value: true);
                LocalStorages.saveUserData(
                    localSaveType: LocalSaveType.address,
                    value: addressController.text.trim());
                LocalStorages.saveUserData(
                    localSaveType: LocalSaveType.name,
                    value: fullNameController.text.trim());

                // Navigator.pushReplacement(
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NonConsumerDashboard()),
                  (route) => false,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: primaryColor,
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 80.0),
              child: Text("Continue as Guest",
                  style: TextStyle(color: Colors.white)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            '--------- Or --------',
            style: TextStyle(fontSize: 18, color: primaryColor),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LinkCanScreen(),
                    ),
                  ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: primaryColor,
              ),
              child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80.0),
                  child:
                      Text("Link Can", style: TextStyle(color: Colors.white))))
        ])));
  }
}
