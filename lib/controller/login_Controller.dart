import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sree_renga_drivingscl/utils/constant.dart';

import '../Model/loginModel.dart';
import '../api/request.dart';
import '../api/url.dart';

class LoginController extends GetxController {
  TextEditingController userNameText = TextEditingController();
  TextEditingController passwordText = TextEditingController();
  var isLoading = false.obs;
  late SharedPreferences _prefs;

  Future<void> onInit() async {
    await _initializePreferences();
    super.onInit();
  }

  Future<void> _initializePreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void loginApiDio() async {
    if (userNameText.text == 'East81') {
      _prefs.setString(AREA, 'East');
    } else if (userNameText.text == 'West45') {
      _prefs.setString(AREA, 'West');
    } else if (userNameText.text == 'Siurramkk') {
      _prefs.setString(AREA, "");
    }
    isLoading.value = true;
    update();
    Map<String, dynamic> requestData = {
      "userName": "${userNameText.text.trim()}",
      "password": "${passwordText.text.trim()}"
    };
    if (kDebugMode) {
      print(requestData);
    }
    RequestDio request = RequestDio(url: urllogin, body: requestData);
    request.post().then((response) async {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.data);
        loginModel login = loginModel.fromJson(data);
        if (login.status!) {
          if (login.admin!) {
            _prefs.setBool('isLoggedIn', true);
            _prefs.setBool(SHARED_ADMIN, login.admin!);
            _prefs.setString(USERNAME, userNameText.text);
            Get.offAllNamed(ROUTE_HOME);
            Fluttertoast.showToast(msg: "login-successfully");
          } else {
            _prefs.setBool('isLoggedIn', true);
            _prefs.setBool(SHARED_ADMIN, login.admin!);
            _prefs.setString(USERNAME, userNameText.text);
            Get.offAllNamed(ROUTE_HOME);
            Fluttertoast.showToast(msg: "login-successfully");
          }
        } else {
          Get.snackbar("Error", "Incorrect value",
              colorText: Colors.white,
              backgroundColor: Colors.red,
              snackPosition: SnackPosition.TOP);
        }
        isLoading.value = false;
      } else {
        throw Exception();
      }
      isLoading.value = false;
      update();
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError);
      }
      Get.snackbar("Error", onError.toString(),
          colorText: Colors.white,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.TOP);
      isLoading.value = false;
    });
    update();
  }
}
