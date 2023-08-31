import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/WorkEntryModel.dart';
import '../api/request.dart';
import '../api/url.dart';
import '../utils/colorUtils.dart';
import '../utils/constant.dart';

class LearnerRegistrationFormController extends GetxController {
  TextEditingController registrationDateText = TextEditingController();
  TextEditingController nameText = TextEditingController();
  TextEditingController phoneText = TextEditingController();
  TextEditingController advanceText = TextEditingController();
  TextEditingController amountText = TextEditingController();
  TextEditingController balanceText = TextEditingController();
  TextEditingController selectv = TextEditingController();
  TextEditingController selectd = TextEditingController();
  List<String> selectedVehicle = [];
  DateTime? date;
  var balance = "".obs;
  var id = "".obs;
  var isTwoWheelerWithoutGear = false.obs;
  var isTwoWheelerWithGear = false.obs;
  var isLMV = false.obs;
  var isLoading = false.obs;
  RxSet<String> selectedDays = <String>{}.obs;
  late SharedPreferences _prefs;
  late var area = "".obs;

  void setTwoWheelerWithoutGear(bool value) {
    isTwoWheelerWithoutGear.value = value;
  }

  void setTwoWheelerWithGear(bool value) {
    isTwoWheelerWithGear.value = value;
  }

  void setLMV(bool value) {
    isLMV.value = value;
  }

  List<String> getSelectedItems() {
    if (isTwoWheelerWithoutGear.value) {
      selectedVehicle.add('Two-wheeler without gear');
    }
    if (isTwoWheelerWithGear.value) {
      selectedVehicle.add('Two-wheeler with gear');
    }
    if (isLMV.value) {
      selectedVehicle.add('LMV');
    }
    if (kDebugMode) {
      print(selectedVehicle);
    }
    return selectedVehicle;
  }

  void updateBalance() {
    double amount = double.tryParse(amountText.text) ?? 0.0;
    double advanceAmount = double.tryParse(advanceText.text) ?? 0.0;
    double calculatedBalance = amount - advanceAmount;
    balance.value =
        calculatedBalance.toStringAsFixed(0); // Format to two decimal places
    if (kDebugMode) {
      balanceText.text = balance.value;
      print(balance.value);
    }
    update();
  }

  void toggleDay(String day) {
    if (selectedDays.contains(day)) {
      selectedDays.remove(day);
    } else {
      selectedDays.add(day);
      if (kDebugMode) {
        print(selectedDays);
      }
    }
  }

  Future<void> initializePreferences() async {
    _prefs = await SharedPreferences.getInstance();
    area.value = _prefs.getString(AREA)!;
    var admin = _prefs.getBool(SHARED_ADMIN);
    if (admin == true) {
      if (kDebugMode) {
        print('SHARED_ADMIN value: $admin');
      }
    } else {
      if (kDebugMode) {
        print('area --- ${area.value}');
      }
      addlearnerregistration();
    }
  }

  void addlearnerregistration() {
    getSelectedItems();
    isLoading.value = true;
    update();
    if (registrationDateText.text.isEmpty ||
        nameText.text.isEmpty ||
        phoneText.text.isEmpty ||
        selectedDays.isEmpty) {
      Get.snackbar("Info", "please enter all value",
          colorText: Colors.white,
          backgroundColor: buttonColor,
          snackPosition: SnackPosition.TOP);
    } else {
      if (amountText.text.isEmpty) {
        amountText.text = '0';
      }
      if (advanceText.text.isEmpty) {
        advanceText.text = '0';
      }
      Map<String, dynamic>? requestData;
      // Convert selectedDays from RxSet to a List
      List<String> selectedDaysList = selectedDays.toList();
      int amount = int.parse(amountText.text);
      int advance = int.parse(advanceText.text);
      int balanceamt = int.parse(balanceText.text);
      if (kDebugMode) {
        print('$amount , $advance , $balanceamt');
      }
      requestData = {
        "admissionDate": "${registrationDateText.text.trim()}",
        "cvString": selectedVehicle,
        "scheduleDays": selectedDaysList,
        "name": "${nameText.text}",
        "phoneNumber": "${phoneText.text}",
        "amount": amount,
        "advance": advance,
        "area": '${area.value}'
      };
      if (kDebugMode) {
        print(requestData);
      }
      try {
        RequestDio request =
            RequestDio(url: urllregistration, body: requestData);
        request.post().then((response) async {
          var data = response.data;
          WorkEntryModel model = WorkEntryModel.fromJson(data);
          if (response.statusCode == 200) {
            if (kDebugMode) {
              print('data');
            }
            Fluttertoast.showToast(msg: "added Successfully");
            Get.back();
          } else if (response.statusCode == 201) {
            if (kDebugMode) {
              print('data');
            }
            Fluttertoast.showToast(msg: "added Successfully");
            Get.back();
          } else {
            Get.snackbar("Error", "Incorrect value",
                colorText: Colors.white,
                backgroundColor: Colors.red,
                snackPosition: SnackPosition.TOP);
          }
          isLoading.value = false;
        }).onError((error, stackTrace) {
          isLoading.value = false;
          Get.snackbar("Error", error.toString(),
              colorText: Colors.white,
              backgroundColor: Colors.red,
              snackPosition: SnackPosition.TOP);
        });
      } catch (e) {
        Get.snackbar("Error", e.toString(),
            colorText: Colors.white,
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.TOP);
      }
      update();
    }
  }

  Future<void> updateinitializePreferences() async {
    _prefs = await SharedPreferences.getInstance();
    area.value = _prefs.getString(AREA)!;
    var admin = _prefs.getBool(SHARED_ADMIN);
    if (admin == true) {
      if (kDebugMode) {
        print('SHARED_ADMIN value: $admin');
      }
    } else {
      if (kDebugMode) {
        print('area --- ${area.value}');
      }
      updatelearnerregistration();
    }
  }

  void updatelearnerregistration() {
    isLoading.value = true;
    update();
    if (registrationDateText.text.isEmpty ||
        nameText.text.isEmpty ||
        phoneText.text.isEmpty) {
      Get.snackbar("Info", "please enter all value",
          colorText: Colors.white,
          backgroundColor: buttonColor,
          snackPosition: SnackPosition.TOP);
    } else {
      Map<String, dynamic>? requestData;
      updateBalance();
      // Convert selectedDays from RxSet to a List
      List<String> selectedDaysList = selectedDays.toList();
      int amount = int.parse(amountText.text);
      int advance = int.parse(advanceText.text);
      if (kDebugMode) {
        print('$amount , $advance');
      }
      requestData = {
        "id": "${id.value}",
        "admissionDate": "${registrationDateText.text.trim()}",
        "cvString": selectedVehicle,
        "scheduleDays": selectedDaysList,
        "name": "${nameText.text}",
        "phoneNumber": "${phoneText.text}",
        "amount": amount,
        "advance": advance,
        "area": area.value
      };
      if (kDebugMode) {
        print(requestData);
      }
      try {
        RequestDio request = RequestDio(url: urleditlreg, body: requestData);
        request.post().then((response) async {
          var data = jsonDecode(response.data);
          WorkEntryModel model = WorkEntryModel.fromJson(data);
          if (response.statusCode == 200) {
            if (kDebugMode) {
              print('data');
            }
            Fluttertoast.showToast(msg: "${model.message}");
            Get.back();
          } else if (response.statusCode == 201) {
            if (kDebugMode) {
              print('data');
            }
            Fluttertoast.showToast(msg: "${model.message}");
            Get.offAllNamed(ROUTE_HOME);
          } else {
            Get.snackbar("Error", "Incorrect value",
                colorText: Colors.white,
                backgroundColor: Colors.red,
                snackPosition: SnackPosition.TOP);
          }
          isLoading.value = false;
        });
      } catch (e) {
        Get.snackbar("Error", e.toString(),
            colorText: Colors.white,
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.TOP);
      }
      update();
    }
  }
}
