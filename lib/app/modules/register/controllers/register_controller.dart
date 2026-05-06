import 'package:app_blog/app/data/models/req/register_req_model.dart';
import 'package:app_blog/app/providers/api_provider.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
 final _provider = Get.find<ApiProvider>();
 var isLoading = false.obs;

 void register(RegisterModel req) async{
   try {
     final response = await _provider.register(req);
     if(response.statusCode == 200){
       //Success
       Get.back(result: true);
       return;
     }
     throw Exception(response.data['message']);
   }catch(e){
     Get.defaultDialog(middleText: e.toString());
   }
 }
}
