import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_route.dart';
import '../../core/class/status_request.dart';
import '../../core/function/handiling_data.dart';
import '../../model/authentication/User_model.dart';
import '../../model/authentication/login_data.dart';
import '../../services/services.dart';

class LoginController extends GetxController {
  late TextEditingController email;
  late TextEditingController password;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  RxBool isShowPassword = true.obs;
  Rx<StatusRequest> statusRequest = StatusRequest.none.obs;
  LoginData loginData = LoginData(Get.find());
  MyServices myServices = Get.find();
  UserModel userModel = Get.put(UserModel());

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  logIn() async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      statusRequest.value = StatusRequest.loading;
      var response = await loginData.login(
        email: email.text,
        password: password.text,
      );
      statusRequest.value = handilingData(response);
      // print(statusRequest.value);
      if (statusRequest.value == StatusRequest.succes) {
        if (response['status'] == "success") {
          var responsedata = response['data'];
          userModel = UserModel.fromJson(responsedata);
          await FirebaseMessaging.instance
              .subscribeToTopic(userModel.id.toString());
          myServices.sharedPreferences.setString('step', '2');
          myServices.sharedPreferences.setString('id', userModel.id.toString());
          Get.offAllNamed(AppRoutes.home);
        } else {
          Get.defaultDialog(
              title: "Error", middleText: "Passwoed or Email Not Found");
          statusRequest.value = StatusRequest.none;
        }
      } else {
        Get.defaultDialog(title: "Server Error", middleText: "");
        statusRequest.value = StatusRequest.none;
      }
    }
  }

  showPassword() {
    isShowPassword.value = !isShowPassword.value;
  }
}
