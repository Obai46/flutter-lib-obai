import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/post_controller/post_controller.dart';

class ImageCarouselScreen extends StatelessWidget {
  final PostController controller = Get.put(PostController());

  ImageCarouselScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: controller.imageFilesInSide.map(
            (file) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  file,
                ),
              );
            },
          ).toList(),
          options: CarouselOptions(
            height: 220,
            autoPlay: false,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            autoPlayInterval: const Duration(seconds: 3),
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              controller.currentIndex.value = index;
            },
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: controller.imageFilesInSide.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () {
                controller.currentIndex.value = entry.key;
              },
              child: Container(
                width: 10.0,
                height: 6.0,
                margin: const EdgeInsets.symmetric(horizontal: 0.3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: controller.currentIndex.value == entry.key
                      ? Colors.red
                      : Colors.grey,
                ),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
