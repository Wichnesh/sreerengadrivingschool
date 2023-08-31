import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/AttendanceModel.dart';
import '../api/request.dart';
import '../api/url.dart';
import '../utils/constant.dart';

class AttendanceReportController extends GetxController {
  var isLoading = false.obs;
  TextEditingController fromdateText = TextEditingController();
  TextEditingController todateText = TextEditingController();
  DateTime? fromdate;
  DateTime? todate;
  TextEditingController mobileNoText = TextEditingController();
  late SharedPreferences _prefs;
  late var area = "Select".obs;
  var arealist = ['East', 'West', 'All'].obs;
  var attendancelist = List<ARData>.empty(growable: true).obs;

  void onInit() {
    // TODO: implement onInit
    initializePreferences();
    super.onInit();
  }

  void updateSelectedarea(String value) {
    area.value = value;
  }

  Future<void> initializePreferences() async {
    _prefs = await SharedPreferences.getInstance();
    area.value = _prefs.getString(AREA)!;
    if (kDebugMode) {
      print(area.value);
    }
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

  void Attendancelistmethod() {
    attendancelist.clear();
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
      print('${urlattendancreport},${requestData}');
    }
    RequestDio request = RequestDio(url: urlattendancreport, body: requestData);
    if (kDebugMode) {
      print(requestData);
    }
    request.post().then((response) async {
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        AttendancereportModel attendancereport =
            AttendancereportModel.fromJson(jsonDecode(response.data));
        attendancereport.data!
            .forEach((element) => {attendancelist.add(element)});
        isLoading.value = false;
        update();
      } else if (response.statusCode == 201) {
        if (kDebugMode) {
          print(response.data);
        }
        AttendancereportModel workentrylistType =
            AttendancereportModel.fromJson(response.data);
        workentrylistType.data!
            .forEach((element) => {attendancelist.add(element)});
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

  void searchAttendancelistmethod() {
    attendancelist.clear();
    isLoading.value = true;
    update();
    Map<String, dynamic>? requestData;
    requestData = {"phoneNumber": "${mobileNoText.text}"};
    if (kDebugMode) {
      print('${urlsearchattendance},${requestData}');
    }
    RequestDio request =
        RequestDio(url: urlsearchattendance, body: requestData);
    if (kDebugMode) {
      print(requestData);
    }
    request.post().then((response) async {
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        AttendancereportModel attendancereport =
            AttendancereportModel.fromJson(jsonDecode(response.data));
        attendancereport.data!
            .forEach((element) => {attendancelist.add(element)});
        isLoading.value = false;
        update();
      } else if (response.statusCode == 201) {
        if (kDebugMode) {
          print(response.data);
        }
        AttendancereportModel workentrylistType =
            AttendancereportModel.fromJson(response.data);
        workentrylistType.data!
            .forEach((element) => {attendancelist.add(element)});
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
