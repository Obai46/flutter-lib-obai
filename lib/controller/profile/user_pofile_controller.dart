import 'package:get/get.dart';

import '../../app_route.dart';
import '../../core/class/status_request.dart';
import '../../core/function/handiling_data.dart';
import '../../model/authentication/profile_data.dart';
import '../../model/authentication/user_model.dart';
import '../../model/post/posts_model.dart';
import '../../services/services.dart';

class UserPofileController extends GetxController {
  final ProfileData _profileData = ProfileData(Get.find());
  Rx<StatusRequest> statusRequest = StatusRequest.none.obs;
  MyServices myServices = Get.find();
  late List imagesOut = [];
  late List imagesIn = [];
  RxList<int> favoritesList = <int>[].obs;
  late RxList listOfPost = [].obs;
  late UserModel user = Get.put(UserModel());
  late int id;

  @override
  onInit() {
    id = Get.arguments['id'];
    showProfile(id);
    super.onInit();
  }

  showProfile(int id) async {
    statusRequest.value = StatusRequest.loading;
    var response = await _profileData.showUserProfile(id);
    statusRequest.value = handilingData(response);
    if (statusRequest.value == StatusRequest.succes) {
      if (response['status'] == "success") {
        var responsedata = response['data'];
        listOfPost.value = (responsedata as List)
            .map((json) => PostModel.fromJson(json))
            .toList();

        var users = response['data'][0]['user'];
        user = UserModel.fromJson(users);
        imagesOut = listOfPost.map((post) => post.imageOut).toList();
        imagesIn = listOfPost.map((post) => post.imageIn).toList();
        favoritesList.clear();
        for (var post in listOfPost) {
          if (post.isSaved == 1) {
            favoritesList.add(post.id!);
          }
        }
        // Get.toNamed(AppRoutes.myProfile);
        // update();
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
