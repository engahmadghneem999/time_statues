import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:time_status/core/constant/color.dart';
import 'package:time_status/core/utils/image_constant.dart';
import 'package:time_status/view/chatting/screens/chats/chats_screen.dart';
import 'package:time_status/view/chatting/screens/chats_screen/chats_screen.dart';
import 'package:time_status/widget/bottom_nav_bar.dart';

import '../../../../core/utils/math_utils.dart';

class MainChat extends StatefulWidget {
  const MainChat({Key? key}) : super(key: key);

  @override
  State<MainChat> createState() => _MainChatState();
}

class _MainChatState extends State<MainChat> {
  int _currentIndex = 0; // Added to track the selected tab index

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      initialIndex: 0, // Initial selected tab index
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.appgreen,
          centerTitle: true,
          title: Text("Chatting"),
          bottom: TabBar(
            indicatorColor: AppColor.oranegapp,
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'chats',
                      style: TextStyle(
                        fontSize: 20,
                        color: _currentIndex == 0
                            ? AppColor.oranegapp // Active tab color
                            : Colors.white, // Inactive tab color
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.oranegapp,
                      ),
                      child: Center(child: Text('2')),
                    ),
                  ],
                ),
              ), // Replace with your tab titles
              Tab(
                child: Text(
                  'groups',
                  style: TextStyle(
                    fontSize: 20,
                    color: _currentIndex == 1
                        ? AppColor.oranegapp // Active tab color
                        : Colors.white, // Inactive tab color
                  ),
                ),
              ), // Replace with your tab titles
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index; // Update the current tab index
              });
            },
          ),
        ),
        body: TabBarView(
          children: [
            // Content for Tab 1
            Chats(),
            // Content for Tab 2
            ChatsScreen()
          ],
        ),
      //  bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 2),
      ),
    );
  }
}
