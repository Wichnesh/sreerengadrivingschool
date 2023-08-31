import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sree_renga_drivingscl/utils/constant.dart';
import '../utils/colorUtils.dart';
import '../utils/imageUtils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences _prefs;
  late bool? admin;
  late String? username;
  @override
  void initState() {
    // TODO: implement initState
    _initializePreferences();
    super.initState();
  }

  Future<void> _initializePreferences() async {
    _prefs = await SharedPreferences.getInstance();
    admin = _prefs.getBool(SHARED_ADMIN); // Retrieve the saved boolean value
    username = _prefs.getString(USERNAME);
    if (admin != null) {
      print('SHARED_ADMIN value: $admin');
    }
    if (username != null) {
      print('SHARED_ADMIN value: $username');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  logo,
                  height: 60,
                  width: 100,
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: primarycolor),
              accountEmail: Container(),
              accountName: username == null
                  ? Container()
                  : const Text(
                      "",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
              currentAccountPicture: Image.asset(splashBg),
              currentAccountPictureSize: const Size(100, 100),
            ),
            admin!
                ? Container()
                : ListTile(
                    leading: const Icon(Icons.work_outline),
                    title: const Text("Work Entry Form"),
                    onTap: () {
                      Get.toNamed(ROUTE_WORKENTRYFORM);
                    },
                  ),
            admin!
                ? Container()
                : ListTile(
                    leading: const Icon(Icons.work_outline),
                    title: const Text("Learner registration Form"),
                    onTap: () {
                      Get.toNamed(ROUTE_LEARNERREGISTRATIONFORM);
                    },
                  ),
            admin!
                ? ListTile(
                    leading: const Icon(Icons.app_registration),
                    title: const Text("Work Entry Report"),
                    onTap: () {
                      Get.toNamed(ROUTE_WORKENTRYREPORT);
                    },
                  )
                : ListTile(
                    leading: const Icon(Icons.app_registration),
                    title: const Text("Work Entry Report"),
                    onTap: () {
                      Get.toNamed(ROUTE_WORKENTRYREPORT);
                    },
                  ),
            admin!
                ? ListTile(
                    leading: const Icon(Icons.app_registration),
                    title: const Text("Learner registration Report"),
                    onTap: () {
                      Get.toNamed(ROUTE_LEARNERREGISTRATIONREPORT);
                    },
                  )
                : ListTile(
                    leading: const Icon(Icons.app_registration),
                    title: const Text("Learner registration Report"),
                    onTap: () {
                      Get.toNamed(ROUTE_LEARNERREGISTRATIONREPORT);
                    },
                  ),
            admin!
                ? Container()
                : ListTile(
                    leading: const Icon(Icons.person_outline_sharp),
                    title: const Text("Attendance"),
                    onTap: () {
                      Get.toNamed(ROUTE_ATTENDANCE);
                    },
                  ),
            admin!
                ? ListTile(
                    leading: const Icon(Icons.person_outline_sharp),
                    title: const Text("Attendance Report"),
                    onTap: () {
                      Get.toNamed(ROUTE_ATTENDANCEREPORT);
                    },
                  )
                : ListTile(
                    leading: const Icon(Icons.person_outline_sharp),
                    title: const Text("Attendance Report"),
                    onTap: () {
                      Get.toNamed(ROUTE_ATTENDANCEREPORT);
                    },
                  ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Log-out"),
              onTap: () {
                _showLogoutConfirmationDialog(context);
              },
            )
          ],
        ),
      ),
    );
  }

  // Function to show the logout confirmation dialog
  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Confirm Log-out",
            style: TextStyle(color: primarycolor),
          ),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () {
                _prefs.setBool('isLoggedIn', false);
                _prefs.setString(USERNAME, "");
                _prefs.setString(AREA, "");
                Get.offAllNamed(ROUTE_LOGIN); // Perform the logout action
              },
              child: const Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("No"),
            ),
          ],
        );
      },
    );
  }
}
