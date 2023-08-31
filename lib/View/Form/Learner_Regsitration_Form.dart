import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/Learner_Registration_Form_Controller.dart';
import '../../utils/colorUtils.dart';
import '../../utils/constant.dart';
import '../../utils/imageUtils.dart';

class Learner_Registration_Form extends StatefulWidget {
  const Learner_Registration_Form({Key? key}) : super(key: key);

  @override
  State<Learner_Registration_Form> createState() =>
      _Learner_Registration_FormState();
}

class _Learner_Registration_FormState extends State<Learner_Registration_Form> {
  LearnerRegistrationFormController controller =
      Get.put(LearnerRegistrationFormController());
  final List<String> daysOfWeek = [
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun"
  ];
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

  Color getDayColor(String day) {
    return controller.selectedDays.contains(day) ? Colors.blue : Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learner Registration Form'),
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
              padding: const EdgeInsets.all(10.0),
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
                  controller: controller.registrationDateText
                    ..text = DateFormat("yyyy-MM-dd").format(
                        controller.date == null
                            ? DateTime.now()
                            : controller.date ?? DateTime.now()),
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.calendar_today),
                    labelText: "Registration Date",
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
                  controller: controller.nameText,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(
                    suffixStyle: TextStyle(fontSize: 18, color: buttonColor),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: buttonColor), // Set the desired border color
                    ),
                    labelText: 'Name',
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
                  controller: controller.phoneText,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(
                    suffixStyle: TextStyle(fontSize: 18, color: buttonColor),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: buttonColor), // Set the desired border color
                    ),
                    labelText: 'Phone number',
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
                  controller: controller.amountText,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(
                    suffixStyle: TextStyle(fontSize: 18, color: buttonColor),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: buttonColor), // Set the desired border color
                    ),
                    labelText: 'Amount',
                    labelStyle: TextStyle(fontSize: 14, color: buttonColor),
                  ),
                  onChanged: (value) {
                    controller.updateBalance();
                    setState(() {});
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: TextField(
                  controller: controller.advanceText,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(
                    suffixStyle: TextStyle(fontSize: 18, color: buttonColor),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: buttonColor), // Set the desired border color
                    ),
                    labelText: 'Advance Amount',
                    labelStyle: TextStyle(fontSize: 14, color: buttonColor),
                  ),
                  onChanged: (value) {
                    controller.updateBalance();
                    setState(() {});
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'C/W',
                  style: TextStyle(fontSize: 24),
                ),
                CheckboxListTile(
                  title: const Text('Two-wheeler without gear'),
                  value: controller.isTwoWheelerWithoutGear.value,
                  onChanged: (value) {
                    controller.setTwoWheelerWithoutGear(value!);
                    setState(() {});
                  },
                ),
                CheckboxListTile(
                  title: const Text('Two-wheeler with gear'),
                  value: controller.isTwoWheelerWithGear.value,
                  onChanged: (value) {
                    controller.setTwoWheelerWithGear(value!);
                    setState(() {});
                  },
                ),
                CheckboxListTile(
                  title: const Text('LMV'),
                  value: controller.isLMV.value,
                  onChanged: (value) {
                    controller.setLMV(value!);
                    setState(() {});
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                const Text(
                  'Driving Schedule',
                  style: TextStyle(fontSize: 24),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: daysOfWeek.map((day) {
                      return GestureDetector(
                        onTap: () {
                          controller.toggleDay(day);
                          setState(() {});
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: getDayColor(day),
                          ),
                          child: Center(
                            child: Text(
                              day,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: TextField(
                  readOnly: true,
                  enabled: false,
                  controller: TextEditingController(text: area),
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(
                    suffixStyle: TextStyle(fontSize: 18, color: buttonColor),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: buttonColor), // Set the desired border color
                    ),
                    labelText: 'Area',
                    labelStyle: TextStyle(fontSize: 14, color: buttonColor),
                  ),
                ),
              ),
            ),
            GetBuilder<LearnerRegistrationFormController>(
                builder: (controller) {
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
