import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constant/app_colors.dart';

class DotsControllerWidgit extends StatelessWidget {
  DotsControllerWidgit(
      {super.key, required this.images, required this.currentIndex});
  final List<dynamic> images;
  RxInt currentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        images.length,
        (index) => Obx(
          () {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 10,
              width: currentIndex.value == index ? 20 : 10,
              decoration: BoxDecoration(
                color: currentIndex.value == index
                    ? AppColors.signInButton
                    : Get.isDarkMode
                        ? AppColors.textWhite70
                        : AppColors.black,
                borderRadius: BorderRadius.circular(10),
              ),
            );
          },
        ),
      ),
    );
  }
}
