

import 'package:app_blog/app/providers/api_provider.dart';
import 'package:app_blog/app/routes/app_pages.dart';
import 'package:app_blog/app/servies/local_storage_service.dart';
import 'package:get/get.dart';

class AuthService extends GetxService{
  static RxBool isAuthenticated = false.obs;
  static AuthService auth = Get.find<AuthService>();
  static RxString authToken = RxString('');
  static RxString? userID = RxString('');
  final ApiProvider _provider = Get.find<ApiProvider>();
  @override
  void onInit() {
    _checkAuth();
    super.onInit();
  }
  void _checkAuth()async{
    final token =await LocalStorageService.getToken();
    if(token != null || token!.isNotEmpty){
      isAuthenticated(true);
      authToken(token);
    }
  }
  void logout()async{
    try{
      final res = await _provider.logout(authToken.value);
      if(res.statusCode==200){
        LocalStorageService.remove('token');
        Get.offAndToNamed(Routes.LOGIN);
        return;
      }
      throw Exception(res.data['massage']);
    }catch(e){
      Get.snackbar("massage",e.toString());
    }
  }
}