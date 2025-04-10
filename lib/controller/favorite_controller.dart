import 'package:get/get.dart';

import '../app_route.dart';
import '../core/class/status_request.dart';
import '../core/function/handiling_data.dart';
import '../model/post/posts_model.dart';
import '../model/post_saved/favorite_model.dart';
import '../model/post_saved/post_saved_data.dart';
import '../services/services.dart';

class FavoriteController extends GetxController {
  Rx<StatusRequest> statusRequest = StatusRequest.none.obs;
  final PostSavedData _postSavedData = PostSavedData(Get.find());
  MyServices myServices = Get.find();
  late RxList listOfPost = [].obs;
  late List imagesOut = [];
  late List imagesIn = [];
  RxList<int> favoritesList = <int>[].obs;

  FavoriteModel favoriteModel = Get.put(FavoriteModel());
  @override
  void onInit() {
    super.onInit();
    getAllFav();
  }

  refrshPage() async {
    listOfPost.clear();
    imagesIn.clear();
    imagesOut.clear();
    await getAllFav();
  }

  getAllFav() async {
    statusRequest.value = StatusRequest.loading;
    var response = await _postSavedData.getallpostdescription();
    statusRequest.value = handilingData(response);
    if (statusRequest.value == StatusRequest.succes) {
      if (response['status'] == "success") {
        var responsedata = response['data'];
        listOfPost.value = (responsedata as List)
            .map((json) => PostModel.fromJson(json))
            .toList();
        imagesOut = listOfPost.map((post) => post.imageOut).toList();
        imagesIn = listOfPost.map((post) => post.imageIn).toList();

        for (var post in listOfPost) {
          if (post.isSaved == 1) {
          }
        }

        favoritesList.clear();
        for (var post in listOfPost) {
          if (post.isSaved == 1) {
            favoritesList.add(post.id!);
          }
        }
      } else {
        Get.defaultDialog(
            title: "Error", middleText: "Passwoed or Email Not Found");
        statusRequest.value = StatusRequest.failure;
      }
    } else if (statusRequest.value == StatusRequest.unAuthorization) {
      Get.offAllNamed(AppRoutes.authenticationScreen);
      Get.snackbar('UnAuthorization', "انتهت صلاحية الجلسة");
    } else {
      Get.defaultDialog(title: "Server Error", middleText: "");
      statusRequest.value = StatusRequest.failure;
    }
  }
}
