import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/Attendance_Report_Controller.dart';
import '../../utils/colorUtils.dart';

class AttendanceReportSearch extends StatefulWidget {
  const AttendanceReportSearch({Key? key}) : super(key: key);

  @override
  State<AttendanceReportSearch> createState() => _AttendanceReportSearchState();
}

class _AttendanceReportSearchState extends State<AttendanceReportSearch> {
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
                  title: const Text('Attendance report'),
                  centerTitle: true,
                  actions: [],
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: TextField(
                            controller: controller.mobileNoText,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(fontSize: 18),
                            decoration: const InputDecoration(
                              suffixStyle:
                                  TextStyle(fontSize: 18, color: buttonColor),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        buttonColor), // Set the desired border color
                              ),
                              labelText: 'Phone number',
                              labelStyle:
                                  TextStyle(fontSize: 14, color: buttonColor),
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
                                      controller.searchAttendancelistmethod();
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
                                    // Get.to(LearnerregistrationdetailScreen(
                                    //     data: data));
                                  },
                                  child: Card(
                                    elevation: 5,
                                    child: ListTile(
                                      title: Text(data.name.toString()),
                                      subtitle: Text(
                                          'present - ${data.attendance!.length} Days'),
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
