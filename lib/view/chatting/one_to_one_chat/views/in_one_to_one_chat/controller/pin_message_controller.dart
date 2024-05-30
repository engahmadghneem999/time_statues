import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:time_status/core/service/link.dart';
import 'package:time_status/core/service/service.dart';

class PinMessageController extends GetxController {
  MyServices myServices = Get.find<MyServices>();

  Future<void> pinMessage(String id) async {
    String? token = myServices.getToken();
    if (token == null) {
      print("Token not found");
      Get.snackbar("Error", "Authentication token not found",
          backgroundColor: Colors.white);
      return;
    } else
      print('token okay');

    var response = await http.get(
      Uri.parse(AppLink.getpinedMessage(id)),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print("Message Pinned Successfully");
      print("Response: ${response.body}");
    } else {
      print("Error: ${response.statusCode}");
    }
  }
}
