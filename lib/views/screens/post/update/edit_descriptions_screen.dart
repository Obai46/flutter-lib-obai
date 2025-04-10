import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/class/handilind_data_view.dart';
import '../widget/build_deop_down_field.dart';
import '../widget/custom_text_field.dart';
import '../widget/custom_view_image_desc.dart';
import '../../../../controller/post_controller/edit_post_controller.dart';

class EditDescriptionsScreen extends StatelessWidget {
  const EditDescriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EditPostController controller = Get.find<EditPostController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "تعديل الوصف",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: HandilingDatatView(
            statusRequest: controller.statusRequest.value,
            widget: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // عرض الصور
                  GetBuilder<EditPostController>(builder: (context) {
                    return CustomViewImageWithDesc(
                      selectedImages: controller.selectedImagesInSide,
                    );
                  }),
                  const SizedBox(height: 16),
                  CustomViewImageWithDesc(
                    selectedImages: controller.selectedImagesOutSide,
                  ),
                  const SizedBox(height: 20),

                  // ماركة السيارة
                  Obx(
                    () => buildDropdownField(
                      label: 'Car Brand',
                      items: List.generate(
                          controller.carType.length,
                          (index) => {
                                'key': controller.carType[index],
                                'value': controller.carID[index].toString(),
                              }),
                      onChanged: (value) =>
                          controller.selectedBrandCar.value = value!,
                      validatorMessage: 'ماركة السيارة مطلوبة',
                      context: context,
                      value: controller.selectedBrandCar.value,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // اسم السيارة
                  buildTextField(
                    context: context,
                    label: "Car name",
                    controller: controller.carNameController,
                    validatorMessage: "اسم السيارة مطلوب",
                  ),
                  const SizedBox(height: 16),

                  // الموديل
                  buildTextField(
                    context: context,
                    label: "Model",
                    controller: controller.modelController,
                    validatorMessage: "الموديل مطلوب",
                    isDouble: true,
                  ),
                  const SizedBox(height: 16),

                  // نوع السيارة
                  buildDropdownField(
                    value: controller.selectedTypeCar.value,
                    context: context,
                    label: "Type car",
                    items: [
                      {'key': 'Hybrid', 'value': 'Hybrid'},
                      {'key': 'Electric', 'value': 'Electric'},
                      {'key': 'Gasoline', 'value': 'Gasoline'},
                      {'key': 'Diesel', 'value': 'Diesel'},
                    ],
                    onChanged: (value) =>
                        controller.selectedTypeCar.value = value!,
                    validatorMessage: "نوع السيارة مطلوب",
                  ),
                  const SizedBox(height: 16),

                  // سعة المحرك
                  buildTextField(
                    context: context,
                    label: "Engine capacity (cc)",
                    controller: controller.engineCapacityController,
                    validatorMessage: "سعة المحرك مطلوبة",
                    isDouble: true,
                  ),
                  const SizedBox(height: 16),

                  // المسافة المقطوعة
                  buildTextField(
                    context: context,
                    label: "Distance traveled (km)",
                    controller: controller.distanceTraveledController,
                    validatorMessage: "المسافة المقطوعة مطلوبة",
                    isDouble: true,
                  ),
                  const SizedBox(height: 16),

                  // استهلاك الوقود
                  buildDropdownField(
                    value: controller.selectedFuelConsumption.value,
                    context: context,
                    label: "Fuel consumption",
                    items: [
                      {'key': "Very Low", 'value': 'Very Low'},
                      {'key': "Low", 'value': 'Low'},
                      {'key': "Medium", 'value': 'Medium'},
                      {'key': "High", 'value': 'High'},
                      {'key': "Very High", 'value': 'Very High'},
                    ],
                    onChanged: (value) =>
                        controller.selectedFuelConsumption.value = value!,
                    validatorMessage: "استهلاك الوقود مطلوب",
                  ),

                  const SizedBox(height: 16),

                  // نظام القيادة
                  buildDropdownField(
                    value: controller.selectedDriveSystem.value,
                    context: context,
                    label: "Drive system",
                    items: [
                      {"value": 'Front', "key": "Front"},
                      {"value": 'Rear', "key": "Rear"},
                      {"value": 'Four-wheel drive', "key": "Four-wheel drive"},
                    ],
                    onChanged: (value) =>
                        controller.selectedDriveSystem.value = value!,
                    validatorMessage: "نظام القيادة مطلوب",
                  ),
                  const SizedBox(height: 16),

                  // عدد المقاعد
                  buildTextField(
                    context: context,
                    label: "Number of seats",
                    controller: controller.numberSeatsController,
                    keyboardType: TextInputType.number,
                    validatorMessage: "عدد المقاعد مطلوب",
                    isDouble: true,
                  ),
                  const SizedBox(height: 16),

                  // نظام التحكم الذكي
                  buildDropdownField(
                      label: "Cruise Control system",
                      items: [
                        {"value": '1', "key": "Available"},
                        {"value": '0', "key": "Unavailable"},
                      ],
                      onChanged: (value) {
                        controller.selectedCruiseControlSystem.value = value!;
                      },
                      validatorMessage: "نظام التحكم الذكي مطلوب",
                      context: context,
                      value: controller.selectedCruiseControlSystem.value),

                  const SizedBox(height: 16),

                  // السعر
                  buildTextField(
                    context: context,
                    label: "Price (\$)",
                    controller: controller.priceController,
                    keyboardType: TextInputType.number,
                    validatorMessage: "السعر مطلوب",
                    isDouble: true,
                  ),
                  const SizedBox(height: 16),

                  // زر نشر البوست
                  GetX<EditPostController>(
                    builder: (controller) {
                      return HandilingDatatView(
                        statusRequest: controller.statusRequest.value,
                        widget: Center(
                          child: ElevatedButton(
                            onPressed: () => controller.updatePost(),
                            child: Text(
                              "تعديل المنشور",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
