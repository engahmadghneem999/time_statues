import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:time_status/core/service/link.dart';
import 'package:time_status/core/service/service.dart';
import 'package:time_status/view/profile/screens/My_Followers/model/my_followers_model.dart';

class FollowersController extends GetxController {
  MyServices myServices = Get.find<MyServices>();
  RxList<FollowerModel> followersList = <FollowerModel>[].obs;

  Future<void> fetchFollowers() async {
    String? token = myServices.getToken();
    if (token == null) {
      Get.snackbar("Error", "Authentication token not found",
          backgroundColor: Colors.white);
      return;
    }

    var response = await http.get(
      Uri.parse(AppLink.getAllFollowers),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      followersList.assignAll(data.map((e) => FollowerModel.fromJson(e)).toList());
      print("Followers retrieved successfully");
    } else {
      Get.snackbar("Error", "Failed to fetch followers",
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
      fetchFollowers(); // Refresh followers list
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
      fetchFollowers(); // Refresh followers list
      Get.snackbar("Success", "User unfollowed successfully",
          backgroundColor: Colors.white);
    } else {
      Get.snackbar("Error", "Failed to unfollow user",
          backgroundColor: Colors.white);
    }
  }
}
