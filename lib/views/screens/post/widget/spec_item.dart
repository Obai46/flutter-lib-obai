import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constant/app_colors.dart';

class SpecItem extends StatelessWidget {
  final String text;
  final IconData icon;

  const SpecItem({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Get.isDarkMode ? AppColors.textWhite70 : AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: AppColors.signInButton), // الأيقونة
          const SizedBox(height: 5),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown, // يجعل النص يتناسب مع الحاوية
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}