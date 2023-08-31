import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../Model/LearnerRegistrationModel.dart';
import '../../../controller/Learner_Registration_Form_Controller.dart';
import '../../../utils/colorUtils.dart';
import 'package:get/get.dart';

class LearnerregistrationdetailScreen extends StatelessWidget {
  final LRData data;

  const LearnerregistrationdetailScreen({required this.data});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ');
    if (kDebugMode) {
      print(data.admissionDate!);
    }
    final DateTime parsedDate = dateFormat.parse(data.admissionDate!);
    final dateFormatYearMonthDay = DateFormat('yyyy-MM-dd');
    final formattedDate = dateFormatYearMonthDay.format(parsedDate);
    return GetBuilder<LearnerRegistrationFormController>(
        init: LearnerRegistrationFormController(),
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
                title: const Text('Learner Details'),
              ),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Admission Date',
                        ),
                        controller: controller.registrationDateText
                          ..text = formattedDate,
                        readOnly: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Learner Name',
                        ),
                        controller: controller.nameText
                          ..text = data.name.toString(),
                        readOnly: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Contact number',
                        ),
                        controller: controller.phoneText
                          ..text = data.phoneNumber.toString(),
                        readOnly: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'C/W',
                        ),
                        controller: controller.selectv
                          ..text = data.cvString.toString(),
                        readOnly: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Schedule Date',
                        ),
                        controller: controller.selectd
                          ..text = data.scheduleDays.toString(),
                        readOnly: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Amount',
                        ),
                        controller: controller.amountText
                          ..text = data.amount.toString(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Advance',
                        ),
                        controller: controller.advanceText
                          ..text = data.advance.toString(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Balance',
                        ),
                        controller: controller.balanceText
                          ..text = data.balance.toString(),
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
                                  controller.id.value = data.sId!;
                                  controller.updateinitializePreferences();
                                },
                                child: const SizedBox(
                                  height: 50,
                                  width: 165,
                                  child: Center(
                                    child: Text(
                                      "Update",
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
                                child: Text('Close'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
