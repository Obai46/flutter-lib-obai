import 'package:carousel_slider_plus/carousel_options.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_route.dart';
import '../../chat_test/chat/chats_users/message_data.dart';
import '../../chat_test/chat/chats_users/message_model.dart';
import '../../core/class/status_request.dart';
import '../../core/function/get_functions.dart';
import '../../core/function/handiling_data.dart';
import '../../model/authentication/login_data.dart';
import '../../model/post/posts_data.dart';
import '../../model/post/posts_model.dart';
import '../../services/services.dart';

class HomeController extends GetxController {
  PostModel postModel = Get.put(PostModel());
  final PostsData _postsData = PostsData(Get.find());
  Rx<StatusRequest> statusRequest = StatusRequest.none.obs;
  LoginData loginData = LoginData(Get.find());
  MyServices myServices = Get.find();

  late TextEditingController messageController;

  MessageData messageData = MessageData(Get.find());
  MessageModel messageModel = Get.put(MessageModel());

  late RxList listOfPost = [].obs;
  late List imagesOut = [];
  late List imagesIn = [];
  RxList<int> favoritesList = <int>[].obs;

  RxList<int> selectedCars = RxList<int>();
  bool get hasFilters => selectedCars.isNotEmpty;

  var currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    messageController = TextEditingController();
    getAllPosts();
  }

  getAllPosts({List<int>? filteredCars}) async {
    imagesOut.clear();
    imagesIn.clear();
    listOfPost.clear();
    statusRequest.value = StatusRequest.loading;
    String token = getToken();
    var response = await _postsData.getallpostdescription(token: token);
    statusRequest.value = handilingData(response);
    if (statusRequest.value == StatusRequest.succes) {
      if (response['status'] == "success") {
        var responsedata = response['data'];
        var posts = (responsedata as List)
            .map((json) => PostModel.fromJson(json))
            .toList();
        if (hasFilters) {
          posts = posts.where((post) {
            return selectedCars.contains(post.descriptions!.carsId);
          }).toList();
        }
        listOfPost.value = posts;
        imagesOut = listOfPost.map((post) => post.imageOut).toList();
        imagesIn = listOfPost.map((post) => post.imageIn).toList();
        favoritesList.clear();
        for (var post in listOfPost) {
          if (post.isSaved == 1) {
            favoritesList.add(post.id!);
          }
        }
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

  void toggleFavorite(int postId) async {
    if (favoritesList.contains(postId)) {
      var response = await _postsData.deleteFromFavourite(postId.toString());
      statusRequest.value = handilingData(response);
      if (statusRequest.value == StatusRequest.succes) {
        if (response['status'] == "success") {
          favoritesList.remove(postId);
          Get.rawSnackbar(
            duration: const Duration(milliseconds: 1200),
            messageText: const Text(
              'تم ازالة العنصر من المحفوظات ',
              style: TextStyle(color: Colors.white),
            ),
          );
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
    } else {
      var response = await _postsData.addToFavourite(postId.toString());
      statusRequest.value = handilingData(response);
      if (statusRequest.value == StatusRequest.succes) {
        if (response['status'] == "success") {
          favoritesList.add(postId);
          Get.rawSnackbar(
            duration: const Duration(milliseconds: 1200),
            messageText: const Text(
              'تم اضافة العنصر الى المحفوظات ',
              style: TextStyle(color: Colors.white),
            ),
          );
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
  }

  sendMessage(id) async {
    var response = await messageData.addMessage(
      text: messageController.text,
      state: "seen",
      senderID: getID()!,
      reciverID: id.toString(),
    );

    statusRequest.value = handilingData(response);
    if (statusRequest.value == StatusRequest.succes) {
      if (response['status'] == "success") {
        var responsedata = response['data'];
        messageModel = MessageModel.fromJson(responsedata);
        messageController.clear();
        Get.rawSnackbar(message: 'تم ارسال الرسالة بنجاح');
      } else {
        Get.defaultDialog(title: "Error", middleText: "No connectd Network");
        statusRequest.value = StatusRequest.failure;
      }
    } else {
      Get.defaultDialog(title: "Server Error", middleText: "");
      statusRequest.value = StatusRequest.failure;
    }
  }

  void toggleCarSelection(int index, bool isSelected) {
    if (isSelected == true) {
      selectedCars.add(index);
    } else {
      selectedCars.remove(index);
    }
  }

  onPageChanged(int index, CarouselPageChangedReason reason) {
    currentIndex.value = index;
  }
}