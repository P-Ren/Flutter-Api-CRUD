import 'package:app_blog/app/data/models/req/login_required_model.dart';
import 'package:app_blog/app/routes/app_pages.dart';
import 'package:app_blog/app/servies/auth_service.dart';
import 'package:get/get.dart';

import '../../../providers/api_provider.dart';
import '../../../servies/local_storage_service.dart';

class LoginController extends GetxController {
  final _provider = Get.find<ApiProvider>();
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;

  void login(LoginReqModel req) async{
    try {
      isLoading(true);
      final response = await _provider.login(req);
      if(response.statusCode == 200){
        //Success
        final token = response.data['token'];
        final data = response.data['data'];
        LocalStorageService.write(token);
        final userId = data['id'];
        LocalStorageService.writeUid("${userId}");
        print("UserId :${AuthService.userID!.value}");
        Get.offAndToNamed(Routes.HOME);
        return;
      }
      throw Exception(response.data['message']);
    }catch(e){
      Get.defaultDialog(middleText: e.toString());
    }
    finally{
      isLoading(false);
    }
  }
  void loginWithGoogle() {
    // implementation
  }
}
