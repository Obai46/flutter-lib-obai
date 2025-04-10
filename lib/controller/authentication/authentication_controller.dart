import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/services.dart';

class AuthenticationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> opacityAnimation;
  final MyServices myServices = Get.find();

  @override
  void onInit() {
    super.onInit();
    myServices.sharedPreferences.setString("step", "1");
    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeIn),
    );
    animationController.forward();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
