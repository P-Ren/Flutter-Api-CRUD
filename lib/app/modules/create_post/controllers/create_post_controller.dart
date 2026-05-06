import 'dart:io';
import 'package:app_blog/app/servies/auth_service.dart';
import 'package:app_blog/app/servies/local_storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../providers/api_provider.dart';

class CreatePostController extends GetxController {
  Rx<File> image = Rx<File>(File(''));
  var isLoading = false.obs;
  final _imagePicker = ImagePicker();
  final _provider = Get.find<ApiProvider>();


  void picImage() async {
    final _file = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (_file != null) {
      image.value = File(_file.path);
      // validateForm();
    }
  }
  void createPost({required String title, required String body}) async {
   final userID = await LocalStorageService.getUid();
    try {
      isLoading(true);
      final response = await _provider.createPost(
        title,
        body,
        image.value,
        int.parse(userID!),
      );
      if (response.statusCode == 200) {
        Get.back(result: true);
        return;
      }
      throw Exception(response.data['message']);
    } catch (e) {
      Get.defaultDialog(middleText: e.toString());
    } finally {
      isLoading(false);
    }
  }
}
