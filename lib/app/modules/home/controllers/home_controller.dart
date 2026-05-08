import 'package:app_blog/app/data/models/res/post_model.dart';
import 'package:app_blog/app/providers/api_provider.dart';
import 'package:app_blog/app/servies/auth_service.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
class HomeController extends GetxController {
  final _provider = Get.find<ApiProvider>();
  Rx<PostModel> post =  Rx<PostModel>(PostModel());
  var isloading = false.obs;
  var currentIndex = 0.obs;

  @override
  void onInit() {
    getPost();
    super.onInit();
  }

  void logOut()async{
    try{
      isloading(true);
     AuthService.auth.logout();
      Get.offAllNamed('/login');
    }catch(e){
      Get.defaultDialog(middleText: e.toString());
    }
    finally{
      isloading(false);
    }
  }
  void toCreate()async{
    final result = await Get.toNamed(Routes.CREATE_POST);
    if(result!=null){

    }
  }
  void getPost()async{
    try{
      isloading(true);
      final res = await _provider.getPost();
      if(res.statusCode ==  200){
        final data = res.data;
        post.value = PostModel.fromJson(data);
        return;
      }
      throw Exception(res.data['']);
    }catch(e){
      Get.snackbar("message", e.toString());
    }
    finally{
      isloading(false);
    }
  }
  void changeTabIndex(int index) {
    currentIndex.value = index;
  }

}
