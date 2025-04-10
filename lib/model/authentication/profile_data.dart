import 'dart:io';

import '../../../core/class/crud.dart';
import '../../../link_api.dart';
import '../../core/function/get_functions.dart';

class ProfileData {
  CRUD crud;

  ProfileData(this.crud);

  showMyProfile() async {
    String token = getToken();
    var response = await crud.postdata(AppLink.myProfile, {}, token);
    return response.fold((l) => l, (r) => r);
  }

  showUserProfile(int id) async {
    String token = getToken();
    var response = await crud.postdata(
        AppLink.userProfile,
        {
          'id': id,
        },
        token);
    return response.fold((l) => l, (r) => r);
  }

  showUserInformations() async {
    String token = getToken();
    var response = await crud.getData(AppLink.userInformations, token);
    return response.fold((l) => l, (r) => r);
  }

  updateName(String name) async {
    String token = getToken();
    var response = await crud.postdata(
        AppLink.updateName,
        {
          'name': name,
        },
        token);
    return response.fold((l) => l, (r) => r);
  }

  updateCity({required String city}) async {
    String token = getToken();
    var response = await crud.postdata(
        AppLink.updateCity,
        {
          'city': city,
        },
        token);
    return response.fold((l) => l, (r) => r);
  }

  updatepassword({required String password}) async {
    String token = getToken();
    var response = await crud.postdata(
        AppLink.updatePassword,
        {
          'password': password,
        },
        token);
    return response.fold((l) => l, (r) => r);
  }

  updateImage({required File usersImage}) async {
    String token = getToken();
    var response = await crud.postRequestWithFileRegister(
        AppLink.updateImage, {}, usersImage, token);
    return response.fold((l) => l, (r) => r);
  }

  validatePassword(String password) async {
    String token = getToken();
    var response = await crud.postdata(
        AppLink.validatePassword,
        {
          'password': password,
        },
        token);
    return response.fold((l) => l, (r) => r);
  }
}
