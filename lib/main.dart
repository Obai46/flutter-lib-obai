import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'app_route.dart';
import 'binding/initial_binding.dart';
import 'controller/settings_controller.dart';
import 'services/services.dart';
import 'theme/app_theme.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  Get.put(SettingsController());
  Get.put(MyServices());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = Get.find();

    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat CFY',
        themeMode: settingsController.isDarkMode.value
            ? ThemeMode.dark
            : ThemeMode.light,
        theme: AppTheme.customLightTheme,
        darkTheme: AppTheme.customDarkTheme,
        getPages: AppRoutes.routes,
        initialBinding: InitialBinding(),
      ),
    );
  }
}
