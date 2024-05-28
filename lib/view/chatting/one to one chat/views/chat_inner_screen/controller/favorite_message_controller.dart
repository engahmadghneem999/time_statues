import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:time_status/core/service/link.dart';
import 'package:time_status/core/service/service.dart';

class FavMessageController extends GetxController {
  MyServices myServices = Get.find<MyServices>();

  Future<void> favMessage(int id) async {
    String? token = myServices.getToken();
    if (token == null) {
      print("Token not found");
      Get.snackbar("Error", "Authentication token not found",
          backgroundColor: Colors.white);
      return;
    } else
      print('token okay');

    var response = await http.post(
      Uri.parse(AppLink.favMessage(id)),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({}), // Assuming the API expects an empty body
    );

    if (response.statusCode == 200) {
      print("Message Fav-ed Successfully");
      print("Response: ${response.body}");
      Get.snackbar("Success", "Message fav_ed successfully",
          backgroundColor: Colors.white);
    } else {
      print("Error: ${response.statusCode}");
      Get.snackbar("Error", "Something went wrong",
          backgroundColor: Colors.white);
    }
  }
}
