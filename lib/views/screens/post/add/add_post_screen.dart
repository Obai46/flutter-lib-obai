import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app_route.dart';
import '../../../../controller/post_controller/post_controller.dart';
import '../widget/add/image_container_custom.dart';

class AddImagesPage extends StatelessWidget {
  const AddImagesPage({super.key});
  @override
  Widget build(BuildContext context) {
    final PostController controller = Get.put(PostController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "منشور جديد",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          GetBuilder<PostController>(
            builder: (_) => TextButton(
              onPressed: controller.selectedImagesInSide.isNotEmpty &&
                      controller.selectedImagesOutSide.isNotEmpty
                  ? () {
                      Get.toNamed(AppRoutes.addDescreptions);
                    }
                  : () {
                      Get.rawSnackbar(
                          duration: const Duration(seconds: 1),
                          messageText: const Text('الرجاء اضافة صور للمنشور'));
                    },
              child: const Text(
                "التالي",
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GetBuilder<PostController>(builder: (controller) {
                return ImageContainerCustom(
                  pickImageCamera: () => controller.pickFromCamera(
                    controller.selectedImagesInSide,
                    controller.imageFilesInSide,
                  ),
                  pickImageGallery: () => controller.pickFromGallery(
                    controller.selectedImagesInSide,
                    controller.imageFilesInSide,
                  ),
                  iconColor: Theme.of(context).hintColor,
                  styleTextBottomSheet: Theme.of(context).textTheme.bodyMedium,
                  colorBottomSheet: Theme.of(context).primaryColor,
                  color: Theme.of(context).primaryColor,
                  style: Theme.of(context).textTheme.headlineMedium,
                  // controller: controller,
                  selectedImages: controller.selectedImagesInSide,
                  imageFiles: controller.imageFilesInSide,
                  text: 'صور داخلية',
                );
              }),
              const SizedBox(
                height: 20,
              ),
              GetBuilder<PostController>(builder: (controller) {
                return ImageContainerCustom(
                  pickImageCamera: () => controller.pickFromCamera(
                    controller.selectedImagesOutSide,
                    controller.imageFilesOutSide,
                  ),
                  pickImageGallery: () => controller.pickFromGallery(
                    controller.selectedImagesOutSide,
                    controller.imageFilesOutSide,
                  ),
                  iconColor: Theme.of(context).hintColor,
                  styleTextBottomSheet: Theme.of(context).textTheme.bodyMedium,
                  colorBottomSheet: Theme.of(context).primaryColor,
                  color: Theme.of(context).primaryColor,
                  style: Theme.of(context).textTheme.headlineMedium,
                  // controller: controller,
                  selectedImages: controller.selectedImagesOutSide,
                  imageFiles: controller.imageFilesOutSide,
                  text: "صور خارجية",
                );
              }),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
