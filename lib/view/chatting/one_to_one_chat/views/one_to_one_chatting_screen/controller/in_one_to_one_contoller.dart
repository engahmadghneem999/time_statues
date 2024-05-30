import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:time_status/core/service/link.dart';
import 'package:time_status/data/model/Message.dart';
import '../../../../../../core/constant/shared_preferences_keys.dart';
import '../../../../../../core/service/service.dart';

class InOneToOneChatController extends GetxController {
  MyServices myServices = Get.find();
  var isLoading = false.obs;
  var chatMessages = <Message>[].obs;

  TextEditingController textController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchDetailChats(String id) async {
    isLoading(true);
    try {
      var url = Uri.parse(AppLink.getInOneToOneChats(id));
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

      if (response.statusCode == 200) {
        List<Message> fetchedMessages = (json.decode(response.body) as List)
            .map((data) => Message.fromJson(data))
            .toList();
        chatMessages.assignAll(fetchedMessages);
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (error) {
      print("Error catch: $error");
    } finally {
      isLoading(false);
    }
  }
}
