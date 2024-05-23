import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:time_status/data/model/sendmessage_model.dart';
import 'package:http/http.dart' as http;
import 'package:time_status/view/chatting/controller/chat_controller.dart';

import '../../../core/constant/constant_data.dart';

class SendMessageController extends GetxController {
  final chatController = Get.put(ChatController());

  TextEditingController textController = TextEditingController();

  // List<dynamic> chatMessages = [];
  String? _selectedImage;

  Future<void> sendMessage({required String receiver}) async {
    try {
      print("receiver=$receiver");

      final text = textController.text.trim();
      String imageUrl = "_selectedImage" ?? "";
      String audioUrl = "string";

      // || imageUrl.isNotEmpty
      if (text.isNotEmpty ) {
        final newMessage = SendMessageModel(
          text: text,
          audioUrl: "audioUrl",
          imageUrl: "imageUrl",
          receiver: receiver,
        );

        // Update the local chat messages list
        chatController.chatMessages.add(newMessage);
        update();

        // Clear text field and selected image
        textController.clear();
        _selectedImage = null;
        update();

        print('ChatMessage SendMessage=${chatController.chatMessages}');

        // Prepare request body
        var requestBody = json.encode({
          "receiver": receiver,
          "text": newMessage.text,
          "imageUrl": newMessage.imageUrl,
          "audioUrl": newMessage.audioUrl
        });

        // Make the HTTP POST request
        var response = await http.post(
          Uri.parse("http://algor.somee.com/api/Chat"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjEiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiYWRtaW4iLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJhZG1pblVzZXJAZXhhbXBsZS5jb20iLCJBc3BOZXQuSWRlbnRpdHkuU2VjdXJpdHlTdGFtcCI6ImVmZGNjNTY3LWNkOWUtNDYzNi04NzE2LWU0ZDg2MDVhZGRiMyIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IkFkbWluIiwicGVybWlzc2lvbnMiOlsiY3JlYXRlIiwidXBkYXRlIiwiZGVsZXRlIl0sImV4cCI6MTcxNjEyMTA5M30.kqhH8MAQWrAjAMbSPz19fThpeWvU4tJBoy_Y1LD5i3E',
               // '${ConstData.token}',
          },
          body: requestBody,
        );

        print("requestBody=$requestBody");
        print("response.statusCode=${response.statusCode}");

        if (response.statusCode == 200) {
          print("Message sent successfully");
          print("jsonDecode = ${response.body}");
          var decodeResponse = json.decode(response.body);
          update();
        } else {
          print("Error: ${response.statusCode}");
          Get.snackbar("Error", "Something went wrong", backgroundColor: Colors.white);
        }
      } else {
        Get.snackbar("Error", "Please enter text or select an image", backgroundColor: Colors.white);
      }
    } catch (e) {
      print('Error in sendMessage: $e');
      Get.snackbar(
        "Error",
        "Something went wrong",
        backgroundColor: Colors.white,
      );
    }
  }


  void selectImage() async {
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

