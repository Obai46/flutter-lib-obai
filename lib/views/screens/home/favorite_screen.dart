import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/favorite_controller.dart';
import '../../../core/class/handilind_data_view.dart';
import '../post/card_post.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FavoriteController controller = Get.put(FavoriteController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Saved',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Obx(
        () {
          return HandilingDatatView(
            statusRequest: controller.statusRequest.value,
            widget: RefreshIndicator(
              onRefresh: () async {
                await controller.getAllFav();
              },
              child: controller.listOfPost.isEmpty
                  ? SingleChildScrollView(
                      // هنا الإضافة لضمان عمل السحب في حال عدم وجود بيانات
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                          child: Text(
                            "No Data",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: controller.listOfPost.length,
                      itemBuilder: (context, index) {
                        controller.listOfPost[index];
                        return CardPost(
                          list: controller.listOfPost,
                          postModel: controller.listOfPost[index],
                          index: index,
                          postID: controller.listOfPost[index].id!,
                        );
                      },
                    ),
            ),
          );
        },
      ),
    );
  }
}
