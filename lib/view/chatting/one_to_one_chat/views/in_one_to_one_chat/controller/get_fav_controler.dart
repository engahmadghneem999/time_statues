import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:time_status/core/service/service.dart';
import 'package:time_status/view/chatting/one_to_one_chat/views/in_one_to_one_chat/models/get_fav_messages.dart';

class FavoriteMessageController extends GetxController {
  MyServices myServices = Get.find<MyServices>();
  var favoriteMessages = <GetFavedModel>[].obs;
  var isLoading = false.obs;

  Future<void> fetchFavoriteMessages(String userId) async {
    String? token = myServices.getToken();
    if (token == null) {
      print("Token not found");
      Get.snackbar("Error", "Authentication token not found",
          backgroundColor: Colors.white);
      return;
    } else {
      print('Token okay');
    }

    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse('http://algor.somee.com/api/Chat/GetFavouriteMessages/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        favoriteMessages.value = body.map((item) => GetFavedModel.fromJson(item)).toList();
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }
}
