import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_status/core/constant/color.dart';
import 'package:time_status/view/chatting/controller/chat_controller.dart';
import 'package:time_status/view/favorites/screens/favorites_screen.dart';
import '../../../../data/model/Message.dart';
import '../../../../widget/custom_text.dart';
import 'package:audioplayers/audioplayers.dart';

import '../../controller/send_message_controller.dart';

class ChatInnerScreen extends StatefulWidget {
  const ChatInnerScreen({
    Key? key,
    this.userId,
  }) : super(key: key);
  final String? userId;

  @override
  State<ChatInnerScreen> createState() => _ChatInnerScreenState();
}

class _ChatInnerScreenState extends State<ChatInnerScreen> {
  // List<Message> chatMessages = [];
  List<Message> FavMessages = [];
  // TextEditingController textController = TextEditingController();

  Map<String, List<Message>> categoryMessages = {};

  // late FlutterSoundRecorder _audioRecorder;
  late AudioPlayer _audioPlayer;

  final controller1 = Get.put(ChatController());

  @override
  void initState() {
    // _audioRecorder = FlutterSoundRecorder();
    //controller1.fetchDetailChats(userId);
    _audioPlayer = AudioPlayer();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // _audioRecorder.closeRecorder();
    _audioPlayer.dispose();
    super.dispose();
  }

  // AudioPlayer audioPlayer = new AudioPlayer();
  // Duration duration = new Duration();
  // Duration position = new Duration();
  // bool isPlaying = false;
  // bool isLoading = false;
  // bool isPause = false;

  // void _sendMessage() async {
  //   final text = textController.text.trim();
  //   if (text.isNotEmpty) {
  //     final newMessage = Message(
  //       text: text,
  //       sender: 'User 1',
  //       timestamp: DateTime.now(),
  //     );
  //     setState(() {
  //       chatMessages.add(newMessage);
  //     });
  //     textController.clear();
  //   } else if (_selectedImage != null) {
  //     // Handle sending the selected image as a message
  //     final newImageMessage = Message(
  //       imageUrl: _selectedImage!, // Use non-null assertion here
  //       sender: 'User 1',
  //       timestamp: DateTime.now(),
  //     );
  //     setState(() {
  //       chatMessages.add(newImageMessage);
  //       _selectedImage = null; // Clear the selected image after sending
  //     });
  //   }
  // }

  // String?
  //     _selectedImage; // Variable to store the selected image file path or URL

  // void _selectImage() async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //
  //   if (pickedFile != null) {
  //     setState(() {
  //       _selectedImage = pickedFile.path; // Store the selected image file path
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    print('inner chat screen');
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
            const Text("admin"),
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
      body: GetBuilder<ChatController>(
          init: ChatController(),
          builder: (controller) {
            List allMessages = controller.chatMessages;
            List<Message> sorted = sortedMessages(allMessages, widget.userId);

            controller.idUser = widget.userId;

            controller1.fetchDetailChats(controller.idUser);
            print("iduser=${controller.idUser}");

            return Column(
              children: <Widget>[
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int index = 0; index < FavMessages.length; index++)
                        Container(
                          margin: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              BubbleSpecialOne(
                                text: FavMessages[index].text!,
                                color: const Color(0xFFE8E8EE),
                              ),
                              IconButton(
                                icon: const Icon(Icons.lock_clock),
                                onPressed: () {
                                  _removepinMessage(FavMessages[index]);
                                  // _pinMessage(message);
                                },
                              )
                            ],
                          ),
                        ),
                    ],
                  ),
                ),

                ///chat body
                Expanded(
                  child: ListView.builder(
                    itemCount: sorted.length, // Use sorted list here
                    itemBuilder: (context, index) {
                      final message = sorted[index];
                      final isCurrentUserMessage =
                          message.sender == widget.userId;
                      // message.sender == message.receiver;
                      // final isCurrentUserMessage = controller.chatMessages.userId == widget.userId;

                      print('jjjjjjjjjjjjj=${isCurrentUserMessage}');
                      print(" message.sender=${message.sender}");
                      print('widget.userId;${widget.userId}');
                      return Row(
                        mainAxisAlignment: isCurrentUserMessage
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTapDown: (TapDownDetails details) {
                              _showMessageOptions(
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
                                    ? BubbleSpecialThree(
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
                                      )
                                    : BubbleSpecialTwo(
                                        text: message.text ?? "",
                                        isSender: false,
                                        color: isCurrentUserMessage
                                            ? const Color(0xFFE8E8EE)
                                            : Colors.blue,
                                      ),
                                // BubbleSpecialThree(
                                //       text: message.text ?? "",
                                //   tail: isCurrentUserMessage?true:false,
                                //       color: isCurrentUserMessage
                                //           ? const Color(0xFFE8E8EE)
                                //           : Colors
                                //               .blue, // Set color based on sender
                                //       // sented
                                //       sent: true,
                                //       //seen
                                //       seen: isCurrentUserMessage?message.isSeen ?? false :false,
                                //     ),
                                const SizedBox(height: 4),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    '${message.timestamp?.hour}:${message.timestamp?.minute}',
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ),
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
                            icon:
                                const Icon(Icons.photo), // Icon for sending images
                            onPressed: () {
                              sendController.selectImage();
                            },
                          ),
                          // IconButton(
                          //   icon: const Icon(Icons.mic), // Icon for recording audio
                          //   onPressed: () {
                          //     _toggleRecording();
                          //   },
                          // ),
                          IconButton(
                            icon: const Icon(Icons.send), // Icon for sending text
                            onPressed: () {
                              sendController.sendMessage( receiver: controller.idUser!);
                            },
                          ),
                        ],
                      ),
                    );
                  }
                )
              ],
            );
          }),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _showMessageOptions(
      Message message, BuildContext context, Offset tapPosition) async {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        tapPosition,
        tapPosition,
      ),
      Offset.zero & overlay.size,
    );

    await showMenu(
      color: AppColor.black55,
      context: context,
      position: position,
      items: [
        PopupMenuItem(
          child: Row(
            children: [
              const CustomText(text: 'Pin', color: AppColor.white),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.pin),
                color: AppColor.oranegapp,
              )
            ],
          ),
          onTap: () {
            _pinMessage(message);
            print('Added to Favorites: ${message.text}');
          },
        ),
        PopupMenuItem(
          child: Row(
            children: [
              const CustomText(text: 'Favorites', color: AppColor.white),
              const Spacer(),
              IconButton(
                onPressed: () {
                  _addToCategory(context, message);
                },
                icon: const Icon(Icons.favorite),
                color: AppColor.oranegapp,
              )
            ],
          ),
          onTap: () {
            print('Added to Favorites: ${message.text}');
          },
        ),
        PopupMenuItem(
          child: Row(
            children: [
              const CustomText(text: 'Forward', color: AppColor.white),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.forward_5_outlined),
                color: AppColor.oranegapp,
              )
            ],
          ),
          onTap: () {
            // Implement logic to add the message to favorites
            print('Added to Favorites: ${message.text}');
          },
        ),
        // Add more options as needed
      ],
      elevation: 8.0,
    );
  }

  void _addToCategory(BuildContext context, Message message) {
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

  void _pinMessage(Message message) {
    setState(() {
      FavMessages.add(message);
      // chatMessages.remove(message);
    });
  }

  void _removepinMessage(Message message) {
    setState(() {
      FavMessages.remove(message);
    });
  }

  // void _sendMessage() {
  //   final text = textController.text.trim();
  //   if (text.isNotEmpty) {
  //     final newMessage = Message(
  //       text: text,
  //       sender: 'User 1',
  //       timestamp: DateTime.now(),
  //     );
  //     setState(() {
  //       chatMessages.add(newMessage);
  //     });
  //     textController.clear();
  //   }

// Widget _image() {
//   return Container(
//     constraints: BoxConstraints(
//       minHeight: 20.0,
//       minWidth: 20.0,
//     ),
//     child: CachedNetworkImage(
//       imageUrl: 'https://i.ibb.co/JCyT1kT/Asset-1.png',
//       progressIndicatorBuilder: (context, url, downloadProgress) =>
//           CircularProgressIndicator(value: downloadProgress.progress),
//       errorWidget: (context, url, error) => const Icon(Icons.error),
//     ),
//   );
// }
//
// void _changeSeek(double value) {
//   setState(() {
//     audioPlayer.seek(new Duration(seconds: value.toInt()));
//   });
// }
//
// void _playAudio() async {
//   final url =
//       'https://file-examples.com/storage/fef1706276640fa2f99a5a4/2017/11/file_example_MP3_700KB.mp3';
//   if (isPause) {
//     await audioPlayer.resume();
//     setState(() {
//       isPlaying = true;
//       isPause = false;
//     });
//   } else if (isPlaying) {
//     await audioPlayer.pause();
//     setState(() {
//       isPlaying = false;
//       isPause = true;
//     });
//   } else {
//     setState(() {
//       isLoading = true;
//     });
//     await audioPlayer.play(UrlSource(url));
//     setState(() {
//       isPlaying = true;
//     });
//   }
//
//   audioPlayer.onDurationChanged.listen((Duration d) {
//     setState(() {
//       duration = d;
//       isLoading = false;
//     });
//   });
//   audioPlayer.onPositionChanged.listen((Duration p) {
//     setState(() {
//       position = p;
//     });
//   });
//   audioPlayer.onPlayerComplete.listen((event) {
//     setState(() {
//       isPlaying = false;
//       duration = new Duration();
//       position = new Duration();
//     });
//   });
// }
}

bool _isRecording = false;
late String _recordedFilePath;

Future<void> _toggleRecording() async {
  if (!_isRecording) {
    try {
      // await _audioRecorder.openRecorder();
      // await _audioRecorder.startRecorder(
      //   toFile: "your_audio_file.mp3",
      //   codec: Codec.mp3,
      //  );

      // setState(() {
      //   _isRecording = true;
      // });
    } catch (e) {
      print("Error starting recording: $e");
    }
  } else {
    try {
      // String? path = await _audioRecorder.stopRecorder();
      // setState(() {
      //   _isRecording = false;
      //   _recordedFilePath = path!;
      // });

      // Implement logic to send the recorded file (path) here
    } catch (e) {
      print("Error stopping recording: $e");
    }
  }
}
// Inside your ChatController class

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
  senderMessages.sort((a, b) => a.timestamp!.compareTo(b.timestamp!));
  yourMessages.sort((a, b) => a.timestamp!.compareTo(b.timestamp!));

  // Concatenate senderMessages and yourMessages
  return [...senderMessages, ...yourMessages];
}
