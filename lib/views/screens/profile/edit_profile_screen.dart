import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/profile/edit_profile_controller.dart';
import '../../../core/class/handilind_data_view.dart';
import '../../../core/constant/app_colors.dart';
import '../../../link_api.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProfileController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit profile',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Obx(
        () {
          return HandilingDatatView(
            statusRequest: controller.statusRequest.value,
            widget: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Divider(
                    height: 30,
                    color: Theme.of(context).hintColor,
                  ),
                  CustomPieceProfile(
                    onPressed: () {
                      showModalBottomSheet(
                        backgroundColor: AppColors.gradientStart,
                        context: context,
                        builder: (context) => SizedBox(
                          height: 200,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  controller.galleryImage();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(20),
                                  child: const Text(
                                    "Choose Image From Gallery",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: AppColors.textWhite70),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              InkWell(
                                onTap: () {
                                  controller.cameraImage();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(20),
                                  child: const Text(
                                    "Choose Image From Camer",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: AppColors.textWhite70),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    title: 'Profile picture',
                    body: '',
                  ),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: controller.user.value.image != null
                        ? CachedNetworkImageProvider(
                            '${AppLink.imageApi}/${controller.user.value.image}')
                        : const AssetImage('assetName'),
                  ),
                  Divider(
                    height: 80,
                    color: Theme.of(context).hintColor,
                  ),
                  CustomPieceProfile(
                    onPressed: () => _showEditDialog(
                      context: context,
                      onCancel: () => controller.onCancel(context),
                      onSave: () => controller.updateName(context),
                      textController: controller.textController,
                      title: 'Name ',
                    ),
                    title: 'Name',
                    body: controller.user.value.name ?? 'User Name',
                  ),
                  Divider(
                    height: 80,
                    color: Theme.of(context).hintColor,
                  ),
                  CustomPieceProfile(
                    onPressed: () => _showEditDialog(
                      context: context,
                      title: 'Password',
                      onSave: () => controller.updatePassword(context),
                      onCancel: () => controller.onCancel(context),
                      textController: controller.textController,
                    ),
                    title: 'Password',
                    body: '**********',
                  ),
                  Divider(
                    height: 80,
                    color: Theme.of(context).hintColor,
                  ),
                  CustomPieceProfile(
                    onPressed: () {
                      _showEditDialog(
                        context: context,
                        title: 'City',
                        onSave: () => controller.updateCity(context),
                        onCancel: () => controller.onCancel(context),
                        textController: controller.textController,
                      );
                    },
                    title: 'City',
                    body: controller.user.value.city ?? 'Undifinde',
                  ),
                  Divider(
                    height: 80,
                    color: Theme.of(context).hintColor,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CustomPieceProfile extends StatelessWidget {
  const CustomPieceProfile({
    super.key,
    required this.title,
    required this.body,
    required this.onPressed,
  });
  final String title;
  final String body;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            body,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          TextButton(
            onPressed: onPressed,
            child: const Text(
              'Edit',
              style: TextStyle(
                color: AppColors.signInButton,
                fontSize: 18,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _showEditDialog({
  required BuildContext context,
  required String title,
  required void Function() onSave,
  required void Function() onCancel,
  required TextEditingController textController,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Edit $title',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        content: TextField(
          style: Theme.of(context).textTheme.headlineSmall,
          controller: textController,
          decoration: InputDecoration(
            hintText: 'Enter new $title',
            hintStyle: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        actions: [
          TextButton(
            onPressed: onCancel,
            child: Text(
              'Cancel',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          TextButton(
            onPressed: onSave,
            child: Text(
              'Save',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ],
      );
    },
  );
}
