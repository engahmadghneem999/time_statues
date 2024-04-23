import 'package:flutter/material.dart';
import 'package:time_status/core/app_export.dart';

import '../../../widget/drawer.dart';

class ProfileScreen extends StatelessWidget {

  int postLen = 0;

  int followers = 0;

  int following = 0;

  bool isLoading = false;

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
      endDrawer:  MyDrawer(),
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
                        backgroundImage:
                            AssetImage('assets/images/profile.jpeg'),
                        radius: 70,
                      ),

//********** username
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(
                          top: 15,
                        ),
                        child: const Text(
                          'alhasan alabdli',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

//************ the details

                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(
                          top: 10,
                        ),
                        child: const Text(
                          'I work hard',
                          style: TextStyle(
                              color: AppColor.appgreen,
                              fontSize: 18,
                              fontWeight: FontWeight.normal),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      //**********cont
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildStatColumn(postLen, 'posts'),
                            buildStatColumn(followers, 'followers'),
                            buildStatColumn(following, 'following'),
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
                //******************* add here buttons todo

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
//    ********** button signout and button unfollow
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 70,
                              child: Row(
                                children: [
                                  Container(
                                    width: 150,
                                    height: 35,
                                    decoration: const ShapeDecoration(
                                      gradient: LinearGradient(colors: [
                                        AppColor.appgreen,
                                        Colors.white
                                      ]),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                    ),
                                    child: TextButton(
                                      onPressed: () async {},
                                      child: const Text(
                                        'logout',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Container(
                                    height: 35,
                                    decoration: const ShapeDecoration(
                                      gradient: LinearGradient(colors: [
                                        AppColor.appgreen,
                                        Colors.white
                                      ]),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                    ),
                                    child: TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        'Edit Profile',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

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
          );
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
