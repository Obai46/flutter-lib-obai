import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../views/screens/post/add/add_post_screen.dart';
import '../../views/screens/home/home_screen.dart';
import '../profile/my_profile_controller.dart';
import '../../views/screens/profile/my_profile_screen.dart';
import '../../views/screens/settings_page.dart';
import '../post_controller/post_controller.dart';

class HomeNavigationController extends GetxController {
  var selectedIndex = 0.obs;
  // قائمة الشاشات
  final List<Widget> listPages = [
    const HomeScreen(),
    const AddImagesPage(),
    const MyProfileScreen(),
    const SettingsScreen(),
  ].obs;

  List listBottomAppBar = [
    {'title': 'Home', 'icon': Icons.home},
    {'title': 'Add Post', 'icon': Icons.add_box},
    {'title': 'Profile', 'icon': Icons.person},
    {'title': 'Settings', 'icon': Icons.settings},
  ].obs;

  void onChanged(int index) {
    if (selectedIndex.value == 1) {
      Get.find<PostController>().clearData();
    }
    if (selectedIndex.value == 2) {
      Get.find<MyProfileController>().onClose();
      Get.find<MyProfileController>().onInit();
    }
    selectedIndex.value = index;
  }
}
