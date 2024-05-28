import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/groups_controller.dart';

class InGroupChatScreen extends StatelessWidget {
  final int chatId;
  final GroupChatController groupChatController =
      Get.put(GroupChatController());

  InGroupChatScreen({Key? key, required this.chatId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Chat $chatId'),
        actions: [
          ElevatedButton(
              onPressed: () {
                groupChatController.joinGroup(chatId);
              },
              child: Text('Join')),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text('Group Chat Screen for ID: $chatId'),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
