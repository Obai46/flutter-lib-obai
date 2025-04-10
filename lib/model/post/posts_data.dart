import 'dart:io';

import '../../../core/class/crud.dart';
import '../../../link_api.dart';
import '../../core/function/get_functions.dart';

class PostsData {
  late CRUD crud;
  PostsData(this.crud);

  getallpostdescription({required String token}) async {
    var response = await crud.getData(AppLink.allPostWithDescriprtion, token);
    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> postAdd({
    required String postsTitle,
    required String postsUserID,
    required String name,
    required String model,
    required String engCapacity,
    required String disTravel,
    required String price,
    required String typeCar,
    required String fuelConsumption,
    required String driveSystem,
    required String numberSeats,
    required String cruiseControlSystem,
    required String carsID,
    required List<File> imageInFiles,
    required List<File> imageOutFiles,
    required String token,
  }) async {
    var response = await crud.postRequestWithMultiFiles(
        AppLink.postsAddWithDescription,
        {
          'title': postsTitle,
          'users_id': postsUserID,
          'name': name,
          'model': model,
          'eng_capacity': engCapacity,
          'dis_travel': disTravel,
          'price': price,
          'type_car': typeCar,
          'fuel_consumption': fuelConsumption,
          'drive_system': driveSystem,
          'number_Seats': numberSeats,
          'cruise_control_system': cruiseControlSystem,
          'cars_id': carsID,
        },
        imageInFiles,
        imageOutFiles,
        token);
    return response.fold((l) => l, (r) => r);
  }

  addToFavourite(String postsId) async {
    String token = getToken();
    var response = await crud.postdata(
        AppLink.postsSavedAdd,
        {
          'users_id': getID(),
          'posts_id': postsId,
        },
        token);
    return response.fold((l) => l, (r) => r);
  }

  deleteFromFavourite(String postsId) async {
    String token = getToken();
    var response = await crud.postdata(
        AppLink.postsSavedDelete,
        {
          'id': postsId,
        },
        token);
    return response.fold((l) => l, (r) => r);
  }

  deletePost(int postID) async {
    String token = getToken();
    var response = await crud.postdata(
        AppLink.postsDelete,
        {
          'id': postID,
        },
        token);
    return response.fold((l) => l, (r) => r);
  }

  getCars() async {
    String token = getToken();
    var response = await crud.getData(AppLink.carsAll, token);
    return response.fold((l) => l, (r) => r);
  }

  getPost(String postID) async {
    String token = getToken();
    var response = await crud.postdata(
        AppLink.postsOne,
        {
          'id': postID,
        },
        token);
    return response.fold((l) => l, (r) => r);
  }

  updatePost({
    required String postsTitle,
    required String postsID,
    required String name,
    required String model,
    required String engCapacity,
    required String disTravel,
    required String price,
    required String typeCar,
    required String fuelConsumption,
    required String driveSystem,
    required String numberSeats,
    required String cruiseControlSystem,
    required String carsID,
    required List<File> imageInFiles,
    required List<File> imageOutFiles,
    required String token,
  }) async {
    var response = await crud.postRequestWithMultiFiles(
        AppLink.postsUpdateWithDescription,
        {
          'id': postsID,
          'title': postsTitle,
          'name': name,
          'model': model,
          'eng_capacity': engCapacity,
          'dis_travel': disTravel,
          'price': price,
          'type_car': typeCar,
          'fuel_consumption': fuelConsumption,
          'drive_system': driveSystem,
          'number_Seats': numberSeats,
          'cruise_control_system': cruiseControlSystem,
          'cars_id': carsID,
        },
        imageInFiles,
        imageOutFiles,
        token);
    return response.fold((l) => l, (r) => r);
  }
}
