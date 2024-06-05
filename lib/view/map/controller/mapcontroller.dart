import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:time_status/core/constant/shared_preferences_keys.dart';
import 'package:time_status/core/service/service.dart';
import 'package:time_status/view/map/model/get_main_task.dart';

class MainTaskController extends GetxController {
  var url = Uri.parse("http://algor.somee.com/api/MainTask");
  MyServices myServices = Get.find();
  RxList<MainTask> mainTasks = <MainTask>[].obs; // Define mainTasks as a RxList

  Future<void> fetchMainTasks() async {
    try {
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
        List<dynamic> data = jsonDecode(response.body);
        mainTasks
            .assignAll(data.map((task) => MainTask.fromJson(task)).toList());
      } else {
        throw Exception("Failed to load tasks");
      }
    } catch (e) {
      print("Error fetching tasks: $e");
      throw Exception("Error fetching tasks: $e"); // Re-throw the exception
    }
  }

  Future<void> createSubTask({
    required int mainTaskId,
    required String icon,
    required String timer,
    required String color,
    required double lat,
    required double lng,
  }) async {
    try {
      var token = myServices.sharedPreferences
          .getString(SharedPreferencesKeys.tokenKey);
      final response = await http.post(
        Uri.parse('http://algor.somee.com/api/Task'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "icon": icon,
          "timer": timer,
          "color": color,
          "mainTaskId": mainTaskId,
          "lat": lat.toString(),
          "lng": lng.toString(),
        }),
      );

      if (response.statusCode == 200) {
        print('Sub-task created successfully.');
        fetchMainTasks(); // Refresh tasks after adding a sub-task
        Get.snackbar('Success', 'Sub-task created successfully.');
      } else {
        Get.snackbar('Error', 'Failed to create sub-task.');
        print("Failed to create sub-task: ${response.body}");
      }
    } catch (e) {
      print("Error creating sub-task: $e");
      throw Exception("Error creating sub-task: $e"); // Re-throw the exception
    }
  }
}
