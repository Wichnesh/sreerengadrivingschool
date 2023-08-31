import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sree_renga_drivingscl/utils/colorUtils.dart';

import '../../controller/Work_Entry_Report_Controller.dart';
import '../../utils/constant.dart';
import '../../utils/imageUtils.dart';
import 'Form_Detail/WorkEntryDetail.dart';

class WorkEntryReport extends StatefulWidget {
  const WorkEntryReport({Key? key}) : super(key: key);

  @override
  State<WorkEntryReport> createState() => _WorkEntryReportState();
}

class _WorkEntryReportState extends State<WorkEntryReport> {
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
    return GetBuilder<WorkEntryReportController>(
        init: WorkEntryReportController(),
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
                title: const Text('Work Entry Report'),
                centerTitle: true,
                actions: [
                  IconButton(
                      onPressed: () {
                        Get.toNamed(ROUTE_WORKENTRYSEARCH);
                      },
                      icon: const Icon(Icons.person_search)),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Image.asset(
                        logo,
                        height: 60,
                        width: 100,
                      ),
                    ),
                    admin!
                        ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 55,
                              width: double.infinity,
                              child: DropdownButtonFormField(
                                hint: Text(
                                  controller.area.value,
                                ),
                                isExpanded: true,
                                icon: Icon(Icons.arrow_drop_down),
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
                      padding: EdgeInsets.all(10.0),
                      child: Container(
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
                      padding: EdgeInsets.all(10.0),
                      child: Container(
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
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 55,
                              width: 175,
                              color: primarycolor,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
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
                                    controller.WorkEntryList();
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
                            child: SizedBox(
                              height: 55,
                              width: 175,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
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
                                child: const Text('Close'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenHeight * 0.4,
                      child: ListView.builder(
                          itemCount: controller.workentrydatalist.length,
                          itemBuilder: (context, index) {
                            var data = controller.workentrydatalist[index];
                            final dateFormat =
                                DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ');
                            if (kDebugMode) {
                              print(data.date!);
                            }

                            final DateTime parsedDate =
                                dateFormat.parse(data.date!);
                            final dateFormatYearMonthDay =
                                DateFormat('yyyy-MM-dd');
                            final formattedDate =
                                dateFormatYearMonthDay.format(parsedDate);
                            print(formattedDate);

                            // Create a new DateFormat instance for displaying year, month, and date

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Get.to(WorkEntryDetail(data));
                                },
                                child: Card(
                                  elevation: 5,
                                  child: ListTile(
                                    title: Text(data.reference.toString()),
                                    subtitle: Text(formattedDate),
                                    trailing: Text(
                                      "${data.balance.toString()} rs",
                                      style: TextStyle(color: primarycolor),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          title: Text(
                              'Total Credit - ${controller.totalcredit.value} '),
                          subtitle: Text(
                              'Total Debt  - ${controller.totaldebit.value}'),
                          trailing: Text(
                            'Total Amount - ${controller.totalbalance.value}',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        });
  }
}
