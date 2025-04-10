import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_route.dart';
import '../../controller/settings_controller.dart';
import '../../core/constant/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Obx(
            () {
              SettingsController controller = Get.find<SettingsController>();
              return ListView(
                children: [
                  _SingleSection(
                    title: "General",
                    children: [
                      _CustomListTile(
                        title: "Dark Mode",
                        icon: Icons.dark_mode_outlined,
                        trailing: Switch(
                          value: controller.isDarkMode.value,
                          onChanged: (value) {
                            controller.toggleTheme();
                          },
                        ),
                      ),
                      const _CustomListTile(
                          title: "Notifications",
                          icon: Icons.notifications_none_rounded),
                    ],
                  ),
                  const Divider(),
                  _SingleSection(
                    title: "Organization",
                    children: [
                      _CustomListTile(
                        title: "Profile",
                        icon: Icons.person_outline_rounded,
                        onTap: () => Get.toNamed(AppRoutes.myProfile),
                      ),
                      _CustomListTile(
                        title: "Messaging",
                        icon: Icons.message_outlined,
                        onTap: () => Get.toNamed(AppRoutes.chat),
                      ),
                    ],
                  ),
                  const Divider(),
                  _SingleSection(
                    children: [
                      _CustomListTile(
                        title: "Sign out",
                        icon: Icons.exit_to_app_rounded,
                        onTap: () {
                          controller.logout();
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  final Function()? onTap;
  const _CustomListTile(
      {required this.title, required this.icon, this.trailing, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      leading: Icon(
        icon,
        size: 30,
        color: Get.isDarkMode ? AppColors.textWhite70 : AppColors.black,
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  const _SingleSection({
    this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title!,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        Column(
          children: children,
        ),
      ],
    );
  }
}
