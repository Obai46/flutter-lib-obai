import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/home_cotroller/home_navigation_controller.dart';
import 'custom_button_appbar.dart';

class CustomBottmAppBarHome extends StatelessWidget {
  const CustomBottmAppBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<HomeNavigationController>(builder: (controller) {
      return BottomAppBar(
        color: Theme.of(context).primaryColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Row(
          children: [
            ...List.generate(
              controller.listPages.length + 1,
              ((index) {
                int i = index > 2 ? index - 1 : index;
                return index == 2
                    ? const Spacer()
                    : CustomButtonAppBar(
                        textButton: controller.listBottomAppBar[i]['title'],
                        iconButton: controller.listBottomAppBar[i]['icon'],
                        onPressed: () {
                          controller.onChanged(i);
                        },
                        active: controller.selectedIndex.value == i
                            ? true.obs
                            : false.obs,
                      );
              }),
            ),
          ],
        ),
      );
    });
  }
}
