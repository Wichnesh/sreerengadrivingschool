import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/LearnerRegistrationModel.dart';
import '../api/request.dart';
import '../api/url.dart';
import '../utils/constant.dart';

class LearnerRegistratioReportController extends GetxController {
  var isLoading = false.obs;
  TextEditingController fromdateText = TextEditingController();
  TextEditingController todateText = TextEditingController();
  TextEditingController nameText = TextEditingController();
  TextEditingController phoneText = TextEditingController();
  DateTime? fromdate;
  DateTime? todate;
  var learnerregdatalist = List<LRData>.empty(growable: true).obs;
  late SharedPreferences _prefs;
  late var area = "".obs;
  var arealist = ['East', 'West', 'All'].obs;

  void updateSelectedarea(String value) {
    area.value = value;
  }

  void onInit() {
    // TODO: implement onInit
    initializePreferences();
    super.onInit();
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
    }
  }

  void LearnerregList() {
    learnerregdatalist.clear();
    if (area.value == 'All') {
      area.value = '';
    }
    isLoading.value = true;
    update();
    Map<String, dynamic>? requestData;
    requestData = {
      "startDate": "${fromdateText.text}",
      "endDate": "${todateText.text}",
      "area": "${area.value}"
    };
    if (kDebugMode) {
      print('$urllregfilter,$requestData');
    }
    RequestDio request = RequestDio(url: urllregfilter, body: requestData);
    request.post().then((response) async {
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        LearnerregDataModel leanerreglistType =
            LearnerregDataModel.fromJson(response.data);
        leanerreglistType.data!
            .forEach((element) => {learnerregdatalist.add(element)});
        isLoading.value = false;
        update();
      } else if (response.statusCode == 201) {
        if (kDebugMode) {
          print(response.data);
        }
        LearnerregDataModel workentrylistType =
            LearnerregDataModel.fromJson(response.data);
        workentrylistType.data!
            .forEach((element) => {learnerregdatalist.add(element)});
        isLoading.value = false;
        update();
      } else {
        Get.snackbar("Error", "Incorrect value",
            colorText: Colors.white,
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.TOP);
      }
      if (area.value == '') {
        area.value = 'All';
      }
      isLoading.value = false;
      update();
    });
  }

  void LearnerregsearchList() {
    learnerregdatalist.clear();
    isLoading.value = true;
    update();
    Map<String, dynamic>? requestData;
    requestData = {
      "name": "${nameText.text}",
      "phoneNumber": "${phoneText.text}"
    };
    print(requestData);
    RequestDio request = RequestDio(url: urllregsearch, body: requestData);
    request.post().then((response) async {
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        LearnerregDataModel leanerreglistType =
            LearnerregDataModel.fromJson(response.data);
        leanerreglistType.data!
            .forEach((element) => {learnerregdatalist.add(element)});
        isLoading.value = false;
        update();
      } else if (response.statusCode == 201) {
        if (kDebugMode) {
          print(response.data);
        }
        LearnerregDataModel workentrylistType =
            LearnerregDataModel.fromJson(response.data);
        workentrylistType.data!
            .forEach((element) => {learnerregdatalist.add(element)});
        isLoading.value = false;
        update();
      } else {
        Get.snackbar("Error", "Incorrect value",
            colorText: Colors.white,
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.TOP);
      }
      isLoading.value = false;
      update();
    });
  }
}
