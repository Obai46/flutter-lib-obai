import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../app_route.dart';
import '../../../../../controller/post_controller/post_controller.dart';
import '../../../../../core/constant/app_colors.dart';
import '../../../../../core/function/get_functions.dart';
import '../../../../../link_api.dart';
import '../../../../../model/post/posts_model.dart';

Widget buildHeader(PostModel post, BuildContext context, Function deletePost) {
  DateTime? dateTime = DateTime.parse(post.createdAt.toString());
  Get.find<PostController>();
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Row(
      children: [
        CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(
              "${AppLink.imageApi}/${post.user!.image}"),
          radius: 30,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ListTile(
            title: Text(
              post.user?.name ?? "Unknown User",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: Text(timeago.format(dateTime),
                style: Theme.of(context).textTheme.bodySmall),
          ),
        ),
        int.parse(getID()) == post.usersId
            ? GetBuilder<PostController>(builder: (controller) {
                return PopupMenuButton<int>(
                  icon: const Icon(Icons.more_vert),
                  color: Theme.of(context).primaryColor,
                  iconColor: AppColors.white,
                  onSelected: (value) {
                    switch (value) {
                      case 1:
                        Get.toNamed(AppRoutes.editPostScreen,
                            arguments: {'id': post.id});
                        break;
                      case 2:
                        controller.deletePost(post.id!, context);
                        break;
                    }
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                    const PopupMenuItem<int>(
                      value: 1,
                      child: Text(
                        'تعديل',
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                    const PopupMenuItem<int>(
                      value: 2,
                      child: Text(
                        'حذف',
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                  ],
                );
              })
            : const Text('')
      ],
    ),
  );
}
