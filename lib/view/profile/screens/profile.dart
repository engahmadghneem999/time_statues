import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_status/core/app_export.dart';
import 'package:time_status/core/utils/spacing.dart';
import 'package:time_status/view/profile/screens/My_Followers/view/my_followers_screen.dart';
import 'package:time_status/view/profile/screens/My_Followings/view/my_followings_screen.dart';
import 'package:time_status/view/profile/screens/widgets/options_section.dart';
import 'package:time_status/view/profile/screens/widgets/statastics.dart';
import 'package:time_status/widget/loading.dart';
import '../../../widget/drawer.dart';
import 'controller/profile_controller.dart';
import 'My_Followings/controller/my_followings_controller.dart'; // Adjust the import path as needed

class ProfileScreen extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());
  final MyFollowingsController followingsController =
      Get.put(MyFollowingsController());

  int postLen = 0;

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    followingsController.fetchFollowings(); // Fetch followings on screen load
    profileController
        .fetchFollowersCount(); // Fetch followers count on screen load

    return Obx(() {
      return LoadingManager(
        isLoading: profileController.isLoading.value,
        child: Scaffold(
          endDrawer: const MyDrawer(),
          backgroundColor: const Color(0xFFe0f2f1),
          appBar: AppBar(
            toolbarHeight: 60,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            backgroundColor: AppColor.appgreen,
            title: const Text(
              'Profile',
              style: TextStyle(fontSize: 20),
            ),
            centerTitle: true,
          ),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/profile.jpeg'),
                      radius: 70,
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 15),
                      child: Obx(() {
                        return Text(
                          profileController.username.value,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                              child: buildStatesColumn(postLen, 'posts')),
                          GestureDetector(
                              onTap: () => Get.to(FollowersScreen()),
                              child: Obx(() {
                                return buildStatesColumn(
                                    profileController.followersCount.value,
                                    'followers');
                              })),
                          GestureDetector(
                              onTap: () => Get.to(FollowingsScreen()),
                              child: Obx(() {
                                return buildStatesColumn(
                                    followingsController.followingsCount,
                                    'following');
                              })),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(
                  height: 1.0,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                child: Container(
                  decoration: const ShapeDecoration(
                    gradient: LinearGradient(
                        colors: [AppColor.grayColor, AppColor.appgreen]),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  child: Column(
                    children: [
                      OptionsSection(),
                    ],
                  ),
                ),
              ),
              verticalSpace(10),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'posts',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
