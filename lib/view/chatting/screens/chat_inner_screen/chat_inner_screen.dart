import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:time_status/core/constant/color.dart';
import 'package:time_status/view/favorites/screens/favorites_screen.dart';
import '../../../../data/model/Message.dart';
import '../../../../widget/custom_text.dart';
import 'package:audioplayers/audioplayers.dart';

class ChatInnerScreen extends StatefulWidget {
  ChatInnerScreen({Key? key}) : super(key: key);

  @override
  State<ChatInnerScreen> createState() => _ChatInnerScreenState();
}

class _ChatInnerScreenState extends State<ChatInnerScreen> {
  List<Message> chatMessages = [];
  List<Message> FavMessages = [];
  TextEditingController textController = TextEditingController();

  Map<String, List<Message>> categoryMessages = {};

  // late FlutterSoundRecorder _audioRecorder;
  late AudioPlayer _audioPlayer;


  @override
  void initState() {

    // _audioRecorder = FlutterSoundRecorder();
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
  void _sendMessage() async {
    final text = textController.text.trim();
    if (text.isNotEmpty) {
      final newMessage = Message(
        text: text,
        sender: 'User 1',
        timestamp: DateTime.now(),
      );
      setState(() {
        chatMessages.add(newMessage);
      });
      textController.clear();
    } else if (_selectedImage != null) {
      // Handle sending the selected image as a message
      final newImageMessage = Message(
        imageUrl: _selectedImage!, // Use non-null assertion here
        sender: 'User 1',
        timestamp: DateTime.now(),
      );
      setState(() {
        chatMessages.add(newImageMessage);
        _selectedImage = null; // Clear the selected image after sending
      });
    }
  }


  String? _selectedImage; // Variable to store the selected image file path or URL

  void _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = pickedFile.path; // Store the selected image file path
      });
    }
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
            SizedBox(
              width: 10,
            ),
            Text('user 1'),
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
                  icon: Icon(Icons.favorite),
                )
              : Container()
        ],
      ),
      body: Column(
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int index = 0; index < FavMessages.length; index++)
                  Container(
                    margin: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        BubbleSpecialOne(
                          text: FavMessages[index].text!,
                          color: Color(0xFFE8E8EE),
                        ),
                        IconButton(
                          icon: Icon(Icons.lock_clock),
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
          Expanded(
            child: ListView.builder(
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    _showMessageOptions(
                        chatMessages[index], context, details.globalPosition);
                  },
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      BubbleSpecialThree(
                        text: chatMessages[index].text!,
                        color: Color(0xFFE8E8EE),
                        // sented
                        sent: true,
                       //seen
                       //  seen: true,
                      ),
                      SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          '${chatMessages[index].timestamp.hour}:${chatMessages[index].timestamp.minute}',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),


                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(labelText: 'Enter a message'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.photo), // Icon for sending images
                  onPressed:_selectImage,
                ),
                IconButton(
                  icon: Icon(Icons.mic), // Icon for recording audio
                  onPressed: () {
                    _toggleRecording();

                  },
                ),
                IconButton(
                  icon: Icon(Icons.send), // Icon for sending text
                  onPressed: _sendMessage,
                ),
              ],
            ),
          )
        ],
      ),

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
              CustomText(text: 'Pin', color: AppColor.white),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.pin),
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
              CustomText(text: 'Favorites', color: AppColor.white),
              Spacer(),
              IconButton(
                onPressed: () {
                  _addToCategory(context, message);
                },
                icon: Icon(Icons.favorite),
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
              CustomText(text: 'Forward', color: AppColor.white),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.forward_5_outlined),
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
          title: Text('Add to Category'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: categoryController,
                    decoration: InputDecoration(labelText: 'New Category Name'),
                  ),
                  SizedBox(height: 10),
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
              child: Text('Create a New Category'),
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
              child: Text('Add to Selected Categories'),
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


