import '../../core/class/crud.dart';
import '../../core/function/get_functions.dart';
import '../../link_api.dart';

class PostSavedData {
  late CRUD crud;
  PostSavedData(this.crud);
  getallpostdescription() async {
    String token = getToken();
    var response = await crud.getData(AppLink.postsSavedAll, token);
    return response.fold((l) => l, (r) => r);
  }
}
