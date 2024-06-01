import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_status/core/constant/color.dart';
import 'package:time_status/view/profile/screens/My_Followers/controller/my_followers_controller.dart';

class FollowersScreen extends StatelessWidget {
  final FollowersController followersController =
      Get.put(FollowersController());

  @override
  Widget build(BuildContext context) {
    followersController.fetchFollowers();

    return Scaffold(
      appBar: AppBar(
        title: Text('My Followers'.tr),
        backgroundColor: AppColor.appgreen,
      ),
      body: Obx(() {
        if (followersController.followersList.isEmpty) {
          return Center(child: Text('No followers yet.'.tr));
        }

        return ListView.builder(
          itemCount: followersController.followersList.length,
          itemBuilder: (context, index) {
            final follower = followersController.followersList[index];
            return ListTile(
              title: Text(follower.username ?? 'Unknown'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.person_add),
                    onPressed: () =>
                        followersController.followUser(follower.id ?? ''),
                  ),
                  IconButton(
                    icon: Icon(Icons.person_remove),
                    onPressed: () =>
                        followersController.unfollowUser(follower.id ?? ''),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
