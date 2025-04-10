import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app_route.dart';
import '../../../../core/class/handilind_data_view.dart';
import '../widget/update/custom_build_image_update.dart';
import '../../../../controller/post_controller/edit_post_controller.dart';

class EditPostScreen extends StatelessWidget {
  const EditPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EditPostController controller = Get.put(EditPostController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "تعديل المنشور ",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          GetBuilder<EditPostController>(
            builder: (_) => TextButton(
              onPressed: controller.selectedImagesInSide.isNotEmpty &&
                      controller.selectedImagesOutSide.isNotEmpty
                  ? () {
                      Get.toNamed(AppRoutes.editDescriptionsScreen);
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
      body: GetX<EditPostController>(builder: (controller) {
        return HandilingDatatView(
          statusRequest: controller.statusRequest.value,
          widget: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GetBuilder<EditPostController>(builder: (_) {
                  return CustomBuildImageUpdate(
                    pickImageCamera: () {
                      controller.selectedImagesInSide.clear();
                      controller.imageFilesInSide.clear();
                      controller.pickFromCamera(
                        controller.selectedImagesInSide,
                        controller.imageFilesInSide,
                      );
                    },
                    pickImageGallery: () {
                      controller.selectedImagesInSide.clear();
                      controller.imageFilesInSide.clear();
                      controller.pickFromGallery(
                        controller.selectedImagesInSide,
                        controller.imageFilesInSide,
                      );
                    },
                    iconColor: Theme.of(context).hintColor,
                    styleTextBottomSheet:
                        Theme.of(context).textTheme.bodyMedium,
                    colorBottomSheet: Theme.of(context).primaryColor,
                    color: Theme.of(context).primaryColor,
                    style: Theme.of(context).textTheme.headlineMedium,
                    selectedImages: controller.selectedImagesInSide,
                    imageFiles: controller.imageFilesInSide,
                    text: 'صور داخلية',
                  );
                }),
                const SizedBox(height: 16),
                GetBuilder<EditPostController>(builder: (_) {
                  return CustomBuildImageUpdate(
                    pickImageCamera: () => controller.pickFromCamera(
                      controller.selectedImagesOutSide,
                      controller.imageFilesOutSide,
                    ),
                    pickImageGallery: () => controller.pickFromGallery(
                      controller.selectedImagesOutSide,
                      controller.imageFilesOutSide,
                    ),
                    iconColor: Theme.of(context).hintColor,
                    styleTextBottomSheet:
                        Theme.of(context).textTheme.bodyMedium,
                    colorBottomSheet: Theme.of(context).primaryColor,
                    color: Theme.of(context).primaryColor,
                    style: Theme.of(context).textTheme.headlineMedium,
                    selectedImages: controller.selectedImagesOutSide,
                    imageFiles: controller.imageFilesOutSide,
                    text: "صور خارجية",
                  );
                }),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      }),
    );
  }
}
