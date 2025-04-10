import '../../../core/class/crud.dart';
import '../../../link_api.dart';
import '../../core/function/get_functions.dart';

class LoginData {
  CRUD crud;

  LoginData(this.crud);

  login({required String password, required String email}) async {
    var response = await crud.postdatalog(AppLink.login, {
      "email": email,
      "password": password,
    });
    return response.fold((l) => l, (r) => r);
  }

  logout() async {
    String token = getToken();
    var response = await crud.postdata(AppLink.logout, {}, token);
    return response.fold((l) => l, (r) => r);
  }
}
