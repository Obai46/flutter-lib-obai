import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../link_api.dart';

class CustomViewImageWithDesc extends StatelessWidget {
  const CustomViewImageWithDesc({
    super.key,
    required this.selectedImages,
  });

  final List<XFile?> selectedImages;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: selectedImages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: selectedImages[index]!.path.startsWith(
                            '/storage',
                          ) ||
                      selectedImages[index]!.path.startsWith(
                            r'\storage',
                          )
                  ? CachedNetworkImage(
                      imageUrl:
                          '${AppLink.server}${selectedImages[index]!.path}',
                    )
                  : Image.file(
                      File(selectedImages[index]!.path),
                      fit: BoxFit.cover,
                      width: 120,
                      height: 120,
                    ),
            ),
          );
        },
      ),
    );
  }
}
