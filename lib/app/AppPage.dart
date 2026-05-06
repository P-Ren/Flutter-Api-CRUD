import 'package:app_blog/app/modules/home/controllers/home_controller.dart';
import 'package:app_blog/app/modules/home/views/home_view.dart';
import 'package:app_blog/app/modules/login/views/login_view.dart';
import 'package:app_blog/app/servies/auth_service.dart';
import 'package:app_blog/pages/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});

  @override
  Widget build(BuildContext context) {
    DependencyInjection.init();
    return Obx((){
      if(AuthService.isAuthenticated.value){
        Get.put(HomeController());
        return HomeView();
      }
      return LoginView();
    });
  }
}
