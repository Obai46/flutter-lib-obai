// بناء الوصف
import 'package:flutter/material.dart';

import '../../../../../core/constant/app_colors.dart';
import '../../../../../model/description/description_model.dart';

Widget buildDescription(DescriptionsModel description, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Car Name: ${description.carsModel!.type ?? "Unknown"}",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 5),
        Text(
          "Model: ${description.model ?? "Unknown"}",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 5),
        const Text(
          "Show More",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.signInButton),
        ),
      ],
    ),
  );
}
