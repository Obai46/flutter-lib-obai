import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/class/handilind_data_view.dart';
import '../../../core/function/get_functions.dart';
import '../../../link_api.dart';
import '../room_chat/room_controller.dart';
import 'chat_controller.dart';

class ChatScreen extends StatelessWidget {
  ChatController chatController = Get.put(ChatController());
  RoomController roomController = Get.put(RoomController());

  ChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: CachedNetworkImageProvider(
              "${AppLink.imageApi}/${roomController.selectedUserImage}",
            ),
          ),
          title: Text(
            "${roomController.selectedUserName}",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () {
                chatController.scrollToBottom();
                return ListView.builder(
                  controller: chatController.scrollController,
                  reverse: false,
                  itemCount: chatController.messages.length,
                  itemBuilder: (context, index) {
                    final message = chatController.messages[index];
                    final bool isSender =
                        message.senderUsersId.toString() == getID();
                    return Align(
                      alignment: isSender
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSender
                              ? AppColors.gradientStart
                              : AppColors.gradientEnd,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(12),
                            topRight: const Radius.circular(12),
                            bottomLeft: Radius.circular(isSender ? 12 : 0),
                            bottomRight: Radius.circular(isSender ? 0 : 12),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              message.text!,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(height: 4),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: chatController.textContoller,
                    decoration: const InputDecoration(
                      hintText: "Type your message...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GetBuilder<ChatController>(builder: (controller) {
                  return HandilingDatatView(
                    statusRequest: chatController.statusRequest,
                    widget: GestureDetector(
                      onTap: () {
                        final msg = controller.textContoller.text.trim();
                        if (msg.isNotEmpty) {
                          controller.addMessage(roomController.selectedUserid!);
                          controller.textContoller.clear();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.gradientStart,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.send,
                            color: AppColors.signInButton),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
