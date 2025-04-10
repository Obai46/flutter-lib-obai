import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../app_route.dart';
import '../../core/class/status_request.dart';
import '../../core/function/get_functions.dart';
import '../../core/function/handiling_data.dart';
import '../../model/post/posts_data.dart';
import '../profile/my_profile_controller.dart';
import '../home_cotroller/home_screen_controller.dart';

class PostController extends GetxController {

  final List<File> imageFilesInSide = [];
  final List<XFile?> selectedImagesInSide = [];
  final List<File> imageFilesOutSide = [];
  final List<XFile?> selectedImagesOutSide = [];

  final ImagePicker picker = ImagePicker();
  Rx<StatusRequest> statusRequest = StatusRequest.none.obs;
  final Rx<StatusRequest> isLoading =
      StatusRequest.none.obs;
  PostsData postsData = PostsData(Get.find());
  var currentIndex = 0.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController carNameController;
  late TextEditingController modelController;
  late TextEditingController engineCapacityController;
  late TextEditingController distanceTraveledController;
  late TextEditingController priceController;
  late TextEditingController numberSeatsController;

  RxString selectedTypeCar = ''.obs;
  RxString selectedBrandCar = ''.obs;
  RxString selectedFuelConsumption = ''.obs;
  RxString selectedDriveSystem = ''.obs;
  RxString selectedCruiseControlSystem = ''.obs;
  List carType = [].obs;
  List carID = [].obs;
  List carImage = [].obs;

  @override
  void onInit() {
    carNameController = TextEditingController();
    modelController = TextEditingController();
    engineCapacityController = TextEditingController();
    distanceTraveledController = TextEditingController();
    priceController = TextEditingController();
    numberSeatsController = TextEditingController();
    getCars();
    super.onInit();
  }

  void clearData() {
    carNameController.clear();
    modelController.clear();
    engineCapacityController.clear();
    distanceTraveledController.clear();
    priceController.clear();
    numberSeatsController.clear();
    selectedTypeCar.value = '';
    selectedBrandCar.value = '';
    selectedFuelConsumption.value = '';
    selectedDriveSystem.value = '';
    selectedCruiseControlSystem.value = '';
    imageFilesInSide.clear();
    selectedImagesInSide.clear();
    imageFilesOutSide.clear();
    selectedImagesOutSide.clear();
    carID.clear();
    carType.clear();
    carImage.clear();
    update();
  }

  addPosts() async {
    var formData = formKey.currentState;
    if (formData!.validate()) {
      statusRequest.value = StatusRequest.loading;
      update();
      String token = getToken();
      String myID = getID();
      var response = await postsData.postAdd(
          postsTitle: 'postsTitle',
          postsUserID: myID,
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
          token: token);
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

  deletePost(int postID, BuildContext context) async {
    Get.defaultDialog(
        title: "هل أنت متأكد ",
        middleText: "أنك تريد حذف هذا المنشور ؟",
        titleStyle: Theme.of(context).textTheme.headlineMedium,
        middleTextStyle: Theme.of(context).textTheme.headlineSmall,
        onCancel: () {
          Get.back();
        },
        onConfirm: () async {
          Get.back();
          statusRequest.value = StatusRequest.loading;
          var response = await postsData.deletePost(postID);
          statusRequest.value = handilingData(response);
          if (statusRequest.value == StatusRequest.succes) {
            if (response['status'] == "success") {
              Get.find<HomeController>().getAllPosts();
              Get.find<MyProfileController>().myProfile();
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
        });
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

  void submitForm() {
    if (formKey.currentState!.validate()) {
      // تنفيذ الإجراء
      Get.snackbar(
        "نجاح",
        "تمت إضافة المنشور بنجاح",
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

  void addImages(List<File> images, List<File> imageFiles) {
    imageFiles.addAll(images);
    update();
  }

  onTap(MapEntry<int, String> entry) {
    currentIndex.value = entry.key;
    update();
  }

  loading() {
    isLoading.value = StatusRequest.loading;
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = StatusRequest.none; // إعادة تعيين الحالة بعد وقت معين
    });
  }

  final ValueNotifier<bool> showMoreDetails = ValueNotifier<bool>(false);
}
