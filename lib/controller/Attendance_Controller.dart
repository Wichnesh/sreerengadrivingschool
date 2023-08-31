import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/AttendanceModel.dart';
import '../api/request.dart';
import '../api/url.dart';
import '../utils/constant.dart';

class AttendanceController extends GetxController {
  var isLoading = false.obs;
  var attendancelist = List<AData>.empty(growable: true).obs;
  var automaticlist = List<AData>.empty(growable: true).obs;
  var name = "Select".obs;
  TextEditingController dateText = TextEditingController();
  DateTime? date;
  RxList<String> randomNames = RxList<String>();
  RxList<bool> checkedNames = RxList<bool>();
  late SharedPreferences _prefs;
  late var area = "".obs;
  var id = "".obs;
  var showpresent = false.obs;
  var present = false.obs;
  List<String> idlist = [];

  void onInit() {
    // TODO: implement onInit
    initializePreferences();
    super.onInit();
  }

  updateAttendancename(val) {
    name.value = val;
    update();
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
      AttendanceList();
    }
  }

  void toggleCheckbox(int index) {
    checkedNames[index] = !checkedNames[index];
  }

  void submitNames() {
    List<AData> selectedNames = [];
    for (int i = 0; i < automaticlist.length; i++) {
      if (checkedNames[i]) {
        selectedNames.add(automaticlist[i]);
        idlist.add(automaticlist[i].sId!);
      }
    }
    if (kDebugMode) {
      for (int i = 0; i < selectedNames.length; i++) {
        print('Selected names: ${selectedNames[i].name}');
      }
    }
  }

  void AttendanceList() {
    isLoading.value = true;
    update();
    Map<String, dynamic>? requestData;
    requestData = {"area": "${area.value}"};
    if (kDebugMode) {
      print(requestData);
    }
    RequestDio request = RequestDio(url: urllreguserdata, body: requestData);
    if (kDebugMode) {
      print(urllreguserdata);
    }
    request.get().then((response) async {
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        AttendanceModel leanerreglistType =
            AttendanceModel.fromJson(response.data);
        leanerreglistType.data!
            .forEach((element) => {attendancelist.add(element)});
        isLoading.value = false;
        update();
      } else if (response.statusCode == 201) {
        if (kDebugMode) {
          print(response.data);
        }
        AttendanceModel workentrylistType =
            AttendanceModel.fromJson(response.data);
        for (var element in workentrylistType.data!) {
          {
            attendancelist.add(element);
          }
        }
        isLoading.value = false;
        update();
      } else {
        Get.snackbar("Error", "Incorrect value",
            colorText: Colors.white,
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.TOP);
      }
      update();
    });
  }

  void sumbit() {
    isLoading.value = true;
    update();
    Map<String, dynamic> requestData = {
      "id": "${id.value}",
      "date": "${dateText.text}"
    };
    if (kDebugMode) {
      print(requestData);
      print(urllregcheck);
    }
    RequestDio request = RequestDio(url: urllregcheck, body: requestData);

    request.post().then((response) async {
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        AttendanceresModel res =
            AttendanceresModel.fromJson(jsonDecode(response.data));
        present.value = res.present!;
        showpresent.value = true;
        isLoading.value = false;
        update();
      } else if (response.statusCode == 201) {
        if (kDebugMode) {
          print(response.data);
        }
        AttendanceresModel res = AttendanceresModel.fromJson(response.data);
        present.value = res.present!;
        showpresent.value = true;
        isLoading.value = false;
        update();
      } else {
        Get.snackbar("Error", "Incorrect value",
            colorText: Colors.white,
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.TOP);
      }
      update();
    });
  }

  void presentupdate() {
    isLoading.value = true;
    update();
    Map<String, dynamic> requestData = {
      "id": "${id.value}",
      "date": "${dateText.text}"
    };
    RequestDio request = RequestDio(url: urllregpresent, body: requestData);
    if (kDebugMode) {
      print(urllregpresent);
    }
    request.put().then((response) async {
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        Fluttertoast.showToast(msg: "Attendance added Successfully");
        isLoading.value = false;
        Get.back();
        update();
      } else if (response.statusCode == 201) {
        if (kDebugMode) {
          print(response.data);
        }
        AttendanceresModel res = AttendanceresModel.fromJson(response.data);
        present.value = res.present!;
        showpresent.value = true;
        isLoading.value = false;
        update();
      } else {
        Get.snackbar("Error", "Incorrect value",
            colorText: Colors.white,
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.TOP);
      }
      update();
    });
  }

  void automaticsumbit() {
    automaticlist.clear();
    isLoading.value = true;
    update();
    Map<String, dynamic> requestData = {
      "date": "${dateText.text}",
      "area": "${area.value}"
    };
    if (kDebugMode) {
      print(requestData);
    }
    RequestDio request = RequestDio(url: urlautomaticlreg, body: requestData);
    if (kDebugMode) {
      print(urlautomaticlreg);
    }
    request.post().then((response) async {
      isLoading.value = false;
      update();

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (kDebugMode) {
          print(response.data);
        }
        AttendanceModel attendanceModel =
            AttendanceModel.fromJson(response.data);

        if (attendanceModel.data != null) {
          attendanceModel.data!.forEach((element) {
            automaticlist.add(element);
            checkedNames.add(false);
          });
          update();
        } else {
          // Handle case where data is null or empty
          Get.snackbar("Info", "No data available",
              colorText: Colors.white,
              backgroundColor: Colors.blue,
              snackPosition: SnackPosition.TOP);
        }
      } else {
        Get.snackbar("Error", "Incorrect value",
            colorText: Colors.white,
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.TOP);
      }
    }).catchError((error) {
      // Handle any error that occurred during the API request
      Get.snackbar("Error", "An error occurred",
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP);
    });
  }

  void automaticpresent() {
    isLoading.value = true;
    update();
    Map<String, dynamic> requestData = {
      "ids": idlist,
      "date": "${dateText.text}"
    };
    if (kDebugMode) {
      print(requestData);
    }
    RequestDio request = RequestDio(url: urlautolregpresent, body: requestData);
    if (kDebugMode) {
      print(urllregpresent);
    }
    request.post().then((response) async {
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        Fluttertoast.showToast(msg: "Attendance added Successfully");
        isLoading.value = false;
        Get.back();
        update();
      } else if (response.statusCode == 201) {
        if (kDebugMode) {
          print(response.data);
        }
        AttendanceresModel res = AttendanceresModel.fromJson(response.data);
        isLoading.value = false;
        update();
      } else {
        Get.snackbar("Error", "Incorrect value",
            colorText: Colors.white,
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.TOP);
      }
      update();
    });
  }
}
