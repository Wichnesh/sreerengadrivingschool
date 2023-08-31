import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/Work_Entry_Form_Controller.dart';
import '../../utils/colorUtils.dart';
import '../../utils/constant.dart';
import '../../utils/imageUtils.dart';

class WorkEntryForm extends StatefulWidget {
  const WorkEntryForm({Key? key}) : super(key: key);

  @override
  State<WorkEntryForm> createState() => _WorkEntryFormState();
}

class _WorkEntryFormState extends State<WorkEntryForm> {
  WorkEntryFormController controller = Get.put(WorkEntryFormController());

  late SharedPreferences _prefs;
  late var area = "";

  void initState() {
    _initializePreferences();
    super.initState();
  }

  Future<void> _initializePreferences() async {
    _prefs = await SharedPreferences.getInstance();
    area = _prefs.getString(AREA)!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Work Entry Form'),
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
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: TextField(
                  controller: controller.regnoText,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(
                    suffixStyle: TextStyle(fontSize: 18, color: buttonColor),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: buttonColor), // Set the desired border color
                    ),
                    labelText: 'Regn no',
                    labelStyle: TextStyle(fontSize: 14, color: buttonColor),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: controller.descriptionText,
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: buttonColor), // Set the desired border color
                    ),
                    labelText: 'Description',
                    labelStyle: TextStyle(fontSize: 14, color: buttonColor),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: TextField(
                  controller: controller.debitText,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(
                    suffixStyle: TextStyle(fontSize: 18, color: buttonColor),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: buttonColor), // Set the desired border color
                    ),
                    labelText: 'Debit',
                    labelStyle: TextStyle(fontSize: 14, color: buttonColor),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: TextField(
                  controller: controller.creditText,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(
                    suffixStyle: TextStyle(fontSize: 18, color: buttonColor),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: buttonColor), // Set the desired border color
                    ),
                    labelText: 'Credit',
                    labelStyle: TextStyle(fontSize: 14, color: buttonColor),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: TextField(
                  controller: controller.refText,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(
                    suffixStyle: TextStyle(fontSize: 18, color: buttonColor),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: buttonColor), // Set the desired border color
                    ),
                    labelText: 'Ref',
                    labelStyle: TextStyle(fontSize: 14, color: buttonColor),
                  ),
                ),
              ),
            ),
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
                    suffixStyle: TextStyle(fontSize: 18, color: primarycolor),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: buttonColor), // Set the desired border color
                    ),
                    labelText: 'Mobile No',
                    labelStyle: TextStyle(fontSize: 14, color: buttonColor),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: TextField(
                  enabled: false,
                  controller: TextEditingController(text: area),
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(
                    suffixStyle: TextStyle(fontSize: 18, color: primarycolor),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: buttonColor),
                    ),
                    labelText: 'Area',
                    labelStyle: TextStyle(fontSize: 14, color: buttonColor),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GetBuilder<WorkEntryFormController>(builder: (controller) {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Padding(
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
                              controller.initializePreferences();
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
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
