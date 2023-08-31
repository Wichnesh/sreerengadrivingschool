import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../../controller/Attendance_Report_Controller.dart';
import '../../utils/colorUtils.dart';
import '../../utils/constant.dart';
import '../../utils/imageUtils.dart';
import 'Form_Detail/AttendanceDetail.dart';

class AttendanceReport extends StatefulWidget {
  const AttendanceReport({Key? key}) : super(key: key);

  @override
  State<AttendanceReport> createState() => _AttendanceReportState();
}

class _AttendanceReportState extends State<AttendanceReport> {
  late SharedPreferences _prefs;
  late bool? admin;
  late var area = "";

  void initState() {
    _initializePreferences();
    super.initState();
  }

  Future<void> _initializePreferences() async {
    _prefs = await SharedPreferences.getInstance();
    admin = _prefs.getBool(SHARED_ADMIN); // Retrieve the saved boolean value
    if (admin != null) {
      if (kDebugMode) {
        print('SHARED_ADMIN value: $admin');
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final ScreenHeight = MediaQuery.of(context).size.height;
    return GetBuilder<AttendanceReportController>(
        init: AttendanceReportController(),
        builder: (controller) {
          if (controller.isLoading.value) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Scaffold(
                appBar: AppBar(
                  title: const Text('Attendance Report'),
                  centerTitle: true,
                  actions: [
                    IconButton(
                        onPressed: () {
                          controller.attendancelist.clear();
                          Get.toNamed(ROUTE_ATTENDANCEREPORTSEARCH);
                        },
                        icon: const Icon(Icons.person_search)),
                  ],
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          logo,
                          height: 60,
                          width: 100,
                        ),
                      ),
                      admin!
                          ? Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SizedBox(
                                height: 55,
                                width: double.infinity,
                                child: DropdownButtonFormField(
                                  hint: Text(
                                    controller.area.value,
                                  ),
                                  isExpanded: true,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 25,
                                  decoration: const InputDecoration(
                                    labelText: "Area",
                                    labelStyle: TextStyle(fontSize: 14),
                                    border: OutlineInputBorder(),
                                  ),
                                  items: controller.arealist.map(
                                    (val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(
                                          val,
                                        ),
                                        onTap: () {},
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    controller.updateSelectedarea(val!);
                                    if (kDebugMode) {
                                      print("val:    ${controller.area.value}");
                                    }
                                  },
                                ),
                              ),
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          height: 55,
                          width: double.infinity,
                          child: TextField(
                            readOnly: true,
                            onTap: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              DateTime? date = DateTime.now();
                              date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now());
                              if (date != null) {
                                controller.fromdate = date;
                                controller.update();
                              }
                            },
                            controller: controller.fromdateText
                              ..text = DateFormat("yyyy-MM-dd").format(
                                  controller.fromdate == null
                                      ? DateTime.now()
                                      : controller.fromdate ?? DateTime.now()),
                            style: const TextStyle(fontSize: 18),
                            decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.calendar_today),
                              labelText: "From Date",
                              labelStyle: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          height: 55,
                          width: double.infinity,
                          child: TextField(
                            readOnly: true,
                            onTap: () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              DateTime? date = DateTime.now();

                              date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now());

                              if (date != null) {
                                controller.todate = date;
                                controller.update();
                              }
                            },
                            controller: controller.todateText
                              ..text = DateFormat("yyyy-MM-dd").format(
                                  controller.todate == null
                                      ? DateTime.now()
                                      : controller.todate ?? DateTime.now()),
                            style: const TextStyle(fontSize: 18),
                            decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.calendar_today),
                              labelText: "To Date",
                              labelStyle: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 55,
                                width: 175,
                                color: primarycolor,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.pressed)) {
                                          // Change the button color when pressed
                                          return Colors.green;
                                        }
                                        // Return the default button color
                                        return primarycolor;
                                      },
                                    ),
                                  ),
                                  onPressed: () {
                                    if (controller.todateText.text.isEmpty ||
                                        controller.fromdateText.text.isEmpty) {
                                      Get.dialog(
                                        AlertDialog(
                                          title: const Text('Alert'),
                                          content: const Text(
                                              'Please enter From date & To date'),
                                          actions: [
                                            TextButton(
                                              child: const Text('OK'),
                                              onPressed: () {
                                                Get.back();
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      controller.Attendancelistmethod();
                                      setState(() {});
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 165,
                                    child: const Center(
                                      child: Text(
                                        "Submit",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Container(
                                height: 55,
                                width: 175,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.pressed)) {
                                          // Change the button color when pressed
                                          return Colors.green;
                                        }
                                        // Return the default button color
                                        return Colors
                                            .red; // or any other color you want
                                      },
                                    ),
                                  ),
                                  onPressed: () {
                                    // Handle the button click event
                                    Get.back();
                                  },
                                  child: Text('Close'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: ScreenHeight * 0.6,
                        child: ListView.builder(
                            itemCount: controller.attendancelist.length,
                            itemBuilder: (context, index) {
                              var data = controller.attendancelist[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    Get.to(AttendanceDetail(data));
                                  },
                                  child: Card(
                                    elevation: 5,
                                    child: ListTile(
                                      title: Text(data.name.toString()),
                                      subtitle: Text(
                                          'present - ${data.attendance!.length} Days'),
                                      trailing: Text(
                                        "${data.name.toString()}",
                                        style: const TextStyle(
                                            color: primarycolor),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ));
          }
        });
  }
}
