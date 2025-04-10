import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/class/status_request.dart';
import '../../../core/function/handiling_data.dart';
import '../../../services/services.dart';
import 'room_data.dart';
import 'room_model.dart';

class RoomController extends GetxController {
  Rx<StatusRequest> statusRequest = StatusRequest.none.obs;
  final ScrollController scrollController = ScrollController();
  RoomData roomData = RoomData(Get.find());
  MyServices myServices = Get.find();
  var chatList = <RoomModel>[].obs;
  var selectedUserImage = ''.obs;
  var selectedUserName = ''.obs;
  int? selectedUserid;

  @override
  void onInit() {
    super.onInit();
    viewRoom();
  }

  Future<void> refreshRoom() async {
    chatList.clear();
    await viewRoom();
  }

  void resetUserInfo() {
    selectedUserImage.value = '';
    selectedUserName.value = '';
  }

  void addRoomLocally(List<RoomModel> room) {
    chatList.addAll(room);
    update();
  }

  viewRoom() async {
    statusRequest.value = StatusRequest.loading;
    String? id = myServices.sharedPreferences.getString('id');
    var response = await roomData.viewChatList(id: id!);
    statusRequest.value = handilingData(response);
    if (statusRequest.value == StatusRequest.succes) {
      if (response['status'] == "success") {
        var responsedata = response['data'];
        List<RoomModel> rooms = (responsedata as List)
            .map((roomJson) => RoomModel.fromJson(roomJson))
            .toList();
        addRoomLocally(rooms);
      } else {
        Get.defaultDialog(
            title: "Error", middleText: "Passwoed or Email Not Found");
        statusRequest.value = StatusRequest.failure;
      }
    } else {
      Get.defaultDialog(title: "Server Error", middleText: "");
      statusRequest.value = StatusRequest.failure;
    }
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.minScrollExtent);
      }
    });
  }
}
