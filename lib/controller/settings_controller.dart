import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_route.dart';
import '../core/class/crud.dart';
import '../core/class/status_request.dart';
import '../core/function/get_functions.dart';
import '../core/function/handiling_data.dart';
import '../model/authentication/login_data.dart';
import '../services/services.dart';

class SettingsController extends GetxController {
  var isDarkMode = false.obs;
  var selectedIndex = 0.obs;
  Rx<StatusRequest> statusRequest = StatusRequest.none.obs;
  MyServices myServices = Get.find();
  LoginData loginData = LoginData(Get.put(CRUD()));

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = myServices.sharedPreferences.getBool('mode') ?? false;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    myServices.sharedPreferences.setBool('mode', isDarkMode.value);
    update();
  }

  logout() async {
    String? id = getID();
    Get.defaultDialog(
      title: "Are You Sure",
      middleText: "You want to log out ?",
      onCancel: () {
        Get.closeCurrentSnackbar();
      },
      onConfirm: () async {
        statusRequest.value = StatusRequest.loading;
        var response = await loginData.logout();
        statusRequest.value = handilingData(response);
        if (statusRequest.value == StatusRequest.succes) {
          if (response['status'] == "success") {
            FirebaseMessaging.instance.unsubscribeFromTopic(id!);
            myServices.sharedPreferences.clear();
            myServices.sharedPreferences.setString('step', '1');
            Get.offAllNamed(AppRoutes.authenticationScreen);
          } else {
            Get.defaultDialog(
                title: "Error",
                middleText: "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
            statusRequest.value = StatusRequest.failure;
          }
        } else if (statusRequest.value == StatusRequest.unAuthorization) {
          Get.offAllNamed(AppRoutes.authenticationScreen);
          Get.snackbar('UnAuthorization', "انتهت صلاحية الجلسة");
        } else {
          Get.defaultDialog(
              title: "Server Error",
              middleText:
                  "Passwoedsssssssssssssssssssssssss or Email Not Found");
          statusRequest.value = StatusRequest.failure;
        }
      },
    );
  }
}
