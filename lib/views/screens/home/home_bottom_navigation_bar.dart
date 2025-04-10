import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/home_cotroller/home_navigation_controller.dart';
import 'widget/custom_bottm_app_bar_home.dart';
import 'widget/custom_floating_action_button.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  const HomeBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeNavigationController());
    return GetX<HomeNavigationController>(
      builder: (controller) {
        return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            floatingActionButton: const CustomFloatingActionButton(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: const CustomBottmAppBarHome(),
            body:
                controller.listPages.elementAt(controller.selectedIndex.value));
      },
    );
  }
}
