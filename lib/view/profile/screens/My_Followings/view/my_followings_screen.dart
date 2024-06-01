import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:time_status/core/constant/color.dart';
import 'package:time_status/view/profile/screens/My_Followings/controller/my_followings_controller.dart';

class FollowingsScreen extends StatelessWidget {
  final MyFollowingsController followingsController =
      Get.put(MyFollowingsController());

  @override
  Widget build(BuildContext context) {
    followingsController.fetchFollowings();

    return Scaffold(
      appBar: AppBar(
        title: Text('My Followings'.tr),
        backgroundColor: AppColor.appgreen,
      ),
      body: Obx(() {
        if (followingsController.followingsList.isEmpty) {
          return Center(child: Text('No followings yet.'.tr));
        }

        return ListView.builder(
          itemCount: followingsController.followingsList.length,
          itemBuilder: (context, index) {
            final following = followingsController.followingsList[index];
            return ListTile(
              title: Text(following.username ?? 'Unknown'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.person_add),
                    onPressed: () =>
                        followingsController.followUser(following.id ?? ''),
                  ),
                  IconButton(
                    icon: Row(
                      children: [
                        Icon(Icons.person_remove),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text('Unfollow'.tr),
                      ],
                    ),
                    onPressed: () =>
                        followingsController.unfollowUser(following.id ?? ''),
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
