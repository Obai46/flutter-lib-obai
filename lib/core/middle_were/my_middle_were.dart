import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../app_route.dart';
import '../../services/services.dart';

class MyMiddleWere extends GetMiddleware {
  @override
  int? get priority => 1;

  MyServices myServices = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    if (myServices.sharedPreferences.getString("step") == "2") {
      return const RouteSettings(name: AppRoutes.home);
    }
    if (myServices.sharedPreferences.getString("step") == "1") {
      return const RouteSettings(name: AppRoutes.authenticationScreen);
    }
    return const RouteSettings(name: AppRoutes.authenticationScreen);
  }
}
