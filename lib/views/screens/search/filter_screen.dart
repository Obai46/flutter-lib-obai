import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../controller/home_cotroller/home_screen_controller.dart';
import '../../../controller/post_controller/post_controller.dart';
import '../../../core/class/handilind_data_view.dart';
import '../../../link_api.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    // MediaQuery.orientationOf(context).

    final PostController postController = Get.find<PostController>();
    final HomeController homeController = Get.find<HomeController>();
    final RxList<int> tempSelectedCars =
        RxList<int>.from(homeController.selectedCars);

    return Scaffold(
      appBar: AppBar(
        title: Text('Filter', style: Theme.of(context).textTheme.titleLarge),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              print(isPortrait);
              size.height >= 600 ? print('true') : print('false');
              homeController.selectedCars.assignAll(tempSelectedCars);
              homeController.getAllPosts(
                  filteredCars: homeController.selectedCars);
              Get.back();
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: GetBuilder<HomeController>(builder: (controller) {
        return HandilingDatatView(
          statusRequest: controller.statusRequest.value,
          widget: Padding(
              // padding: const EdgeInsets.all(16.0),
              padding: EdgeInsets.all(
                  (size.width >= 600 || isPortrait == false) ? 4 : 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio:
                            (size.width >= 600 || isPortrait == false)
                                ? 1.8
                                : 0.8,
                        crossAxisCount:
                            (size.width >= 600 || isPortrait == false) ? 3 : 2,
                        // crossAxisSpacing: 8,
                        // mainAxisSpacing: 8,
                      ),
                      itemCount: postController.carID.length,
                      itemBuilder: (context, index) {
                        int id = int.parse(postController.carID[index]);

                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // صورة السيارة
                              SizedBox(
                                height: 80,
                                width: 100,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(35),
                                  child: CachedNetworkImage(
                                    maxHeightDiskCache: 500,
                                    maxWidthDiskCache: 500,
                                    imageUrl:
                                        '${AppLink.server}${postController.carImage[index]}',
                                    fit: BoxFit.contain,
                                    placeholder: (context, url) =>
                                        Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(35),
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Center(
                                      child: Icon(Icons.error,
                                          color: Colors.red, size: 50),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 8),

                              // الاسم + checkbox
                              Obx(() => Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Checkbox(
                                        value: tempSelectedCars.contains(id),
                                        checkColor: const Color.fromARGB(
                                            255, 20, 20, 20),
                                        activeColor:
                                            Theme.of(context).primaryColor,
                                        onChanged: (bool? value) {
                                          if (value != null) {
                                            if (value) {
                                              tempSelectedCars.add(id);
                                            } else {
                                              tempSelectedCars.remove(id);
                                            }
                                          }
                                        },
                                      ),
                                      Flexible(
                                        child: Text(
                                          postController.carType[index],
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.w500,
                                              ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )),
        );
      }),
    );
  }
}
