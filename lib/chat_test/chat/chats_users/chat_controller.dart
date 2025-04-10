import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/class/status_request.dart';
import '../../../core/function/get_functions.dart';
import '../../../core/function/handiling_data.dart';
import 'message_data.dart';
import 'message_model.dart';

class ChatController extends GetxController {
  var messages = <MessageModel>[].obs;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  MessageData messageData = MessageData(Get.find());
  MessageModel messageModel = Get.put(MessageModel());
  StatusRequest statusRequest = StatusRequest.none;
  late TextEditingController textContoller;
  final ScrollController scrollController = ScrollController();
  String? userID = getID();

  @override
  void onInit() {
    super.onInit();
    _initializeFirebase();
    textContoller = TextEditingController();
  }

  refreshChat(String id) async {
    messages.clear();
    await getMessage(id);
  }

  void _initializeFirebase() async {
    await _firebaseMessaging.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        final msg = MessageModel(
          text: message.data['text'],
          state: message.data['state'],
          roomId: message.data['roomId'],
          senderUsersId: message.data['senderUsersId'],
          resiverUsersId: message.data['resiverUsersId'],
          updatedAt: message.data['updatedAt'],
          createdAt: message.data['createdAt'],
        );
        messages.add(msg);
      } else {}
    });
  }

  void addMessageLocally(MessageModel msg) {
    messages.add(msg);
    update();
  }

  refreshPage() {
    messages.clear();
  }

  getMessage(String id) async {
    var response = await messageData.getMessage(sendID: userID!, reseiveID: id);
    statusRequest = handilingData(response);
    if (statusRequest == StatusRequest.succes) {
      if (response['status'] == "success") {
        var responsedata = response['data'];
        List<MessageModel> messageModels = (responsedata as List)
            .map((messageJson) => MessageModel.fromJson(messageJson))
            .toList();
        messages.clear();
        messages.addAll(messageModels);
        update();
      } else {
        Get.defaultDialog(
            title: "Error", middleText: "Passwoed or Email Not Found");
        statusRequest = StatusRequest.failure;
      }
      update();
    } else {
      Get.defaultDialog(title: "Server Error", middleText: "");
      statusRequest = StatusRequest.failure;
    }
  }

  addMessage(int id) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await messageData.addMessage(
      text: textContoller.text,
      state: "seen",
      senderID: userID!,
      reciverID: id.toString(),
    );

    statusRequest = handilingData(response);
    if (statusRequest == StatusRequest.succes) {
      if (response['status'] == "success") {
        var responsedata = response['data'];
        messageModel = MessageModel.fromJson(responsedata);
        addMessageLocally(messageModel);
      } else {
        Get.defaultDialog(
            title: "Error", middleText: "Passwoed or Email Not Found");
        statusRequest = StatusRequest.failure;
      }
    } else {
      Get.defaultDialog(title: "Server Error", middleText: "");
      statusRequest = StatusRequest.failure;
    }
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }
}
