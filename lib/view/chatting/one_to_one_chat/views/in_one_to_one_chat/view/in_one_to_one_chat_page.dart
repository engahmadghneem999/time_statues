import 'package:audioplayers/audioplayers.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:time_status/data/model/Message.dart';
import 'package:time_status/view/chatting/one_to_one_chat/controller/chat_controller.dart';
import 'package:time_status/view/chatting/one_to_one_chat/views/in_one_to_one_chat/controller/favorite_message_controller.dart';
import 'package:time_status/view/chatting/one_to_one_chat/views/in_one_to_one_chat/controller/pin_message_controller.dart';

import '../../../../../../core/constant/color.dart';
import '../../../../../favorites/screens/favorites_screen.dart';
import '../../../../../splash/screen/widgets/custom_text.dart';
import '../../../controller/send_message_controller.dart';
import '../controller/get_pin_controller.dart';
import '../widgets/show_message_options.dart';

class InChatScreen extends StatefulWidget {
  const InChatScreen({
    Key? key,
    required this.userId,
    required this.userName,
  }) : super(key: key);

  final String userId;
  final String userName;
  @override
  State<InChatScreen> createState() => _ChatInnerScreenState();
}

class _ChatInnerScreenState extends State<InChatScreen> {
  List<Message> FavMessages = [];
  Map<String, List<Message>> categoryMessages = {};
  late AudioPlayer _audioPlayer;
  final chatController = Get.put(MainOneToOneChatController());
  final GetPinMessageController getPinMessageController =
      Get.put(GetPinMessageController());

  final PinMessageController pinMessageController =
      Get.put(PinMessageController());
  final FavMessageController favMessageController =
      Get.put(FavMessageController());

  @override
  void initState() {
    chatController.fetchDetailChats(chatController.idUser);

    _audioPlayer = AudioPlayer();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appgreen,
        title: Row(
          children: [
            CircleAvatar(
                child: Image.asset('assets/images/img_rectangle162.png'),
                radius: 20),
            const SizedBox(
              width: 10,
            ),
            Text("${widget.userName}, "),
          ],
        ),
        actions: [
          categoryMessages.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Favorites(
                              categoryMessages: categoryMessages,
                            )));
                  },
                  icon: const Icon(Icons.favorite),
                )
              : Container()
        ],
      ),
      body: GetBuilder<MainOneToOneChatController>(
          init: MainOneToOneChatController(),
          builder: (controller) {
            List allMessages = controller.chatMessages;
            List<Message> sorted = sortedMessages(allMessages, widget.userId);

            controller.idUser = widget.userId;

            // print("iduser=${controller.idUser}");
            List<Message> pinnedMessages =
                sorted.where((message) => message.isPin!).toList();
            sorted.removeWhere((message) => message.isPin!);
            return Column(
              children: <Widget>[
                ///chat body
                SingleChildScrollView(
                    child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              CustomText(
                                text: 'Pinned messages :'.tr,
                                fontSize: 15,
                              ),
                              CustomText(
                                text: pinnedMessages.length.toString(),
                                fontSize: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 50.h,
                        child: pinnedMessages.any(
                                (pinnedMessage) => pinnedMessage.isPin == true)
                            ? ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: pinnedMessages.length,
                                itemBuilder: (context, index) {
                                  final pinnedMessage = pinnedMessages[index];
                                  return Container(
                                    width: 210.w,
                                    margin: EdgeInsets.all(10),
                                    color: Colors.grey[300],
                                    child: Center(
                                      child: Text(pinnedMessage.text ?? ''),
                                    ),
                                  );
                                },
                              )
                            : Container(), // Return an empty container if there are no pinned messages
                      ),
                    ],
                  ),
                )),
                Expanded(
                  child: ListView.builder(
                    itemCount: sorted.length, // Use sorted list here
                    itemBuilder: (context, index) {
                      final message = sorted[index];
                      final isCurrentUserMessage =
                          message.sender == widget.userId;

                      return Row(
                        mainAxisAlignment: isCurrentUserMessage
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTapDown: (TapDownDetails details) {
                              showMessageOptions(
                                  sorted[index], // Use sorted list here
                                  context,
                                  details.globalPosition);
                            },
                            child: Column(
                              crossAxisAlignment: isCurrentUserMessage
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                isCurrentUserMessage
                                    ? BubbleSpecialTwo(
                                        text: message.text ?? "",
                                        isSender: false,
                                        color: isCurrentUserMessage
                                            ? const Color(0xFFE8E8EE)
                                            : Colors.blue,
                                      )
                                    : BubbleSpecialThree(
                                        text: message.text ?? "",
                                        color: isCurrentUserMessage
                                            ? const Color(0xFFE8E8EE)
                                            : Colors
                                                .blue, // Set color based on sender
                                        // sented
                                        tail:
                                            isCurrentUserMessage ? true : false,
                                        sent: true,
                                        //seen
                                        seen: isCurrentUserMessage
                                            ? message.isSeen ?? false
                                            : false,
                                      ),
                                const SizedBox(height: 4),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    '${message.dateTime?.hour}:${message.dateTime?.minute}',
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ),
                                // IconButton(
                                // icon: const Icon(Icons.push_pin),
                                // onPressed: () {
                                //   pinMessageController.pinMessage(message.id);
                                // },
                                // ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                GetBuilder<SendMessageController>(
                    init: SendMessageController(),
                    builder: (sendController) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                controller: sendController.textController,
                                decoration: const InputDecoration(
                                    labelText: 'Enter a message'),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                  Icons.photo), // Icon for sending images
                              onPressed: () {
                                sendController.selectImage();
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                  Icons.send), // Icon for sending text
                              onPressed: () {
                                sendController.sendMessage(
                                    receiver: controller.idUser!);
                              },
                            ),
                          ],
                        ),
                      );
                    })
              ],
            );
          }),
    );
  }

  void addToCategory(BuildContext context, Message message) {
    TextEditingController categoryController = TextEditingController();

    List<String> categories = categoryMessages.keys.toList();
    List<bool> categoryCheckBoxes =
        List.generate(categories.length, (index) => false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add to Category'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: categoryController,
                    decoration:
                        const InputDecoration(labelText: 'New Category Name'),
                  ),
                  const SizedBox(height: 10),
                  for (int i = 0; i < categories.length; i++)
                    Row(
                      children: [
                        Checkbox(
                          value: categoryCheckBoxes[i],
                          onChanged: (value) {
                            setState(() {
                              categoryCheckBoxes[i] = value!;
                            });
                          },
                        ),
                        Text(categories[i]),
                      ],
                    ),
                ],
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                String newCategory = categoryController.text;
                if (newCategory.isNotEmpty) {
                  _addMessageToCategory(newCategory, message, context);
                }
                Navigator.of(context).pop();
              },
              child: const Text('Create a New Category'),
            ),
            TextButton(
              onPressed: () {
                for (int i = 0; i < categories.length; i++) {
                  if (categoryCheckBoxes[i]) {
                    _addMessageToCategory(categories[i], message, context);
                  }
                }

                Navigator.of(context).pop();
              },
              child: const Text('Add to Selected Categories'),
            ),
          ],
        );
      },
    );
  }

  void _addMessageToCategory(
      String category, Message message, BuildContext context) {
    setState(() {
      if (!categoryMessages.containsKey(category)) {
        categoryMessages[category] = [];
      }
      categoryMessages[category]!.add(message);
    });
  }
//! TODO Waiting for the api method
//   void _removepinMessage(Message message) {
//   setState(() {
//     pinMessageController.remove(message);
//   });
// }
}

bool _isRecording = false;
late String _recordedFilePath;

Future<void> _toggleRecording() async {
  if (!_isRecording) {
    try {} catch (e) {
      print("Error starting recording: $e");
    }
  } else {
    try {} catch (e) {
      print("Error stopping recording: $e");
    }
  }
}

List<Message> sortedMessages(List<dynamic> messages, String? userId) {
  List<Message> senderMessages = [];
  List<Message> yourMessages = [];

  // Filter messages into senderMessages and yourMessages
  for (var message in messages) {
    if (message.sender == userId) {
      yourMessages.add(message);
    } else {
      senderMessages.add(message);
    }
  }

  // Sort messages individually
  senderMessages.sort((a, b) => a.dateTime!.compareTo(b.dateTime!));
  yourMessages.sort((a, b) => a.dateTime!.compareTo(b.dateTime!));

  // Concatenate senderMessages and yourMessages
  return [...senderMessages, ...yourMessages];
}
