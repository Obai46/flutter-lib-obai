import 'package:get/get.dart';

import '../../services/services.dart';

Future<void> saveToken(String token) async {
  MyServices services = Get.find();
  await services.sharedPreferences.setString('token', token);
}

getToken() {
  MyServices services = Get.find();
  return services.sharedPreferences.getString('token');
}

getID() {
  MyServices myServices = Get.find();
  return myServices.sharedPreferences.getString('id');
}


