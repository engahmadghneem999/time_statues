import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:time_status/core/service/service.dart';

class PostPinMessageController extends GetxController {
  MyServices myServices = Get.find<MyServices>();

  Future<void> pinMessage(String messageId) async {
    String? token = myServices.getToken();
    if (token == null) {
      print("Token not found");
      Get.snackbar("Error", "Authentication token not found",
          backgroundColor: Colors.white);
      return;
    }

    var response = await http.post(
      Uri.parse("http://algor.somee.com/api/Chat/PinMessage/$messageId"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print("Message pinned successfully");
      Get.snackbar("Success", "Message pinned successfully",
          backgroundColor: Colors.white);
    } else {
      print("Error: ${response.statusCode}");
      Get.snackbar("Error", "Failed to pin message",
          backgroundColor: Colors.white);
    }
  }
}
