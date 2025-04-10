import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../app_route.dart';
import '../../../core/class/handilind_data_view.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/function/get_functions.dart';
import '../../../link_api.dart';
import '../post/card_post.dart';
import '../../../controller/profile/my_profile_controller.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyProfileController());
    return GetX<MyProfileController>(builder: (controller) {
      return HandilingDatatView(
        statusRequest: controller.statusRequest.value,
        widget: Scaffold(
          body: SingleChildScrollView(
            child: GetX<MyProfileController>(builder: (controller) {
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
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: const Color(0xFF03BFCB),
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl:
                                    '${AppLink.imageApi}/${controller.user.image}',
                                fit: BoxFit.cover,
                                width: 90,
                                height: 90,
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    width: 90,
                                    height: 90,
                                    color: Colors.white,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Center(
                                  child: Icon(Icons.error,
                                      color: Colors.red, size: 50),
                                ),
                              ),
                            ),
                          ),
                        ],
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
                      const SizedBox(height: 4),
                      Text(
                        controller.user.city!,
                        style: const TextStyle(
                          color: Color(0xFFB3B8CD),
                          fontSize: 12,
                          letterSpacing: 1,
                          fontFamily: 'images/fonts/Cairo-Bold.ttf',
                        ),
                      ),
                      const SizedBox(height: 10),
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
                      // controller.user.id == int.parse(getID())
                      // ? ElevatedButton.icon(
                      //     onPressed: () {
                      //       Get.toNamed(AppRoutes.editProfile);
                      //     },
                      //     label: Text(
                      //       'Edit Profile',
                      //       style: Theme.of(context).textTheme.bodyMedium,
                      //     ),
                      //     style: ElevatedButton.styleFrom(
                      //       backgroundColor: Theme.of(context).primaryColor,
                      //       padding: const EdgeInsets.symmetric(
                      //         horizontal: 20,
                      //         vertical: 4,
                      //       ),
                      //       minimumSize: const Size(10, 10),
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(15),
                      //       ),
                      //     ),
                      //     icon: const Icon(
                      //       Icons.edit,
                      //       size: 16,
                      //     ),
                      //   )
                      // : const Text('data'),
                      // ? ElevatedButton.icon(
                      //     onPressed: () {
                      //       Get.toNamed(AppRoutes.editProfile);
                      //     },
                      //     label: Text(
                      //       'Edit Profile',
                      //       style: Theme.of(context).textTheme.bodyMedium,
                      //     ),
                      //     style: ElevatedButton.styleFrom(
                      //       backgroundColor: Theme.of(context).primaryColor,
                      //       padding: const EdgeInsets.symmetric(
                      //         horizontal: 20,
                      //         vertical: 4,
                      //       ),
                      //       minimumSize: const Size(10, 10),
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(15),
                      //       ),
                      //     ),
                      //     icon: const Icon(
                      //       Icons.edit,
                      //       size: 16,
                      //     ),
                      //   )
                      // : ElevatedButton.icon(
                      //     onPressed: () {
                      //       Get.toNamed(AppRoutes.editProfile);
                      //     },
                      //     label: const Text(
                      //       'Message',
                      //     ),
                      //     style: ElevatedButton.styleFrom(
                      //       // backgroundColor: Theme.of(context).primaryColor,
                      //       backgroundColor: const Color(0xFF02899C),
                      //       foregroundColor: const Color(0xFF231E39),
                      //       padding: const EdgeInsets.symmetric(
                      //         horizontal: 20,
                      //         vertical: 10,
                      //       ),
                      //       minimumSize: const Size(10, 10),
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(10),
                      //       ),
                      //     ),
                      //     icon: const Icon(
                      //       Icons.message,
                      //       size: 16,
                      //     ),
                      //   ),

                      ElevatedButton.icon(
                        onPressed: () {
                          Get.toNamed(AppRoutes.editProfile);
                        },
                        label: const Text(
                          'Edit Profile',
                        ),
                        style: ElevatedButton.styleFrom(
                          // backgroundColor: Theme.of(context).primaryColor,
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
                      ),
                      const Divider(
                        height: 20,
                        color: Color.fromARGB(61, 255, 255, 255),
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
