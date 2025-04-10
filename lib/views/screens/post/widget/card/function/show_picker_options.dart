import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

void showPickerOptions(
  BuildContext context,
  List<XFile?> selectedImages,
  List<File> imageFiles, {
  required colorBottomSheet,
  required iconColor,
  required styleTextBottomSheet,
  required void Function() pickImageGallery,
  required void Function() pickImageCamera,
}) {
  Get.bottomSheet(
    SafeArea(
      child: Container(
        color: colorBottomSheet,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(
                Icons.camera_alt,
                color: iconColor,
              ),
              title: Text(
                "التقاط صورة بالكاميرا",
                style: styleTextBottomSheet,
              ),
              onTap: pickImageCamera,
            ),
            ListTile(
              leading: Icon(
                Icons.photo_library,
                color: iconColor,
              ),
              title: Text(
                "اختيار من الاستوديو",
                style: styleTextBottomSheet,
              ),
              onTap: pickImageGallery,
            ),
          ],
        ),
      ),
    ),
  );
}
