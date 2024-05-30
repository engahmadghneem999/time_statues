import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_status/core/constant/color.dart';
import 'package:time_status/view/chatting/one_to_one_chat/controller/send_message_controller.dart';
import 'package:time_status/view/chatting/one_to_one_chat/views/one_to_one_chatting_screen/controller/in_one_to_one_contoller.dart';
import 'package:intl/intl.dart';

class InChatScreen extends StatelessWidget {
  final String userId;
  final String userName;

  InChatScreen({required this.userId, required this.userName});

  final InOneToOneChatController chatController =
      Get.put(InOneToOneChatController());
  final SendMessageController sendMessageController =
      Get.put(SendMessageController());

  @override
  Widget build(BuildContext context) {
    chatController.fetchDetailChats(userId);

    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
        backgroundColor: AppColor.appbargreen,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (chatController.isLoading.value) {
                return Container();
              } else if (chatController.chatMessages.isEmpty) {
                return Center(child: Text('No messages'));
              } else {
                return ListView.builder(
                  reverse:
                      true, // Reverse the ListView to show latest messages at the bottom
                  itemCount: chatController.chatMessages.length,
                  itemBuilder: (context, index) {
                    final message = chatController.chatMessages[index];
                    final isMe = message.sender == userId;

                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: isMe
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: isMe
                                  ? AppColor.appColor
                                  : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  message.text ?? '',
                                  style: TextStyle(
                                      color:
                                          isMe ? Colors.white : Colors.black),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  DateFormat.Hm().format(
                                      message.dateTime ?? DateTime.now()),
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.image, color: AppColor.appbargreen),
                  onPressed: () {
                    sendMessageController.selectImage();
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: sendMessageController.textController,
                    decoration: InputDecoration(
                      hintText: 'Type a message'.tr,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: AppColor.appbargreen),
                  onPressed: () {
                    sendMessageController
                        .sendMessage(receiver: userId)
                        .then((_) {
                      chatController.fetchDetailChats(
                          userId); // Fetch messages after sending
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
