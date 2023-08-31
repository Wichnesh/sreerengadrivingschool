import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/WorkEntryModel.dart';
import '../api/request.dart';
import '../api/url.dart';
import '../utils/constant.dart';

class WorkEntryReportController extends GetxController {
  var isLoading = false.obs;
  TextEditingController fromdateText = TextEditingController();
  TextEditingController todateText = TextEditingController();
  DateTime? fromdate;
  DateTime? todate;
  TextEditingController regnoText = TextEditingController();
  TextEditingController mobileNoText = TextEditingController();
  late SharedPreferences _prefs;
  late var area = "Select".obs;
  var totalcredit = "".obs;
  var totaldebit = "".obs;
  var totalbalance = "".obs;
  var workentrydatalist = List<Data>.empty(growable: true).obs;
  var arealist = ['East', 'West', 'All'].obs;

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

  void WorkEntryList() {
    workentrydatalist.clear();
    isLoading.value = true;
    if (area.value == 'All') {
      area.value = '';
    }
    update();
    Map<String, dynamic>? requestData;
    requestData = {
      "startDate": "${fromdateText.text}",
      "endDate": "${todateText.text}",
      "area": "${area.value}"
    };
    print('${urlworkentryfilter},${requestData}');
    RequestDio request = RequestDio(url: urlworkentryfilter, body: requestData);
    if (kDebugMode) {
      print(requestData);
    }
    request.post().then((response) async {
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        WorkEntryDataModel workentrylistType =
            WorkEntryDataModel.fromJson(response.data);
        workentrylistType.data!
            .forEach((element) => {workentrydatalist.add(element)});
        totalcredit.value = workentrylistType.totalCredited.toString();
        totaldebit.value = workentrylistType.totalBalance.toString();
        totalbalance.value = workentrylistType.totalBalance.toString();
        isLoading.value = false;
        update();
      } else if (response.statusCode == 201) {
        if (kDebugMode) {
          print(response.data);
        }
        WorkEntryDataModel workentrylistType =
            WorkEntryDataModel.fromJson(response.data);
        workentrylistType.data!
            .forEach((element) => {workentrydatalist.add(element)});
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

  void WorkEntrySearchList() {
    workentrydatalist.clear();
    isLoading.value = true;
    update();
    Map<String, dynamic>? requestData;
    requestData = {
      "registerNumber": "${regnoText.text}",
      "phoneNumber": "${mobileNoText.text}"
    };
    RequestDio request = RequestDio(url: urlworkentrysearch, body: requestData);
    request.post().then((response) async {
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.data);
        }
        WorkEntryDataModel workentrylistType =
            WorkEntryDataModel.fromJson(response.data);
        for (var element in workentrylistType.data!) {
          {
            workentrydatalist.add(element);
          }
        }
        isLoading.value = false;
        update();
      } else if (response.statusCode == 201) {
        if (kDebugMode) {
          print(response.data);
        }
        WorkEntryDataModel workentrylistType =
            WorkEntryDataModel.fromJson(response.data);
        workentrylistType.data!
            .forEach((element) => {workentrydatalist.add(element)});
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
