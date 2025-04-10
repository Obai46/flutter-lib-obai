import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constant/app_colors.dart';

class CustomButtonAppBar extends StatelessWidget {
  CustomButtonAppBar({
    super.key,
    required this.onPressed,
    required this.textButton,
    required this.iconButton,
    required this.active,
  });
  final void Function() onPressed;
  final String textButton;
  final IconData iconButton;
  RxBool active = false.obs;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: onPressed,
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                iconButton,
                color: active.value == true
                    ? AppColors.signInButton
                    : Get.isDarkMode
                        ? AppColors.gradientStart
                        : AppColors.white,
              ),
              Text(
                textButton,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  color: active.value == true
                      ? AppColors.signInButton
                      : Get.isDarkMode
                          ? AppColors.gradientStart
                          : AppColors.white,
                ),
              ),
            ],
          ),
        ));
  }
}
