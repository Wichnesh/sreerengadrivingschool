import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controller/Attendance_Controller.dart';
import '../../utils/colorUtils.dart';
import '../../utils/imageUtils.dart';

class Attendance extends StatefulWidget {
  const Attendance({Key? key}) : super(key: key);

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  final AttendanceController _controller = AttendanceController();
  final List<Tab> _tabs = <Tab>[
    const Tab(text: 'Manual'),
    const Tab(text: 'Automatic'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Attendance'),
          bottom: TabBar(
            tabs: _tabs,
          ),
        ),
        body: TabBarView(
          children: [
            _buildManualTab(),
            _buildAutomaticTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildManualTab() {
    return GetBuilder<AttendanceController>(
      init: _controller,
      builder: (controller) {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return SingleChildScrollView(
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
                          controller.date = date;
                          controller.update();
                        }
                      },
                      controller: controller.dateText
                        ..text = DateFormat("yyyy-MM-dd").format(
                            controller.date == null
                                ? DateTime.now()
                                : controller.date ?? DateTime.now()),
                      style: const TextStyle(fontSize: 18),
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.calendar_today),
                        labelText: "Date",
                        labelStyle: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 55,
                    width: double.infinity,
                    child: DropdownButtonFormField(
                      hint: Text(
                        controller.name.value,
                      ),
                      isExpanded: true,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 25,
                      decoration: const InputDecoration(
                        labelText: "Name *",
                        labelStyle: TextStyle(fontSize: 14),
                        border: OutlineInputBorder(),
                      ),
                      items: controller.attendancelist.map(
                        (val) {
                          return DropdownMenuItem<String>(
                            value: val.name,
                            child: Text(
                              val.name!,
                            ),
                            onTap: () {
                              controller.id.value = val.sId!;
                              if (kDebugMode) {
                                print(controller.id.value);
                              }
                              controller.update();
                            },
                          );
                        },
                      ).toList(),
                      onChanged: (val) {
                        controller.updateAttendancename(val);
                        controller.showpresent.value = false;
                        if (kDebugMode) {
                          print("val:    ${controller.name.value}");
                        }
                      },
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
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    // Change the button color when pressed
                                    return Colors.green;
                                  }
                                  // Return the default button color
                                  return buttonColor;
                                },
                              ),
                            ),
                            onPressed: () {
                              controller.sumbit();
                            },
                            child: const SizedBox(
                              height: 50,
                              width: 165,
                              child: Center(
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
                                  if (states.contains(MaterialState.pressed)) {
                                    // Change the button color when pressed
                                    return Colors.green;
                                  }
                                  // Return the default button color
                                  return primarycolor; // or any other color you want
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
                const SizedBox(
                  height: 50,
                ),
                controller.showpresent.value
                    ? GetBuilder<AttendanceController>(
                        init: AttendanceController(),
                        builder: (controller) {
                          if (controller.present.value) {
                            return const Text(
                                "Attendance Added for the select day already");
                          } else {
                            return ElevatedButton(
                                onPressed: () {
                                  controller.presentupdate();
                                },
                                child: const Text('present'));
                          }
                        })
                    : Container(),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildAutomaticTab() {
    final Screenheight = MediaQuery.of(context).size.height;
    return GetBuilder<AttendanceController>(
        init: AttendanceController(),
        builder: (controller) {
          return SingleChildScrollView(
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
                          controller.date = date;
                          controller.update();
                        }
                      },
                      controller: controller.dateText
                        ..text = DateFormat("yyyy-MM-dd").format(
                            controller.date == null
                                ? DateTime.now()
                                : controller.date ?? DateTime.now()),
                      style: const TextStyle(fontSize: 18),
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.calendar_today),
                        labelText: "Date",
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
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    // Change the button color when pressed
                                    return Colors.green;
                                  }
                                  // Return the default button color
                                  return buttonColor;
                                },
                              ),
                            ),
                            onPressed: () {
                              controller.automaticsumbit();
                            },
                            child: const SizedBox(
                              height: 50,
                              width: 165,
                              child: Center(
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
                                  if (states.contains(MaterialState.pressed)) {
                                    // Change the button color when pressed
                                    return Colors.green;
                                  }
                                  // Return the default button color
                                  return primarycolor; // or any other color you want
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
                  height: Screenheight * 0.5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: controller.automaticlist.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(controller.automaticlist[index].name!),
                            leading: Checkbox(
                                value: controller.checkedNames[index],
                                onChanged: (value) {
                                  controller.toggleCheckbox(index);
                                  setState(() {});
                                }),
                          );
                        }),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.submitNames();
                    controller.automaticpresent();
                  },
                  child: const Text('Present'),
                ),
              ],
            ),
          );
        });
  }
}
