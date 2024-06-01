import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:time_status/core/service/link.dart';
import 'package:time_status/core/service/service.dart';
import 'package:time_status/view/profile/screens/My_Followings/model/my_followings_model.dart';

class MyFollowingsController extends GetxController {
  MyServices myServices = Get.find<MyServices>();
  RxList<MyFollowingsModel> followingsList = <MyFollowingsModel>[].obs;

  Future<void> fetchFollowings() async {
    String? token = myServices.getToken();
    if (token == null) {
      Get.snackbar("Error", "Authentication token not found",
          backgroundColor: Colors.white);
      return;
    }

    var response = await http.get(
      Uri.parse(AppLink.getAllFollowings),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      followingsList
          .assignAll(data.map((e) => MyFollowingsModel.fromJson(e)).toList());
      print("Followings retrieved successfully");
    } else {
      Get.snackbar("Error", "Failed to fetch followings",
          backgroundColor: Colors.white);
    }
  }

  Future<void> followUser(String id) async {
    String? token = myServices.getToken();
    if (token == null) {
      Get.snackbar("Error", "Authentication token not found",
          backgroundColor: Colors.white);
      return;
    }

    var response = await http.post(
      Uri.parse(AppLink.followUser(id)),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      fetchFollowings(); // Refresh followings list
      Get.snackbar("Success", "User followed successfully",
          backgroundColor: Colors.white);
    } else {
      Get.snackbar("Error", "Failed to follow user",
          backgroundColor: Colors.white);
    }
  }

  Future<void> unfollowUser(String id) async {
    String? token = myServices.getToken();
    if (token == null) {
      Get.snackbar("Error", "Authentication token not found",
          backgroundColor: Colors.white);
      return;
    }

    var response = await http.post(
      Uri.parse(AppLink.unFollowUser(id)),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      fetchFollowings(); // Refresh followings list
      Get.snackbar("Success", "User unfollowed successfully",
          backgroundColor: Colors.white);
    } else {
      Get.snackbar("Error", "Failed to unfollow user",
          backgroundColor: Colors.white);
    }
  }

  int get followingsCount => followingsList.length;
}
