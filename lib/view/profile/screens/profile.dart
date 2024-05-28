import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_status/core/app_export.dart';
import 'package:time_status/core/utils/spacing.dart';
import 'package:time_status/widget/loading.dart';
import '../../../widget/drawer.dart';
import 'controller/profile_controller.dart';
import 'widgets/options_section.dart';
import 'widgets/statastics.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());

  int postLen = 0;
  int followers = 0;
  int following = 0;

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 10),
                      child: const Text(
                        'I work hard',
                        style: TextStyle(
                            color: AppColor.appgreen,
                            fontSize: 18,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildStatesColumn(postLen, 'posts'),
                          buildStatesColumn(followers, 'followers'),
                          buildStatesColumn(following, 'following'),
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


