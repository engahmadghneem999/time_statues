import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../core/constant/shared_preferences_keys.dart';
import '../../../../core/service/link.dart';
import '../../../../core/service/service.dart';
import '../model/groups_get_chats_moderl.dart';

class GroupChatController extends GetxController {
  var chatMessages = <GetGroupsChatsModel>[].obs;
  MyServices myServices = Get.find();

  @override
  void onInit() {
    fetchChatMessages();
    super.onInit();
  }

  Future<void> fetchChatMessages() async {
    try {
      var isLoading = true.obs;
      var url = Uri.parse(AppLink.getGroupsChats);
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

      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseDecode = json.decode(response.body) as List;
        chatMessages.value =
            responseDecode.map((e) => GetGroupsChatsModel.fromJson(e)).toList();
        isLoading.value = false;
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (error) {
      print("Error catch: $error");
    }
  }

  Future<void> joinGroup(int id) async {
    String? token = myServices.getToken();
    if (token == null) {
      print("Token not found");
      Get.snackbar("Error", "Authentication token not found",
          backgroundColor: Colors.white);
      return;
    } else {
      print('token okay');
    }

    var response = await http.post(
      Uri.parse(AppLink.joinToGroup(id)),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({}),
    );

    if (response.statusCode == 200) {
      print("Joined Successfully");
      Get.snackbar("Success", "Joined to group successfully",
          backgroundColor: Colors.white);
    } else {
      print("Error: ${response.statusCode}");
      Get.snackbar("Error", "Something went wrong",
          backgroundColor: Colors.white);
    }
  }
}
