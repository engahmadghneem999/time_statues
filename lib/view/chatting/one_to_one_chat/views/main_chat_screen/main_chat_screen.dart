import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_status/core/constant/color.dart';
import 'package:time_status/view/chatting/one_to_one_chat/controller/chat_controller.dart';
import 'package:time_status/view/chatting/one_to_one_chat/views/one_to_one_chatting_screen/one_to_one_chat.dart';
import '../../../groups chat/screens/groups_screen.dart';
import '../one_to_one_chatting_screen/controller/one_to_one_main_screen_controller.dart';

class MainChat extends StatefulWidget {
  const MainChat({Key? key}) : super(key: key);

  @override
  State<MainChat> createState() => _MainChatState();
}

class _MainChatState extends State<MainChat> {
  int _currentIndex = 0; // Added to track the selected tab index
  final OneToOneChatMainScreenController otochatController =
      Get.put(OneToOneChatMainScreenController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      initialIndex: 0, // Initial selected tab index
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.appgreen,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text("Chatting"),
          bottom: TabBar(
            indicatorColor: AppColor.oranegapp,
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Chats',
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
                      child: Center(
                          child: Text(
                              otochatController.chatMessages.length.toString())),
                    ),
                  ],
                ),
              ),
              Tab(
                child: Text(
                  'Groups',
                  style: TextStyle(
                    fontSize: 20,
                    color:
                        _currentIndex == 1 ? AppColor.oranegapp : Colors.white,
                  ),
                ),
              ),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        body: TabBarView(
          children: [OneToOneChats(), GroupChatsScreen()],
        ),
      ),
    );
  }
}
