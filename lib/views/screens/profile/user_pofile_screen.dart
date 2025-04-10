import 'package:cached_network_image/cached_network_image.dart';
import 'package:cfy/core/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_route.dart';
import '../../../core/class/handilind_data_view.dart';
import '../../../core/function/get_functions.dart';
import '../../../link_api.dart';
import '../post/card_post.dart';
import '../../../controller/profile/user_pofile_controller.dart';

class UserPofileScreen extends StatelessWidget {
  const UserPofileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserPofileController());
    return GetX<UserPofileController>(builder: (controller) {
      return HandilingDatatView(
        statusRequest: controller.statusRequest.value,
        widget: Scaffold(
          body: SingleChildScrollView(
            child: GetX<UserPofileController>(builder: (controller) {
              return Center(
                child: Container(
                  padding: const EdgeInsets.only(top: 50),
                  decoration:
                      BoxDecoration(color: AppColors.gradientStart, boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.75),
                        blurRadius: 20,
                        offset: const Offset(0, 30)),
                  ]),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: const Color(0xFF03BFCB),
                            child: CircleAvatar(
                              radius: 45,
                              backgroundImage: CachedNetworkImageProvider(
                                  '${AppLink.imageApi}/${controller.user.image}'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        controller.user.name!,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          fontFamily: 'images/fonts/Cairo-Bold.ttf',
                        ),
                      ),
                      Text(
                        controller.user.city!,
                        style: const TextStyle(
                          color: Color(0xFFB3B8CD),
                          fontSize: 12,
                          letterSpacing: 1,
                          fontFamily: 'images/fonts/Cairo-Bold.ttf',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Posts: ${controller.listOfPost.length}',
                        style: const TextStyle(
                          color: Color(0xFFB3B8CD),
                          letterSpacing: 1,
                          fontSize: 12,
                          fontFamily: 'images/fonts/Cairo-Bold.ttf',
                        ),
                      ),
                      const SizedBox(height: 20),
                      controller.user.id == int.parse(getID())
                          ? ElevatedButton.icon(
                              onPressed: () {
                                Get.toNamed(AppRoutes.editProfile);
                              },
                              label: const Text(
                                'Edit Profile',
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF02899C),
                                foregroundColor: const Color(0xFF231E39),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                minimumSize: const Size(10, 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              icon: const Icon(
                                Icons.edit,
                                size: 16,
                              ),
                            )
                          : ElevatedButton.icon(
                              onPressed: () {
                                Get.toNamed(AppRoutes.editProfile);
                              },
                              label: const Text(
                                'Message',
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF02899C),
                                foregroundColor: const Color(0xFF231E39),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                minimumSize: const Size(10, 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              icon: const Icon(
                                Icons.message,
                                size: 16,
                              ),
                            ),
                      Divider(
                        height: 40,
                        color: Theme.of(context).hintColor,
                      ),
                      controller.listOfPost.isEmpty
                          ? Center(
                              heightFactor: 10,
                              child: Text(
                                "لا يوجد منشورات بعد !",
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.listOfPost.length,
                              itemBuilder: (context, index) {
                                return CardPost(
                                  list: controller.listOfPost,
                                  postModel: controller.listOfPost[index],
                                  index: index,
                                  postID: controller.listOfPost[index].id!,
                                );
                              },
                            ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      );
    });
  }
}
