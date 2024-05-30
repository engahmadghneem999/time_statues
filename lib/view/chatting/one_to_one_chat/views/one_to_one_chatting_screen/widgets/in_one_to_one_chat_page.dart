import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_status/core/constant/color.dart';
import 'package:time_status/view/chatting/one_to_one_chat/views/one_to_one_chatting_screen/controller/in_one_to_one_contoller.dart';
import 'package:intl/intl.dart';

class InChatScreen extends StatelessWidget {
  final String userId;
  final String userName;

  InChatScreen({required this.userId, required this.userName});

  final InOneToOneChatController controller =
      Get.put(InOneToOneChatController());

  @override
  Widget build(BuildContext context) {
    // Fetch chat details when the screen is first built
    controller.fetchDetailChats(userId);

    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColor.appColor,
            ),
          );
        } else if (controller.chatMessages.isEmpty) {
          return Center(child: Text('No messages'));
        } else {
          return ListView.builder(
            itemCount: controller.chatMessages.length,
            itemBuilder: (context, index) {
              final message = controller.chatMessages[index];
              final isMe = message.sender == userId;

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment:
                      isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: isMe ? Colors.blue : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message.text ?? '',
                            style: TextStyle(
                                color: isMe ? Colors.white : Colors.black),
                          ),
                          SizedBox(height: 4),
                          Text(
                            DateFormat.Hm()
                                .format(message.dateTime ?? DateTime.now()),
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      }),
    );
  }
}
