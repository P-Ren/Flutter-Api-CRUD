import 'package:app_blog/app/constants/app_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Soft background for contrast
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        title: const Text(
          'Feed',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false, // Professional apps usually left-align titles
        actions: [
          IconButton(
            onPressed: controller.toCreate,
            icon: const Icon(Icons.add_box_outlined, color: Colors.black),
          ),
          IconButton(
            onPressed: controller.logOut,
            icon: const Icon(Icons.logout_rounded, color: Colors.black),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isloading.value) {
          return const Center(child: CircularProgressIndicator(color: Colors.orange));
        }

        if (controller.post.value.data == null || controller.post.value.data!.isEmpty) {
          return const Center(child: Text("No posts yet"));
        }

        return ListView.separated(
          padding: const EdgeInsets.only(top: 8),
          itemCount: controller.post.value.data!.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final post = controller.post.value.data![index];
            return _buildPostCard(post);
          },
        );
      }),
    );
  }

  Widget _buildPostCard(dynamic post) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header: User Info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.orange.shade100,
                  // Using name initial if image fails
                  child: Text(
                    post.user?.name?[0] ?? "?",
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "${post.user!.name}",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                const Icon(Icons.more_horiz),
              ],
            ),
          ),

          // 2. Main Post Image
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 200, maxHeight: 500),
            color: Colors.grey[200],
            child: Image.network(
              "$kBaseUrl/storage/${post.imageUrl}",
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
              const Center(child: Icon(Icons.broken_image_outlined, size: 50, color: Colors.grey)),
            ),
          ),

          // 3. Action Bar (Like, Comment, Save)
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                const Icon(Icons.favorite_border, size: 28),
                const SizedBox(width: 16),
                const Icon(Icons.chat_bubble_outline, size: 26),
                const SizedBox(width: 16),
                const Icon(Icons.send_outlined, size: 26),
                const Spacer(),
                const Icon(Icons.bookmark_border, size: 28),
              ],
            ),
          ),

          // 4. Caption / Body Text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black, fontSize: 14),
                children: [
                  TextSpan(
                    text: "${post.user!.name} ",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: "${post.body}"),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}