import 'dart:io';

import '../../../core/class/crud.dart';
import '../../../link_api.dart';

class RegisterData {
  late CRUD crud;
  RegisterData(this.crud);

  register({
    required String usersName,
    required String email,
    required String password,
    required String usersCity,
    required File usersImage,
  }) async {
    var response = await crud.postRequestWithFileRegister(
      AppLink.register,
      {
        'name': usersName,
        'email': email,
        'password': password,
        'city': usersCity,
      },
      usersImage,
      '',
    );
    return response.fold((l) => l, (r) => r);
  }
}
