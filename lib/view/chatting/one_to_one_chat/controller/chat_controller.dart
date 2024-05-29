import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constant/shared_preferences_keys.dart';
import 'package:http/http.dart' as http;
import '../../../../core/service/service.dart';
import '../../../../data/model/Message.dart';

class MainOneToOneChatController extends GetxController {
  String? idUser = '';
  @override
  void onInit() {
    fetchDetailChats(idUser);
    super.onInit();
  }

  MyServices myServices = Get.find();
  List modelChatList = [];
  bool isLoading = false;
  List<dynamic> chatMessages = [];
  TextEditingController textController = TextEditingController();
  String? _selectedImage;
  String? get selectedImage => _selectedImage;
  Function get selectImage => _selectImage;
//! GET THE MAIN CHAT ITEMS

  Future<void> fetchDetailChats(String? idUs) async {
    try {
      isLoading = true;

      var url = Uri.parse("http://algor.somee.com/api/Chat/MyChat");

      print("url chat message= $url");
      var token = myServices.sharedPreferences
          .getString(SharedPreferencesKeys.tokenKey);
      print("tokenn=$token");
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token',
        },
      );

      print(response.statusCode);
      print(jsonDecode(response.body));
      var responseDecode = json.decode(response.body);
      print("responseDecode= $responseDecode");
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        chatMessages = responseDecode.map((e) => Message.fromJson(e)).toList();

        print("new modelChatList = $chatMessages");
        isLoading = false;

        update();
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (error) {
      print("Error catch: $error");
    }
    update();
  }

  // Future<void> _sendMessage() async {
  //   final text = textController.text.trim();
  //   if (text.isNotEmpty) {
  //     final newMessage = Message(
  //       text: text,
  //       sender: 'User 1',
  //       dateTime: DateTime.now(),
  //     );
  //     // setState(() {
  //     chatMessages.add(newMessage);
  //     // });
  //     update();
  //     textController.clear();
  //     update();
  //   } else if (_selectedImage != null) {
  //     // Handle sending the selected image as a message
  //     final newImageMessage = Message(
  //       imageUrl: _selectedImage!, // Use non-null assertion here
  //       sender: 'User 1',
  //       dateTime: DateTime.now(),
  //     );
  //     // setState(() {
  //     chatMessages.add(newImageMessage);
  //     _selectedImage = null; // Clear the selected image after sending
  //     // });
  //     update();
  //   }
  // }

  void _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // setState(() {
      _selectedImage = pickedFile.path; // Store the selected image file path
      // });
      update();
    }
  }
}
