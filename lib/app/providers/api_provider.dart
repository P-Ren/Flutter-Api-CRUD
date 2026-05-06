import "dart:io";

import "package:app_blog/app/constants/app_config.dart";
import "package:app_blog/app/data/models/req/login_required_model.dart";
import "package:app_blog/app/data/models/req/register_req_model.dart";
import "package:app_blog/app/servies/auth_service.dart";
import "package:app_blog/app/servies/local_storage_service.dart";
import "package:dio/dio.dart";
import "package:flutter/cupertino.dart";
import "package:get/get.dart" hide Response, FormData, MultipartFile;

import "../../flavors.dart";

class ApiProvider extends GetxService {
  late Dio _dio;

  @override
  void onInit() {
    // TODO: implement onInit
    _initializeDio();
    super.onInit();
  }

  void _initializeDio() {
    debugPrint("${F.baseUrl}");
    _dio = Dio(
      BaseOptions(
        baseUrl: "${F.baseUrl}/api",
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      ),
    );
  }

  Future<Response<dynamic>> login(LoginReqModel req) async {
    return await _dio.post(
      '/login?token=123',
      data: req.toJson(),
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      ),
    );
  }

  Future<Response<dynamic>> logout(String token) async {
    return await _dio.post(
      '/logout',
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer ${token}",
        },
      ),
    );
  }

  Future<Response<dynamic>> register(RegisterModel req) async {
    return await _dio.post('/register', data: req.toJson());
  }

  Future<Response<dynamic>> createPost(
    String title,
    String body,
    File image,
    int userID,
  ) async {
    final _formdata = FormData.fromMap({
      'user_id': userID,
      'title': title,
      'body': body,
      'imageUrl': await MultipartFile.fromFile(image.path),
    });
    return await _dio.post('/posts', data: _formdata);
  }

  Future<Response<dynamic>> getPost() async {
    final token = await LocalStorageService.getToken();
    return await _dio.get(
      '/posts',
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer ${token}",
        },
      ),
    );
  }
}
