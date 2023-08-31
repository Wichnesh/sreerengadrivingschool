import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/Learner_Registration_Report_Controller.dart';
import '../../utils/colorUtils.dart';
import 'Form_Detail/LearnerRegistrationDetail_Screen.dart';

class LearnerRegistrationSearch extends StatefulWidget {
  const LearnerRegistrationSearch({Key? key}) : super(key: key);

  @override
  State<LearnerRegistrationSearch> createState() =>
      _LearnerRegistrationSearchState();
}

class _LearnerRegistrationSearchState extends State<LearnerRegistrationSearch> {
  @override
  Widget build(BuildContext context) {
    final ScreenHeight = MediaQuery.of(context).size.height;
    return GetBuilder<LearnerRegistratioReportController>(
        init: LearnerRegistratioReportController(),
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
                  title: const Text('Learner Registration report'),
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
                            controller: controller.nameText,
                            keyboardType: TextInputType.text,
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
                              labelText: 'Name',
                              labelStyle:
                                  TextStyle(fontSize: 14, color: buttonColor),
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
                                      controller.LearnerregsearchList();
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
                            itemCount: controller.learnerregdatalist.length,
                            itemBuilder: (context, index) {
                              var data = controller.learnerregdatalist[index];
                              final dateFormat =
                                  DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ');
                              print(data.admissionDate!);

                              final DateTime parsedDate =
                                  dateFormat.parse(data.admissionDate!);
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
                                    Get.to(LearnerregistrationdetailScreen(
                                        data: data));
                                  },
                                  child: Card(
                                    elevation: 5,
                                    child: ListTile(
                                      title: Text(data.name.toString()),
                                      subtitle: Text(formattedDate),
                                      trailing: Text(
                                        "${data.balance.toString()} rs",
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
