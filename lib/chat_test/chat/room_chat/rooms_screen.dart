import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/class/handilind_data_view.dart';
import '../../../link_api.dart';
import '../chats_users/chat_controller.dart';
import '../chats_users/chat_screen.dart';
import 'room_controller.dart';

class RoomScreen extends StatelessWidget {
  const RoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RoomController roomController = Get.put(RoomController());
    final ChatController chatController = Get.put(ChatController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chat",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Obx(
        () {
          return HandilingDatatView(
            statusRequest: roomController.statusRequest.value,
            widget: RefreshIndicator(
              onRefresh: () async {
                await roomController.refreshRoom();
              },
              child: roomController.chatList.isNotEmpty
                  ? ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: roomController.scrollController,
                      itemCount: roomController.chatList.length,
                      itemBuilder: (context, index) {
                        final room = roomController.chatList[index];

                        return Column(
                          children: room.users!.map(
                            (user) {
                              final lastMessage = room.messages?.last.text;
                              return ListTile(
                                contentPadding: const EdgeInsets.all(10),
                                leading: CircleAvatar(
                                  radius: 25,
                                  backgroundImage: CachedNetworkImageProvider(
                                      '${AppLink.imageApi}/${user.image}'),
                                ),
                                title: Text(
                                  user.name!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                                subtitle: Text(
                                  lastMessage!,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward,
                                  color: Get.isDarkMode
                                      ? AppColors.textWhite70
                                      : AppColors.white,
                                ),
                                onTap: () {
                                  roomController.selectedUserName.value =
                                      user.name!;
                                  roomController.selectedUserImage.value =
                                      user.image!;
                                  roomController.selectedUserid = user.id!;
                                  chatController.refreshPage();
                                  chatController.getMessage(user.id.toString());
                                  Get.to(() => ChatScreen());
                                },
                              );
                            },
                          ).toList(),
                        );
                      },
                    )
                  : SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                          child: Text(
                            "! لا يوجد محادثات بعد",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
