
import 'package:app_blog/app/modules/login/controllers/login_controller.dart';
import 'package:app_blog/app/providers/api_provider.dart';
import 'package:get/get.dart';

import '../app/servies/auth_service.dart';
import '../app/servies/local_storage_service.dart';

class DependencyInjection {
  static void init(){
    Get.put(ApiProvider());
    Get.put(LocalStorageService());
    Get.put(LoginController());
    Get.put(AuthService(),permanent: true);
  }
}