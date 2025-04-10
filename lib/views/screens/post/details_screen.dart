import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/home_cotroller/home_screen_controller.dart';
import '../../../core/constant/app_colors.dart';
import '../../../model/authentication/User_model.dart';
import '../../../model/description/description_model.dart';
import 'widget/card/build_post_image.dart';
import 'widget/post_silder.dart';
import 'widget/spec_item.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    super.key,
    required this.list,
    required this.index,
    required this.descriptions,
    required this.userModel,
  });
  final RxList list;
  final int index;
  final DescriptionsModel descriptions;
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: Get.isDarkMode ? AppColors.gradientEnd : AppColors.white,
      appBar: AppBar(
        title: Text(
          'تفاصيل السيارة',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Text(
                descriptions.name!,
                style: TextStyle(
                  color:
                      Get.isDarkMode ? AppColors.textWhite70 : AppColors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'السعر: \$  ${descriptions.price}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.signInButton,
                    ),
                  ),
                  Text(
                    'الموقع: ${userModel.city}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Get.isDarkMode
                          ? AppColors.textWhite70
                          : AppColors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Divider(
                color: Get.isDarkMode ? AppColors.textWhite70 : AppColors.black,
              ),
              const SizedBox(height: 20),
              // Specifications
              Text(
                'المواصفات المميزة',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color:
                      Get.isDarkMode ? AppColors.textWhite70 : AppColors.black,
                ),
              ),
              const SizedBox(height: 8),
              GridView.count(
                crossAxisCount: 3, // دائمًا ثلاثة أعمدة
                mainAxisSpacing: 10, // تباعد عمودي
                crossAxisSpacing: 10, // تباعد أفقي

                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  SpecItem(
                      text: 'قوة المحرك\n ${descriptions.engCapacity} cc',
                      icon: Icons.engineering), // أيقونة المحرك
                  SpecItem(
                      text: 'النوع\n ${descriptions.typeCar}',
                      icon: Icons.electric_car), // أيقونة السيارة الكهربائية
                  SpecItem(
                      text: 'استهلاك الوقود\n ${descriptions.fuelConsumption}',
                      icon: Icons.local_gas_station), // أيقونة محطة الوقود
                  SpecItem(
                      text: 'المقاعد\n ${descriptions.numberSeats}',
                      icon: Icons.event_seat), // أيقونة المقاعد
                  SpecItem(
                      text: 'نظام الدفع\n ${descriptions.driveSystem}',
                      icon: Icons.drive_eta), // أيقونة نظام الدفع
                  SpecItem(
                      text: 'المسافة المقطوعة\n ${descriptions.disTravel} كم',
                      icon: Icons.directions_car), // أيقونة السيارة
                  SpecItem(
                      text:
                          'نظام تثبيت السرعة\n ${descriptions.cruiseControlSystem}',
                      icon: Icons.speed_outlined), // أيقونة نظام التثبيت
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Divider(
                color: Get.isDarkMode ? AppColors.textWhite70 : AppColors.black,
              ),
              const SizedBox(height: 20),

              // Gallery
              Text(
                'الصور الداخلية',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color:
                      Get.isDarkMode ? AppColors.textWhite70 : AppColors.black,
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              buildPostImage(screenWidth, list[index].imageOut!),
              Divider(
                color: Get.isDarkMode ? AppColors.textWhite70 : AppColors.black,
              ),
              const SizedBox(
                height: 20,
              ),

              Text(
                'الصور الخارجية',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color:
                      Get.isDarkMode ? AppColors.textWhite70 : AppColors.black,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              buildPostImage(screenWidth, list[index].imageIn!),

              SizedBox(child: ImageCarouselScreen()),
              const SizedBox(height: 16),

              // Call to Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Call action
                    },
                    icon: const Icon(Icons.chat_outlined),
                    label: Text(
                      'محادثة',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            Get.isDarkMode ? AppColors.white : AppColors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Get.isDarkMode
                          ? AppColors.textWhite70
                          : AppColors.textWhite70,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                  ),
                  Obx(() {
                    RxBool isSaved = controller.favoritesList
                        .contains(descriptions.postsId!)
                        .obs;

                    return ElevatedButton.icon(
                      onPressed: () {
                        controller.toggleFavorite(descriptions.postsId!);
                      },
                      icon: isSaved.value
                          ? const Icon(Icons.close)
                          : const Icon(Icons.bookmark),
                      label: isSaved.value
                          ? Text(
                              'إزالة',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Get.isDarkMode
                                    ? AppColors.white
                                    : AppColors.black,
                              ),
                            )
                          : Text(
                              'حفظ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Get.isDarkMode
                                    ? AppColors.white
                                    : AppColors.black,
                              ),
                            ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: !isSaved.value
                            ? AppColors.signInButton
                            : const Color(0xFFF34337),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                    );
                  })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
