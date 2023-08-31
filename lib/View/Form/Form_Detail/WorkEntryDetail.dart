import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../Model/WorkEntryModel.dart';
import '../../../controller/Work_Entry_Form_Controller.dart';
import '../../../utils/colorUtils.dart';

class WorkEntryDetail extends StatelessWidget {
  final Data data;
  const WorkEntryDetail(this.data);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ');
    if (kDebugMode) {
      print(data.date!);
    }
    final DateTime parsedDate = dateFormat.parse(data.date!);
    final dateFormatYearMonthDay = DateFormat('yyyy-MM-dd');
    final formattedDate = dateFormatYearMonthDay.format(parsedDate);
    if (kDebugMode) {
      print(formattedDate);
    }
    return GetBuilder<WorkEntryFormController>(
        init: WorkEntryFormController(),
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
                title: const Text('Work Entry Details'),
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
                          labelText: 'Date',
                        ),
                        controller: controller.dateText..text = formattedDate,
                        readOnly: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Registration Number',
                        ),
                        controller: controller.regnoText
                          ..text = data.registerNumber.toString(),
                        readOnly: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Description',
                        ),
                        controller: controller.descriptionText
                          ..text = data.description.toString(),
                        readOnly: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Reference',
                        ),
                        controller: controller.refText
                          ..text = data.reference.toString(),
                        readOnly: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Contact number',
                        ),
                        controller: controller.mobileNoText
                          ..text = data.phoneNumber.toString(),
                        readOnly: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Credit',
                        ),
                        controller: controller.creditText
                          ..text = data.credit.toString(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Debit',
                        ),
                        controller: controller.debitText
                          ..text = data.debit!.toString(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Balance',
                        ),
                        controller: TextEditingController(
                            text: data.balance.toString()),
                        readOnly: true,
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
                            child: Container(
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
