import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sree_renga_drivingscl/utils/colorUtils.dart';
import 'package:sree_renga_drivingscl/utils/constant.dart';

import '../Model/WorkEntryModel.dart';
import '../api/request.dart';
import '../api/url.dart';

class WorkEntryFormController extends GetxController {
  TextEditingController dateText = TextEditingController();
  TextEditingController regnoText = TextEditingController();
  TextEditingController descriptionText = TextEditingController();
  TextEditingController debitText = TextEditingController();
  TextEditingController creditText = TextEditingController();
  TextEditingController refText = TextEditingController();
  TextEditingController mobileNoText = TextEditingController();
  DateTime? date;
  var id = "".obs;
  var isLoading = false.obs;
  late SharedPreferences _prefs;
  late var area = "".obs;

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
      addWorkEntryApiDio();
    }
  }

  void addWorkEntryApiDio() async {
    isLoading.value = true;
    update();
    if (creditText.text.isEmpty) {
      creditText.text = "0";
    }
    if (debitText.text.isEmpty) {
      debitText.text = "0";
    }
    if (descriptionText.text.isEmpty) {
      descriptionText.text = "-";
    }
    if (refText.text.isEmpty) {
      refText.text = "-";
    }
    if (dateText.text.isEmpty ||
        regnoText.text.isEmpty ||
        mobileNoText.text.isEmpty) {
      Get.snackbar("Info", "please enter all value",
          colorText: Colors.white,
          backgroundColor: buttonColor,
          snackPosition: SnackPosition.TOP);
    } else {
      int debit = int.parse(debitText.text);
      int credit = int.parse(creditText.text);
      Map<String, dynamic>? requestData;
      try {
        requestData = {
          "date": "${dateText.text.trim()}",
          "registerNumber": "${regnoText.text}",
          "description": "${descriptionText.text.trim()}",
          "debit": debit,
          "credit": credit,
          "reference": "${refText.text.trim()}",
          "phoneNumber": "${mobileNoText.text.trim()}",
          "area": "${area.value}"
        };
        if (kDebugMode) {
          print(requestData);
        }
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
      try {
        RequestDio request = RequestDio(url: urladdentry, body: requestData);
        request.post().then((response) async {
          var data = response.data;
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
          Get.snackbar("Error", error.toString(),
              colorText: Colors.white,
              backgroundColor: Colors.red,
              snackPosition: SnackPosition.TOP);
          isLoading.value = false;
          update();
        });
      } catch (e) {
        print(e.toString());
      }
      // isLoading.value = false;
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
      updateWorkEntryApiDio();
    }
  }

  void updateWorkEntryApiDio() async {
    isLoading.value = true;
    update();
    if (creditText.text.isEmpty) {
      creditText.text = "";
    }
    if (debitText.text.isEmpty) {
      debitText.text = "";
    }
    int debit = int.parse(debitText.text);
    int credit = int.parse(creditText.text);
    Map<String, dynamic>? requestData;
    try {
      requestData = {
        "id": "${id.value}",
        "date": "${dateText.text}",
        "registerNumber": "${regnoText.text}",
        "description": "${descriptionText.text}",
        "debit": debit,
        "credit": credit,
        "reference": "${refText.text}",
        "phoneNumber": "${mobileNoText.text}",
        "area": "${area.value}"
      };
      if (kDebugMode) {
        print(requestData);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    try {
      RequestDio request = RequestDio(url: urleditworkentry, body: requestData);
      request.post().then((response) async {
        var data = jsonDecode(response.data);
        WorkEntryModel model = WorkEntryModel.fromJson(data);
        if (response.statusCode == 200) {
          if (kDebugMode) {
            print('data');
          }
          Fluttertoast.showToast(msg: "${model.message}");
          Get.offAllNamed(ROUTE_HOME);
        } else if (response.statusCode == 201) {
          if (kDebugMode) {
            print('data');
          }
          Fluttertoast.showToast(msg: "${model.message}");
          Get.back();
        } else {
          Get.snackbar("Error", "Incorrect value",
              colorText: Colors.white,
              backgroundColor: Colors.red,
              snackPosition: SnackPosition.TOP);
        }
        isLoading.value = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      isLoading.value = false;
    }
    // isLoading.value = false;
    update();
  }
}
