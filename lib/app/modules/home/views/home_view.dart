import 'package:app_blog/app/constants/app_config.dart';
import 'package:app_blog/app/modules/create_post/views/create_post_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],

      body: Obx(() {
        switch (controller.currentIndex.value) {
          case 0:
            return _buildHomeFeed();
          case 1:
            return Center(child: Text("friend"));
          case 2:
            return CreatePostView();
          case 3:
            return Center(child: Text("Watch View"));
          case 4:
            return Center(child: Text("Profile View"));
          default:
            return SizedBox();
        }
      }),

      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.grey.shade200, width: 1),
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: (index) => controller.changeTabIndex(index),
            elevation: 0, //
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.black45,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.group),
                activeIcon: Icon(Icons.group),
                label: 'friend',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_box_outlined),
                activeIcon: Icon(Icons.add_box_outlined),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.play_circle_outline_rounded),
                activeIcon: Icon(Icons.play_circle_filled_rounded),
                label: 'Watch',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_rounded),
                activeIcon: Icon(Icons.person_rounded),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHomeFeed() {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Feed',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: controller.toCreate,
            icon: const Icon(Icons.add_box_outlined, color: Colors.black),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications, color: Colors.black),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: Colors.black),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.chat_outlined, color: Colors.black),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isloading.value) {
          return Center(child: CircularProgressIndicator(color: Colors.orange));
        }
        if (controller.post.value.data == null ||
            controller.post.value.data!.isEmpty) {
          return Center(child: Text("No posts yet"));
        }
        return ListView.separated(
          padding: EdgeInsets.only(top: 8),
          itemCount: controller.post.value.data!.length,
          separatorBuilder: (context, index) => SizedBox(height: 10),
          itemBuilder: (context, index) =>
              _buildPostCard(controller.post.value.data![index]),
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
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.orange.shade100,
                  // Using name initial if image fails
                  child: Text(
                    post.user?.name?[0] ?? "?",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "${post.user!.name}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Icon(Icons.more_horiz),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            constraints: BoxConstraints(minHeight: 200, maxHeight: 500),
            color: Colors.grey[200],
            child: Image.network(
              "$kBaseUrl/storage/${post.imageUrl}",
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Center(
                child: Icon(
                  Icons.broken_image_outlined,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Row(
              children: [
                Icon(Icons.favorite_border, size: 28),
                SizedBox(width: 16),
                Icon(Icons.chat_bubble_outline, size: 26),
                SizedBox(width: 16),
                Icon(Icons.send_outlined, size: 26),
                Spacer(),
                Icon(Icons.bookmark_border, size: 28),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 14),
                children: [
                  TextSpan(
                    text: "${post.user!.name} ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: "${post.body}"),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
