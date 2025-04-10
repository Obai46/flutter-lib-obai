import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../link_api.dart';
import '../card/function/show_picker_options.dart';
import '../dots_controller.dart';

class CustomBuildImageUpdate extends StatelessWidget {
  CustomBuildImageUpdate({
    super.key,
    required this.text,
    required this.selectedImages,
    required this.imageFiles,
    required this.style,
    required this.styleTextBottomSheet,
    required this.color,
    required this.iconColor,
    required this.colorBottomSheet,
    required this.pickImageGallery,
    required this.pickImageCamera,
  });

  List<XFile?> selectedImages;
  List<File> imageFiles;
  final String? text;
  final TextStyle? style;
  final TextStyle? styleTextBottomSheet;
  final Color? color;
  final Color? iconColor;
  final Color? colorBottomSheet;
  final void Function() pickImageGallery;
  final void Function() pickImageCamera;
  var currentIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text!,
          style: style,
        ),
        const SizedBox(
          height: 20,
        ),
        AspectRatio(
          aspectRatio: 16 / 11,
          child: Column(
            children: [
              CarouselSlider(
                items: selectedImages.map(
                  (file) {
                    return Stack(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: file!.path.startsWith('/storage') ||
                                file.path.startsWith(r'\storage')
                            ? CachedNetworkImage(
                                imageUrl: '${AppLink.server}${file.path}',
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Center(
                                  child: Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            : Image.file(
                                File(file.path),
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () => showPickerOptions(
                            context,
                            selectedImages,
                            imageFiles,
                            colorBottomSheet: colorBottomSheet,
                            iconColor: iconColor,
                            pickImageCamera: pickImageCamera,
                            pickImageGallery: pickImageGallery,
                            styleTextBottomSheet: styleTextBottomSheet,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green[800],
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(5),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 4,
                        left: 4,
                        child: GestureDetector(
                          onTap: () {
                            selectedImages.remove(file);
                            imageFiles
                                .removeWhere((img) => img.path == file.path);
                            Get.forceAppUpdate();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red[900],
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(5),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ]);
                  },
                ).toList(),
                options: CarouselOptions(
                  height: 210,
                  autoPlay: false,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    currentIndex.value = index;
                  },
                ),
              ),
              const SizedBox(height: 10),
              DotsControllerWidgit(
                images: selectedImages,
                currentIndex: currentIndex,
              ),
            ],
          ),
        )
      ],
    );
  }
}
