import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:time_status/view/chatting/one_to_one_chat/views/one_to_one_chatting_screen/model/get_chats_model.dart';
import '../../../../../../core/constant/shared_preferences_keys.dart';
import '../../../../../../core/service/service.dart';

class OneToOneChatMainScreenController extends GetxController {
  String? idUser = '';
  @override
  void onInit() {
    fetchOnetoOneMainChats();
    super.onInit();
  }

  MyServices myServices = Get.find();
  List ChatsList = [];
  bool isLoading = false;
  List<dynamic> chatMessages = [];
  TextEditingController textController = TextEditingController();
  Future<void> fetchOnetoOneMainChats() async {
    try {
      isLoading = true;
      var url = Uri.parse("http://algor.somee.com/api/Chat/ChatPage");
      print(url);
      var token = myServices.sharedPreferences
          .getString(SharedPreferencesKeys.tokenKey);
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token',
        },
      );

      var responseDecode = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        ChatsList = responseDecode.map((e) => getchats.fromJson(e)).toList();

        isLoading = false;
        print(response.statusCode);
        print("20000000000000 donnnnnnnnne");
        update();
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (error) {
      print("Error catch: $error");
    }
    update();
  }

  // Future<void> fetchDetailChats(String? idUs) async {
  //   try {
  //     isLoading = true;

  //     var url = Uri.parse("http://algor.somee.com/api/Chat/MyChat");

  //     print("url chat message= $url");
  //     var token = myServices.sharedPreferences
  //         .getString(SharedPreferencesKeys.tokenKey);
  //     print("tokenn=$token");
  //     final response = await http.get(
  //       url,
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //         'X-Requested-With': 'XMLHttpRequest',
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     print(response.statusCode);
  //     print(jsonDecode(response.body));
  //     var responseDecode = json.decode(response.body);
  //     print("responseDecode= $responseDecode");
  //     print(response.statusCode);

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       chatMessages = responseDecode.map((e) => Message.fromJson(e)).toList();

  //       print("new modelChatList = $chatMessages");
  //       isLoading = false;

  //       update();
  //     } else {
  //       print("Error: ${response.statusCode}");
  //     }
  //   } catch (error) {
  //     print("Error catch: $error");
  //   }
  //   update();
  // }
}
