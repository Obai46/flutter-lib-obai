import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../app_route.dart';
import '../../core/class/status_request.dart';
import '../../core/function/get_functions.dart';
import '../../core/function/handiling_data.dart';
import '../../model/post/posts_data.dart';
import '../../model/post/posts_model.dart';

class EditPostController extends GetxController {
  final List<File> imageFilesInSide = [];
  final List<XFile?> selectedImagesInSide = [];
  final List<File> imageFilesOutSide = [];
  final List<XFile?> selectedImagesOutSide = [];
  final ImagePicker picker = ImagePicker();

  Rx<StatusRequest> statusRequest = StatusRequest.none.obs;
  PostsData postsData = PostsData(Get.find());
  late PostModel _postModel = Get.put(PostModel());

  late TextEditingController carNameController;
  late TextEditingController modelController;
  late TextEditingController engineCapacityController;
  late TextEditingController distanceTraveledController;
  late TextEditingController priceController;
  late TextEditingController numberSeatsController;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxString selectedTypeCar = ''.obs;
  RxString selectedBrandCar = ''.obs;
  RxString selectedFuelConsumption = ''.obs;
  RxString selectedDriveSystem = ''.obs;
  RxString selectedCruiseControlSystem = ''.obs;

  List carType = [].obs;
  List carID = [].obs;
  List carImage = [].obs;

  late int postID;

  @override
  void onInit() {
    postID = Get.arguments['id'];
    carNameController = TextEditingController();
    modelController = TextEditingController();
    engineCapacityController = TextEditingController();
    distanceTraveledController = TextEditingController();
    priceController = TextEditingController();
    numberSeatsController = TextEditingController();
    getCars();
    getData();
    super.onInit();
  }

  getData() async {
    statusRequest.value = StatusRequest.loading;
    var response = await postsData.getPost(postID.toString());
    statusRequest.value = handilingData(response);

    if (statusRequest.value == StatusRequest.succes) {
      if (response['status'] == "success") {
        var responseData = response['data'][0];
        _postModel = PostModel.fromJson(responseData);
        selectedBrandCar.value =
            response['data'][0]['descriptions']['cars']['id'].toString();
        carNameController.text = _postModel.descriptions!.name ?? '';
        modelController.text = _postModel.descriptions!.model ?? '';
        engineCapacityController.text =
            _postModel.descriptions!.engCapacity ?? '';
        distanceTraveledController.text =
            _postModel.descriptions!.disTravel ?? '';
        priceController.text = _postModel.descriptions!.price.toString();
        numberSeatsController.text =
            _postModel.descriptions!.numberSeats.toString();

        selectedTypeCar.value = _postModel.descriptions!.typeCar ?? '';
        selectedFuelConsumption.value =
            _postModel.descriptions!.fuelConsumption ?? '';
        selectedDriveSystem.value = _postModel.descriptions!.driveSystem ?? '';
        selectedCruiseControlSystem.value =
            _postModel.descriptions!.cruiseControlSystem == true ? '1' : '0';
        update();
        selectedImagesInSide.clear();
        for (var img in _postModel.imageIn!) {
          selectedImagesInSide.add(XFile(img));
          update();
        }
        selectedImagesOutSide.clear();
        for (var img in _postModel.imageOut!) {
          selectedImagesOutSide.add(XFile(img));
          update();
        }

        update();
      } else {
        Get.defaultDialog(title: "Error", middleText: "Data Not Found");
        statusRequest.value = StatusRequest.failure;
        update();
      }
    }
  }

  getCars() async {
    carID.clear();
    carImage.clear();
    carType.clear();
    var response = await postsData.getCars();
    statusRequest.value = handilingData(response);
    if (statusRequest.value == StatusRequest.succes) {
      if (response['status'] == "success") {
        carID.addAll(
            response['data'].map((car) => car['id'].toString()).toList());
        carType.addAll(response['data'].map((car) => car['type']).toList());
        carImage.addAll(response['data'].map((car) => car['image']).toList());
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
      statusRequest.value = StatusRequest.none;
    }
  }

  updatePost() async {
    var formData = formKey.currentState;
    if (formData!.validate()) {
      statusRequest.value = StatusRequest.loading;
      update();
      String token = getToken();
      var response = await postsData.updatePost(
        postsTitle: 'postsTitle',
        postsID: postID.toString(),
        name: carNameController.text,
        model: modelController.text,
        engCapacity: engineCapacityController.text,
        disTravel: distanceTraveledController.text,
        price: priceController.text,
        typeCar: selectedTypeCar.value,
        fuelConsumption: selectedFuelConsumption.value,
        driveSystem: selectedDriveSystem.value,
        numberSeats: numberSeatsController.text,
        cruiseControlSystem: selectedCruiseControlSystem.value,
        carsID: selectedBrandCar.value,
        imageInFiles: imageFilesInSide,
        imageOutFiles: imageFilesOutSide,
        token: token,
      );
      statusRequest.value = handilingData(response);
      if (statusRequest.value == StatusRequest.succes) {
        if (response['status'] == "success") {
          submitForm();
          Get.offAllNamed(AppRoutes.home);
          update();
        } else {
          Get.defaultDialog(
              title: "Error", middleText: "Passwoed or Email Not Found");
          statusRequest.value = StatusRequest.failure;
          update();
        }
      } else if (statusRequest.value == StatusRequest.unAuthorization) {
        Get.offAllNamed(AppRoutes.authenticationScreen);
        Get.snackbar('UnAuthorization', "انتهت صلاحية الجلسة");
        update();
      } else {
        Get.defaultDialog(title: "Server Error", middleText: "");
        statusRequest.value = StatusRequest.none;
        update();
      }
    }
  }

  void submitForm() {
    if (formKey.currentState!.validate()) {
      // تنفيذ الإجراء
      Get.snackbar(
        "نجاح",
        "تم تعديل المنشور بنجاح",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        "خطأ",
        "يرجى ملء جميع الحقول بشكل صحيح",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> pickFromCamera(
      List<XFile?> selectedImages, List<File> imageFiles) async {
    try {
      Get.back();
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        selectedImages.add(image);
        imageFiles.add(File(image.path));
        update();
      }
    } catch (e) {
      e.printError();
      return;
    }
    update();
  }

  Future<void> pickFromGallery(
      List<XFile?> selectedImages, List<File> imageFiles) async {
    try {
      Get.back();
      final List<XFile> images = await picker.pickMultiImage();
      if (images.isNotEmpty) {
        selectedImages.addAll(images);
        imageFiles.addAll(images.map((xfile) => File(xfile.path)));
        update();
      }
    } catch (e) {
      e.printError();
      return;
    }
    update();
  }
}
