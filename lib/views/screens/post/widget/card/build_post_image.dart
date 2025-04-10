import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controller/post_controller/post_controller.dart';
import '../../../../../link_api.dart';
import '../dots_controller.dart';

Widget buildPostImage(double screenWidth, List<dynamic> images) {
  return AspectRatio(
    aspectRatio: 16 / 11,
    child: GetBuilder<PostController>(builder: (controller) {
      var currentIndex = 0.obs;

      return Column(
        children: [
          CarouselSlider(
            items: images.map(
              (file) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: CachedNetworkImage(
                    imageUrl: '${AppLink.server}$file',
                    width: double.infinity,
                    height: double.infinity,

                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
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
            images: images,
            currentIndex: currentIndex,
          ),
        ],
      );
    }),
  );
}
