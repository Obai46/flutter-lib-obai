import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_route.dart';
import '../../../chat_test/chat/room_chat/rooms_screen.dart';
import '../../../controller/post_controller/post_controller.dart';
import '../../../core/class/handilind_data_view.dart';
import '../post/card_post.dart';
import '../../../controller/home_cotroller/home_screen_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    Get.put(PostController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CFY',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          Obx(
            () => IconButton(
              icon: controller.selectedCars.isEmpty
                  ? const Icon(
                      Icons.filter_list,
                    )
                  : const Icon(
                      Icons.filter_list_off,
                    ),
              onPressed: () {
                Get.toNamed(AppRoutes.filter);
              },
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.chat,
            ),
            onPressed: () {
              Get.to(() => const RoomScreen());
            },
          ),
        ],
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) {
          return Obx(
            () {
              return HandilingDatatView(
                statusRequest: controller.statusRequest.value,
                widget: RefreshIndicator(
                  onRefresh: () async {
                    await controller.getAllPosts();
                  },
                  child: controller.listOfPost.isEmpty
                      ? SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: Center(
                              child: Text(
                                "No Data",
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                          ),
                        )
                      : Obx(
                          () => ListView.builder(
                            itemCount: controller.listOfPost.length,
                            itemBuilder: (context, index) {
                              controller.listOfPost[index];
                              return CardPost(
                                list: controller.listOfPost,
                                postModel: controller.listOfPost[index],
                                index: index,
                                postID: controller.listOfPost[index].id!,
                              );
                            },
                          ),
                        ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
