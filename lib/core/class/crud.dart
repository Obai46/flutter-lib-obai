import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'status_request.dart';

class CRUD {
  Future<Either<StatusRequest, Map>> postdatalog(
      String linkUrl, Map data) async {
    try {
      var response = await http.post(Uri.parse(linkUrl), body: data);
      if (response.statusCode == 401) {
        return const Left(StatusRequest.unAuthorization);
      } else if (response.statusCode == 200 || response.statusCode == 201) {
        Map respnseBody = jsonDecode(response.body);
        String? token = response.headers['authorization'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (token != null) await prefs.setString('token', token);
        return Right(respnseBody);
      } else {
        return const Left(StatusRequest.serverFailure);
      }
    } catch (_) {
      return const Left(StatusRequest.offLineFailure);
    }
  }

  Future<Either<StatusRequest, Map>> postdata(
      String linkUrl, Map data, String token) async {
    try {
      var response = await http.post(
        Uri.parse(linkUrl),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          'authorization': token,
        },
      );
      if (response.statusCode == 401) {
        return const Left(StatusRequest.unAuthorization);
      } else if (response.statusCode == 200 || response.statusCode == 201) {
        Map respnseBody = jsonDecode(response.body);
        return Right(respnseBody);
      } else {
        return const Left(StatusRequest.serverFailure);
      }
    } catch (e) {
      e.printError();
      return const Left(StatusRequest.offLineFailure);
    }
  }

  Future<Either<StatusRequest, Map>> getData(
      String linkUrl, String token) async {
    try {
      var response = await http.get(
        Uri.parse(linkUrl),
        headers: {
          'authorization': token,
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 401) {
        return const Left(StatusRequest.unAuthorization);
      } else if (response.statusCode == 200 || response.statusCode == 201) {
        Map respnseBody = jsonDecode(response.body);
        return Right(respnseBody);
      } else {
        return const Left(StatusRequest.serverFailure);
      }
    } catch (_) {
      return const Left(StatusRequest.offLineFailure);
    }
  }

  Future<Either<StatusRequest, dynamic>> postRequestWithFile(
      String url, Map data, File file, String token) async {
    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));
      request.headers.addAll({
        'authorization': token,
        'Content-Type': 'multipart/form-data',
      });
      var length = await file.length();
      var stream = http.ByteStream(file.openRead());
      var multioartFile = http.MultipartFile("image", stream, length);

      request.files.add(multioartFile);
      data.forEach((key, value) {
        request.fields[key] = value;
      });

      var myRequest = await request.send();

      var response = await http.Response.fromStream(myRequest);
      if (response.statusCode == 401) {
        return const Left(StatusRequest.unAuthorization);
      } else if (myRequest.statusCode == 200 || myRequest.statusCode == 201) {
        Map respnseBody = jsonDecode(response.body);
        return Right(respnseBody);
      } else {
        return const Left(StatusRequest.failure);
      }
    } catch (e) {
      e.printError();
      return const Left(StatusRequest.offLineFailure);
    }
  }

  Future<Either<StatusRequest, dynamic>> postRequestWithMultiFiles(
      String url,
      Map<String, String> data,
      List<File> imageInFiles,
      List<File> imageOutFiles,
      String token) async {
    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));

      request.headers.addAll({
        'authorization': token,
        'Content-Type': 'multipart/form-data',
      });
      data.forEach((key, value) {
        request.fields[key] = value;
      });
      for (var file in imageInFiles) {
        var length = await file.length();
        var stream = http.ByteStream(file.openRead().cast());
        var multipartFile = http.MultipartFile('image_in[]', stream, length,
            filename: basename(file.path));
        request.files.add(multipartFile);
      }
      for (var file in imageOutFiles) {
        var length = await file.length();
        var stream = http.ByteStream(file.openRead().cast());
        var multipartFile = http.MultipartFile('image_out[]', stream, length,
            filename: file.path.split('/').last);
        request.files.add(multipartFile);
      }
      var myRequest = await request.send();
      var response = await http.Response.fromStream(myRequest);
      if (response.statusCode == 401) {
        return const Left(StatusRequest.unAuthorization);
      } else if (myRequest.statusCode == 200 || myRequest.statusCode == 201) {
        Map respnseBody = jsonDecode(response.body);
        return Right(respnseBody);
      } else {
        return const Left(StatusRequest.offLineFailure);
      }
    } catch (e) {
      e.printError();
      return const Left(StatusRequest.failure);
    }
  }

  Future<Either<StatusRequest, dynamic>> postRequestWithFileRegister(
      String url, Map data, File file, String token) async {
    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));
      request.headers.addAll({
                'authorization': token,
        'Content-Type': 'multipart/form-data',
      });

      var length = await file.length();
      var stream = http.ByteStream(file.openRead());
      var multioartFile = http.MultipartFile("image", stream, length,
          filename: basename(file.path));

      request.files.add(multioartFile);
      data.forEach((key, value) {
        request.fields[key] = value;
      });

      var myRequest = await request.send();
      var response = await http.Response.fromStream(myRequest);
      if (myRequest.statusCode == 200 || myRequest.statusCode == 201) {
        Map respnseBody = jsonDecode(response.body);

        return Right(respnseBody);
      } else {
        return const Left(StatusRequest.offLineFailure);
      }
    } catch (e) {
      return const Left(StatusRequest.failure);
    }
  }
}
