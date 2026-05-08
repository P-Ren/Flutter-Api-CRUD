import 'package:app_blog/app/components/textbutton_reusable.dart';
import 'package:app_blog/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/create_post_controller.dart';

class CreatePostView extends GetView<CreatePostController> {
  CreatePostView({super.key});

  final _formKey = GlobalKey<FormState>();
  final _titleCon = TextEditingController();
  final _bodyCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () => Get.find<HomeController>().changeTabIndex(0),
        ),
        title: Text(
          'Create Post',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey[200],
                    child: Icon(Icons.person, color: Colors.grey),
                  ),
                  SizedBox(width: 12),
                  Text(
                    "What's on your mind?",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 25),
              TextFormField(
                controller: _titleCon,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  hintText: "Add a title...",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              Divider(height: 1, color: Colors.black12),

              // 3. Body Input
              TextFormField(
                controller: _bodyCon,
                maxLines: 6,
                style: TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  hintText: "Write your content here...",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),

              SizedBox(height: 20),

              Obx(() {
                bool hasImage = controller.image.value.path.isNotEmpty;
                return GestureDetector(
                  onTap: () => controller.picImage(),
                  child: Container(
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: hasImage
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.file(
                              controller.image.value,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.orange.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.add_a_photo_outlined,
                                  color: Colors.orange,
                                  size: 32,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                "Add Cover Photo",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                  ),
                );
              }),

              SizedBox(height: 40),
              Obx(() {
                return TextbuttonReusable(
                  isLoading: controller.isLoading.value,
                  label: "Publish Post",
                  callback: () {
                    if (_formKey.currentState!.validate()) {
                      controller.createPost(
                        title: _titleCon.text,
                        body: _bodyCon.text,
                      );
                    }
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
