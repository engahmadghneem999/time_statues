import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:time_status/core/service/service.dart';
import 'package:time_status/data/model/sendmessage_model.dart';
import 'package:http/http.dart' as http;
import 'package:time_status/view/chatting/one%20to%20one%20chat/controller/chat_controller.dart';
import '../../../../core/constant/shared_preferences_keys.dart';

class SendMessageController extends GetxController {
  TextEditingController textController = TextEditingController();
  final chatController = Get.put(ChatController());
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

        //  print('ChatMessage SendMessage=${chatController.chatMessages}');

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
            // 'Authorization': 'Bearer ',
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
          // chatController.fetchDetailChats(receiver);

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

  //
  // Future<void> sendMessage({required String receiver}) async {
  //   try {
  //     print("receiver=$receiver");
  //     final text = textController.text.trim();
  //     String imageUrl = _selectedImage ?? "";
  //     String audioUrl = "";
  //     if (text.isNotEmpty || imageUrl.isNotEmpty) {
  //       final newMessage = SendMessageModel(
  //         text: text,
  //         audioUrl: audioUrl,
  //         imageUrl: imageUrl,
  //         receiver: receiver,
  //       );
  //       update();
  //       textController.clear();
  //       _selectedImage = null;
  //       update();
  //       // Update the local chat messages list
  //       // chatMessages.add(newMessage);
  //       //
  //
  //       // Clear text field and selected image
  //
  //
  //       print('ChatMessage SendMessage=$chatMessages');
  //
  //       // Prepare request body
  //       var requestBody = json.encode({
  //         "receiver": receiver,
  //         "text": newMessage.text,
  //         "imageUrl": newMessage.imageUrl,
  //         "audioUrl": newMessage.audioUrl
  //       });
  //
  //       // Make the HTTP POST request
  //       var response = await http.post(
  //         Uri.parse("http://algor.somee.com/api/Chat"),
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Authorization': 'Bearer ${ConstData.token}',
  //         },
  //         body: requestBody,
  //       );
  //
  //       print("url=$response");
  //       print("jsonDecode = ${response.body}");
  //       var decodeResponse = json.decode(response.body);
  //       print("response.statusCode=${response.statusCode}");
  //
  //       if (response.statusCode == 200) {
  //         print("Message sent successfully");
  //         chatMessages.add(newMessage);
  //         print("Message sent successfully");
  //         if (response.body.isNotEmpty) {
  //           var decodeResponse = json.decode(response.body);
  //           print("jsonDecode = ${decodeResponse}");
  //         } else {
  //           print("Response body is empty");
  //         }
  //         update();
  //       } else {
  //         Get.snackbar("Error", "Something went wrong", backgroundColor: Colors.white);
  //       }
  //
  //
  //     // if (text.isNotEmpty) {
  //     //   final newMessage = SendMessageModel(
  //     //     text: text,
  //     //     audioUrl: "",
  //     //     imageUrl: "",
  //     //     receiver: receiver,
  //     //   );
  //     //   // setState(() {
  //     //   chatMessages.add(newMessage);
  //     //   // });
  //     //   update();
  //     //   textController.clear();
  //     //   update();
  //     //   print('ChatMessage SendMessage=$chatMessages');
  //     // } else if (_selectedImage != null) {
  //     //   // Handle sending the selected image as a message
  //     //   final newImageMessage = SendMessageModel(
  //     //     text: text,
  //     //     audioUrl: "",
  //     //     imageUrl: _selectedImage,
  //     //     receiver: receiver,
  //     //   );
  //     //
  //     //   update();
  //     //   // setState(() {
  //     //   chatMessages.add(newImageMessage);
  //     //   _selectedImage = null; // Clear the selected image after sending
  //     //   // });
  //       update();
  //       print('ChatMessage SendMessage=$chatMessages');
  //     }
  //     var response = await http.post(
  //       Uri.parse("http://algor.somee.com/api/Chat"),
  //       //Uri.parse(AppLink.login),
  //       headers: {
  //         'Authorization': 'Bearer ${ConstData.token}',
  //       },
  //       body: {
  //         "receiver": "string",
  //         "text": "hehhehehe",
  //         "imageUrl": "string",
  //         "audioUrl": "string"
  //       },
  //     );
  //     print("jsonDecode = ${response.body}");
  //     var decodeResponse = json.decode(response.body);
  //     print("response.statusCode=${response.statusCode}");
  //     if (response.statusCode == 200) {
  //       print("20000000000");
  //
  //       update();
  //       //return true;
  //     } else {
  //       Get.snackbar("error", "Something wrong", backgroundColor: Colors.white);
  //
  //       return null;
  //     }
  //   } catch (e) {
  //     print('e in catchlogin=$e');
  //     Get.snackbar(
  //       "error",
  //       "something_went_wrong",
  //       backgroundColor: Colors.white,
  //     );
  //   }
  // }
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
  /*
  Future<void> sendMessage({required String receiver}) async {
    print("receiver=$receiver");
    final text = textController.text.trim();
    if (text.isNotEmpty) {
      final newMessage = SendMessageModel(
        text: text,
       audioUrl: "",
        imageUrl: "",
        receiver: receiver,
      );
      // setState(() {
      chatMessages.add(newMessage);
      // });
      update();
      textController.clear();
      update();
      print('ChatMessage SendMessage=$chatMessages');
    }
    else if (_selectedImage != null) {
      // Handle sending the selected image as a message
      final newImageMessage =
      SendMessageModel(
          text: text,
          audioUrl: "",
          imageUrl: _selectedImage,
          receiver: receiver,
      );

     update();
      // setState(() {
      chatMessages.add(newImageMessage);
      _selectedImage = null; // Clear the selected image after sending
      // });
      update();
      print('ChatMessage SendMessage=$chatMessages');

    }
  }

   */
}

/*

Future<void> sendMessage({required String receiver}) async {
  print("receiver=$receiver");
  final text = textController.text.trim();
  if (text.isNotEmpty) {
    final newMessage = SendMessageModel(
      text: text,
      audioUrl: "",
      imageUrl: "",
      receiver: receiver,
    );
    // setState(() {
    chatMessages.add(newMessage);
    // });
    update();
    textController.clear();
    update();
    print('ChatMessage SendMessage=$chatMessages');
  }
  else if (_selectedImage != null) {
    // Handle sending the selected image as a message
    final newImageMessage =
    SendMessageModel(
      text: text,
      audioUrl: "",
      imageUrl: _selectedImage,
      receiver: receiver,
    );

    update();
    // setState(() {
    chatMessages.add(newImageMessage);
    _selectedImage = null; // Clear the selected image after sending
    // });
    update();
    print('ChatMessage SendMessage=$chatMessages');

  }
}

 */
