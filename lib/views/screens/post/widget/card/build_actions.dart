import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constant/app_colors.dart';
import '../../../../../controller/home_cotroller/home_screen_controller.dart';
import '../../../../../core/function/get_functions.dart';

Widget buildActions(int postId, int index, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: GetBuilder<HomeController>(builder: (controller) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Obx(() {
                bool isFavorite = controller.favoritesList.contains(postId);
                return IconButton(
                  icon: isFavorite
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 20,
                        )
                      : const Icon(
                          Icons.favorite_border,
                          color: Colors.red,
                          size: 20,
                        ),
                  onPressed: () {
                    controller.toggleFavorite(postId);
                  },
                );
              }),
              IconButton(
                icon: const Icon(Icons.chat_bubble_outline,
                    color: AppColors.signInButton, size: 20),
                onPressed: () {
                  Get.bottomSheet(
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color:
                            Get.isDarkMode ? AppColors.black : AppColors.white,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                              controller.listOfPost[index].user!.id
                                          .toString() ==
                                      getID()
                                  ? "لا يمكنك ارسال رسالة إلى نفسك !"
                                  : "إرسال رسالة إلى ${controller.listOfPost[index].user!.name},",
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                          controller.listOfPost[index].user!.id.toString() ==
                                  getID()
                              ? const SizedBox()
                              : TextFormField(
                                  controller: controller.messageController,
                                  decoration: InputDecoration(
                                    hintText: "اكتب رسالتك هنا...",
                                    hintStyle:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () => Get.back(),
                                child: const Text("إلغاء"),
                              ),
                              controller.listOfPost[index].user!.id
                                          .toString() ==
                                      getID()
                                  ? const SizedBox()
                                  : ElevatedButton(
                                      onPressed: () {
                                        controller.sendMessage(controller
                                            .listOfPost[index].user!.id);
                                        Get.back();
                                      },
                                      child: const Text("إرسال"),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      );
    }),
  );
}
