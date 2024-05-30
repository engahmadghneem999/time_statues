import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_status/core/constant/color.dart';
import 'package:time_status/view/chatting/one_to_one_chat/controller/send_message_controller.dart';
import 'package:time_status/view/chatting/one_to_one_chat/views/in_one_to_one_chat/controller/get_fav_controler.dart';
import 'package:time_status/view/chatting/one_to_one_chat/views/in_one_to_one_chat/controller/get_pin_controller.dart';
import 'package:time_status/view/chatting/one_to_one_chat/views/one_to_one_chatting_screen/controller/in_one_to_one_contoller.dart';
import 'package:time_status/view/chatting/one_to_one_chat/views/in_one_to_one_chat/controller/favorite_message_controller.dart';
import 'package:intl/intl.dart';
import 'package:time_status/view/chatting/one_to_one_chat/views/one_to_one_chatting_screen/widgets/favorite_messages.dart';

class InChatScreen extends StatelessWidget {
  final String userId;
  final String userName;

  InChatScreen({required this.userId, required this.userName});

  final InOneToOneChatController chatController =
      Get.put(InOneToOneChatController());
  final SendMessageController sendMessageController =
      Get.put(SendMessageController());
  final GetPinMessageController getPinMessageController =
      Get.put(GetPinMessageController());
  final PostFavoriteMessageController favoriteMessageController =
      Get.put(PostFavoriteMessageController());

  @override
  Widget build(BuildContext context) {
    chatController.fetchDetailChats(userId);
    getPinMessageController.fetchPinnedMessages(userId);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              Get.to(FavoriteMessageScreen(userId: userId));
            },
          ),
        ],
        title: Text(userName),
        backgroundColor: AppColor.appbargreen,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            if (getPinMessageController.pinnedMessages.isEmpty) {
              return Container();
            } else {
              return Container(
                color: Colors.grey[200],
                child: Column(
                  children: [
                    SizedBox(width: 10),
                    Row(
                      children: [
                        Text(
                          'Pinned messages :',
                          style: TextStyle(fontSize: 15),
                        ),
                        Container(
                          height: 30,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount:
                                getPinMessageController.pinnedMessages.length,
                            itemBuilder: (context, index) {
                              final pinnedMessage =
                                  getPinMessageController.pinnedMessages[index];
                              return Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    pinnedMessage.text,
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: AppColor.appbargreen,
                    )
                  ],
                ),
              );
            }
          }),
          Expanded(
            child: Obx(() {
              if (chatController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (chatController.chatMessages.isEmpty) {
                return Center(child: Text('No messages'));
              } else {
                return ListView.builder(
                  reverse: true,
                  itemCount: chatController.chatMessages.length,
                  itemBuilder: (context, index) {
                    final message = chatController.chatMessages[index];
                    final isMe = message.sender == userId;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Align(
                        alignment:
                            isMe ? Alignment.centerLeft : Alignment.centerRight,
                        child: GestureDetector(
                          onLongPress: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Wrap(
                                  children: [
                                    ListTile(
                                      leading: Icon(Icons.favorite),
                                      title: Text('Add to favorites'),
                                      onTap: () {
                                        favoriteMessageController
                                            .favoriteMessage(
                                                message.id.toString());
                                        Navigator.pop(context);
                                      },
                                    ),
                                    // Add more options here if needed
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            constraints: BoxConstraints(maxWidth: 250),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: isMe ? Colors.blue : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  message.text ?? '',
                                  style: TextStyle(
                                    color: isMe ? Colors.white : Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  DateFormat.Hm().format(
                                      message.dateTime ?? DateTime.now()),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
                      hintText: 'Type a message',
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
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
                      chatController.fetchDetailChats(userId);
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
