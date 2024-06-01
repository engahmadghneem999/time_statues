import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_status/core/constant/color.dart';
import 'package:time_status/view/chatting/one_to_one_chat/controller/send_message_controller.dart';
import 'package:time_status/view/chatting/one_to_one_chat/views/in_one_to_one_chat/controller/get_pin_controller.dart';
import 'package:time_status/view/chatting/one_to_one_chat/views/in_one_to_one_chat/controller/pin_message_controller.dart';
import 'package:time_status/view/chatting/one_to_one_chat/views/one_to_one_chatting_screen/controller/in_one_to_one_contoller.dart';
import 'package:time_status/view/chatting/one_to_one_chat/views/in_one_to_one_chat/controller/favorite_message_controller.dart';
import 'package:intl/intl.dart';
import 'package:time_status/view/chatting/one_to_one_chat/views/one_to_one_chatting_screen/widgets/favorite_messages.dart';
import 'package:time_status/view/chatting/one_to_one_chat/views/one_to_one_chatting_screen/widgets/pinned_messages_section.dart';
import 'dart:async'; // Import this for using Timer

class InChatScreen extends StatefulWidget {
  final String userId;
  final String userName;

  InChatScreen({required this.userId, required this.userName});

  @override
  _InChatScreenState createState() => _InChatScreenState();
}

class _InChatScreenState extends State<InChatScreen> {
  final InOneToOneChatController chatController =
      Get.put(InOneToOneChatController());
  final SendMessageController sendMessageController =
      Get.put(SendMessageController());
  final GetPinMessageController getPinMessageController =
      Get.put(GetPinMessageController());
  final PostFavoriteMessageController getFavoriteMessageController =
      Get.put(PostFavoriteMessageController());
  final PostPinMessageController postPinMessageController =
      Get.put(PostPinMessageController());

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    chatController.fetchDetailChats(widget.userId);
    getPinMessageController.fetchPinnedMessages(widget.userId);
    sendMessageController.textController.addListener(_updateButtonState);

    // Start polling for new messages
    _startPolling();
  }

  @override
  void dispose() {
    sendMessageController.textController.removeListener(_updateButtonState);
    sendMessageController.textController.dispose();

    // Cancel the timer when the screen is disposed
    _stopPolling();
    super.dispose();
  }

  void _updateButtonState() {
    setState(() {});
  }

  void _startPolling() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      chatController.fetchDetailChats(widget.userId);
    });
  }

  void _stopPolling() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              Get.to(FavoriteMessageScreen(userId: widget.userId));
            },
          ),
        ],
        title: Text(widget.userName),
        backgroundColor: AppColor.appbargreen,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PinnedMessagesSection(
              getPinMessageController: getPinMessageController),
          Expanded(
            child: Obx(() {
              if (chatController.chatMessages.isEmpty) {
                return Center(child: Text('No messages'));
              } else {
                return ListView.builder(
                  reverse: true,
                  itemCount: chatController.chatMessages.length,
                  itemBuilder: (context, index) {
                    final message = chatController.chatMessages[index];
                    final isMe = message.sender == widget.userId;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Align(
                        alignment:
                            isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: GestureDetector(
                          onLongPress: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Wrap(
                                  children: [
                                    ListTile(
                                      leading: Icon(Icons.favorite),
                                      title: Text('Add to favorites'.tr),
                                      onTap: () {
                                        getFavoriteMessageController
                                            .favoriteMessage(
                                                message.id.toString());
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.push_pin),
                                      title: Text('Pin message'.tr),
                                      onTap: () {
                                        postPinMessageController
                                            .pinMessage(message.id.toString())
                                            .then((_) {
                                          getPinMessageController
                                              .fetchPinnedMessages(
                                                  widget.userId);
                                        });
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.75),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: isMe ? Colors.green : Colors.grey.shade200,
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
                  icon: Icon(Icons.attach_file, color: AppColor.appbargreen),
                  onPressed: () {
                    sendMessageController.selectImage();
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: sendMessageController.textController,
                    decoration: InputDecoration(
                      hintText: 'Type a message'.tr,
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
                  icon: Icon(
                    Icons.send,
                    color: sendMessageController.textController.text.isNotEmpty
                        ? AppColor.appbargreen
                        : Colors.black,
                  ),
                  onPressed:
                      sendMessageController.textController.text.isNotEmpty
                          ? () {
                              sendMessageController
                                  .sendMessage(receiver: widget.userId)
                                  .then((_) {});
                            }
                          : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
