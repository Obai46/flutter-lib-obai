import 'package:get/get.dart';

import '../../../core/class/crud.dart';
import '../../../core/function/get_functions.dart';
import '../../../link_api.dart';
import '../../../services/services.dart';

class RoomData {
  RoomData(this.crud);
  CRUD crud;
  MyServices myServices = Get.find();
  viewChatList({required String id}) async {
    String token = getToken();
    var response = await crud.postdata(AppLink.roomAll, {'id': id}, token);
    return response.fold((l) => l, (r) => r);
  }
}
