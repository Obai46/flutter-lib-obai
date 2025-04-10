import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app_route.dart';
import '../../../../core/constant/app_colors.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
        Get.toNamed(AppRoutes.favorite);
      },
      child: Icon(
        Icons.bookmark,
        color: Get.isDarkMode ? AppColors.gradientStart : AppColors.white,
      ),
    );
  }
}