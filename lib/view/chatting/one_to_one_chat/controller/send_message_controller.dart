import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:time_status/core/service/service.dart';
import 'package:time_status/data/model/sendmessage_model.dart';
import 'package:http/http.dart' as http;
import 'package:time_status/view/chatting/one_to_one_chat/views/one_to_one_chatting_screen/controller/in_one_to_one_contoller.dart';
import '../../../../core/constant/shared_preferences_keys.dart';

class SendMessageController extends GetxController {
  TextEditingController textController = TextEditingController();
  MyServices myServices = Get.find();
  String? _selectedImage;
  final InOneToOneChatController chatController = Get.find(); // Reference to the chat controller

  Future<void> sendMessage({required String receiver}) async {
    try {
      final text = textController.text.trim();
      String imageUrl = "_selectedImage" ?? "";
      String audioUrl = "string";

      if (text.isNotEmpty) {
        final newMessage = SendMessageModel(
          text: text,
          audioUrl: "audioUrl",
          imageUrl: "imageUrl",
          receiver: receiver,
        );

        // Prepare request body
        var requestBody = json.encode({
          "receiver": receiver,
          "text": newMessage.text,
          "imageUrl": newMessage.imageUrl,
          "audioUrl": newMessage.audioUrl
        });

        var token = myServices.sharedPreferences
            .getString(SharedPreferencesKeys.tokenKey);
        var response = await http.post(
          Uri.parse("http://algor.somee.com/api/Chat"),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'X-Requested-With': 'XMLHttpRequest',
            'Authorization': 'Bearer $token',
          },
          body: requestBody,
        );

        if (response.statusCode == 200) {
          // Clear text field and selected image
          textController.clear();
          _selectedImage = null;

          // Refresh chat messages
          await chatController.fetchDetailChats(receiver);
        } else {
          print("Error: ${response.statusCode}");
          Get.snackbar("Error", "Something went wrong",
              backgroundColor: Colors.white);
        }
      } else {
        Get.snackbar("Error", "Please enter text or select an image",
            backgroundColor: Colors.white);
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
      _selectedImage = pickedFile.path;
    }
  }
}
