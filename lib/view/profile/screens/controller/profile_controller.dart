import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:time_status/core/service/service.dart';
import '../../../../core/class/status_request.dart';
import '../../../../core/service/link.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var username = ''.obs;
  RxInt followersCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find<MyServices>();

  getUser() async {
    isLoading.value = true;
    try {
      String url = AppLink.getUserData;
      print("url=$url");

      String? token = myServices.getToken();
      if (token == null) {
        print("Token not found");
        isLoading.value = false;
        return;
      }

      print("Token: $token");

      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token', // Add your token here
        },
      );

      print("jsonDecode = ${response.body}");
      print("statuscode=${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Response status code is 200 or 201");
        var decodeResponse = json.decode(response.body);
        username.value = decodeResponse['username'];
        print("Username: ${username.value}");
      } else {
        print("Error: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchFollowersCount() async {
    String? token = myServices.getToken();
    if (token == null) {
      Get.snackbar("Error", "Authentication token not found",
          backgroundColor: Colors.white);
      return;
    }

    var response = await http.get(
      Uri.parse("http://algor.somee.com/api/User/GetAllFollowers"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      followersCount.value = data.length;
      print("Followers count retrieved successfully");
    } else {
      Get.snackbar("Error", "Failed to fetch followers count",
          backgroundColor: Colors.white);
    }
  }
}
