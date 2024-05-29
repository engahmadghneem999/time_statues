import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:time_status/core/service/service.dart';
import 'package:time_status/data/model/sendmessage_model.dart';
import 'package:http/http.dart' as http;
import 'package:time_status/view/chatting/one_to_one_chat/controller/chat_controller.dart';
import '../../../../core/constant/shared_preferences_keys.dart';

class SendMessageController extends GetxController {
  TextEditingController textController = TextEditingController();
  // final chatController = Get.put(OneToOneChatController());
  MyServices myServices = Get.find();

  // List<dynamic> chatMessages = [];
  String? _selectedImage;

  Future<void> sendMessage({required String receiver}) async {
    print("receiverSendMessage=$receiver");

    try {
      print("SendMessage55777777777");

      final text = textController.text.trim();
      String imageUrl = "_selectedImage" ?? "";
      String audioUrl = "string";

      // || imageUrl.isNotEmpty
      if (text.isNotEmpty) {
        final newMessage = SendMessageModel(
          text: text,
          audioUrl: "audioUrl",
          imageUrl: "imageUrl",
          receiver: receiver,
        );

        update();

        // Clear text field and selected image
        textController.clear();
        _selectedImage = null;
        update();

        // Prepare request body
        var requestBody = json.encode({
          "receiver": receiver,
          "text": newMessage.text,
          "imageUrl": newMessage.imageUrl,
          "audioUrl": newMessage.audioUrl
        });
        // Make the HTTP POST request
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

        print(
            "SharedPreferencesKeys.tokenKey=${SharedPreferencesKeys.tokenKey}");
        print("requestBody=$requestBody");
        print("response.statusCodesendMessage=${response.statusCode}");

        if (response.statusCode == 200) {
          print(
              "5555555555555555555Message sent successfully555555555555555555555555555555555555555555555555555555555555555555555555555");
          print("jsonDecode = ${response.body}");
          var decodeResponse = json.decode(response.body);

          update();
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

      update();
    }
  }
}
