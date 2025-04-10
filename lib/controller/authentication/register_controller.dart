import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../app_route.dart';
import '../../core/class/status_request.dart';
import '../../core/function/handiling_data.dart';
import '../../model/authentication/register_data.dart';

class RegisterController extends GetxController {
  StatusRequest statusRequest = StatusRequest.none;
  RegisterData registerData = RegisterData(Get.find());
  XFile? xfile;
  File? myfile;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController city;
  RxBool isShowPassword = true.obs;

  @override
  void onInit() {
    super.onInit();
    name = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    city = TextEditingController();
  }

  register() async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await registerData.register(
        usersName: name.text,
        email: email.text,
        password: password.text,
        usersCity: city.text,
        usersImage: myfile!,
      );
      statusRequest = handilingData(response);
      if (statusRequest == StatusRequest.succes) {
        if (response['status'] == "success") {
          Get.offAllNamed(AppRoutes.login);
        } else {
          Get.defaultDialog(
              title: "Error", middleText: "Passwoed or Email Not Found");
          statusRequest = StatusRequest.none;
        }
      } else {
        Get.defaultDialog(title: "Server Error", middleText: '');
        statusRequest = StatusRequest.none;
      }
      update();
    }
  }

  cameraImage() async {
    xfile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (xfile != null) {
      myfile = File(xfile!.path);
      Get.back();
    }
  }

  galleryImage() async {
    xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xfile != null) {
      myfile = File(xfile!.path);
      Get.back();
    }
  }

  showPassword() {
    isShowPassword.value = !isShowPassword.value;
  }
}
