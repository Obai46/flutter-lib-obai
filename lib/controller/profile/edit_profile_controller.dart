import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../app_route.dart';
import '../../core/class/status_request.dart';
import '../../core/function/handiling_data.dart';
import '../../model/authentication/profile_data.dart';
import '../../model/authentication/user_model.dart';

class EditProfileController extends GetxController {
  final ProfileData _profileData = ProfileData(Get.find());
  Rx<StatusRequest> statusRequest = StatusRequest.none.obs;
  Rx<UserModel> user = Get.put(UserModel().obs);
  late TextEditingController textController;
  XFile? xfile;
  File? myfile;
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  onInit() {
    textController = TextEditingController();
    myInformations();
    super.onInit();
  }

  onCancel(BuildContext context) {
    Navigator.of(context).pop();
    textController.clear();
    update();
  }

  onSave(BuildContext context) {
    Navigator.of(context).pop();
    textController.clear();
    update();
  }

  myInformations() async {
    statusRequest.value = StatusRequest.loading;
    var response = await _profileData.showUserInformations();
    statusRequest.value = handilingData(response);
    if (statusRequest.value == StatusRequest.succes) {
      if (response['status'] == "success") {
        var responsedata = response['data'];

        user.value = UserModel.fromJson(responsedata);
      } else {
        Get.defaultDialog(
            title: "Error", middleText: "Passwoed or Email Not Found");
        statusRequest.value = StatusRequest.failure;
      }
    } else if (statusRequest.value == StatusRequest.unAuthorization) {
      Get.offAllNamed(AppRoutes.authenticationScreen);
      Get.snackbar('UnAuthorization', "انتهت صلاحية الجلسة");
    } else {
      Get.defaultDialog(title: "Server Error", middleText: "");
      statusRequest.value = StatusRequest.failure;
    }
  }

  updateName(BuildContext context) async {
    statusRequest.value = StatusRequest.loading;
    Navigator.of(context).pop();
    var response = await _profileData.updateName(textController.text);
    textController.clear();
    statusRequest.value = handilingData(response);
    if (statusRequest.value == StatusRequest.succes) {
      if (response['status'] == "success") {
        myInformations();
      } else {
        Get.defaultDialog(
            title: "Error", middleText: "Passwoed or Email Not Found");
        statusRequest.value = StatusRequest.none;
      }
    } else if (statusRequest.value == StatusRequest.unAuthorization) {
      Get.offAllNamed(AppRoutes.authenticationScreen);
      Get.snackbar('UnAuthorization', "انتهت صلاحية الجلسة");
    } else {
      Get.defaultDialog(title: "Server Error", middleText: "");
      statusRequest.value = StatusRequest.none;
    }
  }

  updateCity(BuildContext context) async {
    statusRequest.value = StatusRequest.loading;
    Navigator.of(context).pop();
    var response = await _profileData.updateCity(city: textController.text);
    textController.clear();
    statusRequest.value = handilingData(response);
    if (statusRequest.value == StatusRequest.succes) {
      if (response['status'] == "success") {
        myInformations();
      } else {
        Get.defaultDialog(
            title: "Error", middleText: "Passwoed or Email Not Found");
        statusRequest.value = StatusRequest.none;
      }
    } else if (statusRequest.value == StatusRequest.unAuthorization) {
      Get.offAllNamed(AppRoutes.authenticationScreen);
      Get.snackbar('UnAuthorization', "انتهت صلاحية الجلسة");
    } else {
      Get.defaultDialog(title: "Server Error", middleText: "");
      statusRequest.value = StatusRequest.none;
    }
  }

  updatePassword(BuildContext context) async {
    statusRequest.value = StatusRequest.loading;
    Navigator.of(context).pop();
    var response =
        await _profileData.updatepassword(password: textController.text);
    textController.clear();
    statusRequest.value = handilingData(response);
    if (statusRequest.value == StatusRequest.succes) {
      if (response['status'] == "success") {
        myInformations();
      } else {
        Get.defaultDialog(
            title: "Error", middleText: "Passwoed or Email Not Found");
        statusRequest.value = StatusRequest.none;
      }
    } else if (statusRequest.value == StatusRequest.unAuthorization) {
      Get.offAllNamed(AppRoutes.authenticationScreen);
      Get.snackbar('UnAuthorization', "انتهت صلاحية الجلسة");
    } else {
      Get.defaultDialog(title: "Server Error", middleText: "");
      statusRequest.value = StatusRequest.none;
    }
  }

  updateImage() async {
    statusRequest.value = StatusRequest.loading;
    var response = await _profileData.updateImage(usersImage: myfile!);
    textController.clear();
    statusRequest.value = handilingData(response);
    if (statusRequest.value == StatusRequest.succes) {
      if (response['status'] == "success") {
        myInformations();
      } else {
        Get.defaultDialog(
            title: "Error", middleText: "Passwoed or Email Not Found");
        statusRequest.value = StatusRequest.none;
      }
    } else if (statusRequest.value == StatusRequest.unAuthorization) {
      Get.offAllNamed(AppRoutes.authenticationScreen);
      Get.snackbar('UnAuthorization', "انتهت صلاحية الجلسة");
    } else {
      Get.defaultDialog(title: "Server Error", middleText: "");
      statusRequest.value = StatusRequest.none;
    }
  }

  cameraImage() async {
    xfile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (xfile != null) {
      myfile = File(xfile!.path);
      Get.back();
      await updateImage();
    }
  }

  galleryImage() async {
    xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xfile != null) {
      myfile = File(xfile!.path);
      Get.back();
      await updateImage();
    }
  }
}
