import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:time_status/core/service/link.dart';
import 'package:time_status/core/service/service.dart';
import 'package:time_status/view/chatting/one_to_one_chat/views/in_one_to_one_chat/models/get_pinned_message.dart';

class GetPinMessageController extends GetxController {
  MyServices myServices = Get.find<MyServices>();
  RxList<PinnedMessage> pinnedMessages = <PinnedMessage>[].obs;

  Future<void> fetchPinnedMessages(String chatId) async {
    String? token = myServices.getToken();
    if (token == null) {
      print("Token not found");
      Get.snackbar("Error", "Authentication token not found",
          backgroundColor: Colors.white);
      return;
    } else {
      print('Token found: $token');
    }

    var response = await http.get(
      Uri.parse(AppLink.getpinedMessage(chatId)),

      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      pinnedMessages.assignAll(data.map((e) => PinnedMessage.fromJson(e)).toList());
      print("Pinned messages retrieved successfully");
    } else {
      print("Error: ${response.statusCode}");
    }
  }
}
