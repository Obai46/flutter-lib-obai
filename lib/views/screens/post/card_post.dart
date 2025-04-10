import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_route.dart';
import '../../../core/constant/app_colors.dart';
import '../../../model/post/posts_model.dart';
import 'widget/card/build_actions.dart';
import 'widget/card/build_description.dart';
import 'widget/card/build_header.dart';
import 'widget/card/build_post_image.dart';
import 'details_screen.dart';

class CardPost extends StatelessWidget {
  const CardPost({
    super.key,
    required this.list,
    required this.index,
    required this.postModel,
    required this.postID,
  });
  final RxList list;
  final int index;
  final int postID;
  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    final users = postModel;
    final descriptions = list[index].descriptions;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      width: screenWidth,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Get.isDarkMode ? Colors.blueGrey[900]! : Colors.blueGrey,
            Get.isDarkMode ? AppColors.gradientEnd : AppColors.gradientStart,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.white.withOpacity(0.5),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header (User Info)
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.userProfile,
                    arguments: {'id': postModel.usersId});
              },
              child: buildHeader(users, context, () {}),
            ), // Post Image
            buildPostImage(screenWidth, list[index].imageOut!),
            // Descriptions
            InkWell(
              onTap: () => Get.to(DetailsScreen(
                list: list,
                index: index,
                descriptions: postModel.descriptions!,
                userModel: postModel.user!,
              )),
              child: buildDescription(descriptions!, context),
            ),
            buildActions(postID, index, context),
          ],
        ),
      ),
    );
  }
}
