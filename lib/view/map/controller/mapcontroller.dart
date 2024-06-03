import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:time_status/core/constant/shared_preferences_keys.dart';
import 'package:time_status/core/service/service.dart';
import 'package:time_status/view/map/model/get_main_task.dart';

class TaskController extends GetxController {
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
        print("Getting successfully");

        // Print the data fetched from the API
        List<dynamic> data = jsonDecode(response.body);
        for (var task in data) {
          print("Name: ${task['title']}");
          print("Description: ${task['description']}");
          print("Latitude: ${task['lat']}");
          print("Longitude: ${task['lng']}");
          print(""); // Add an empty line for separation
        }

        // Assign fetched data to mainTasks
        mainTasks
            .assignAll(data.map((task) => MainTask.fromJson(task)).toList());
      } else {
        throw Exception("Failed to load tasks");
      }
    } catch (e) {
      print("Error fetching tasks: $e");
    }
  }

  Future<void> createTask(
      String title, String description, String lat, String lng) async {
    try {
      var token = myServices.sharedPreferences
          .getString(SharedPreferencesKeys.tokenKey);
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'title': title,
          'description': description,
          'lat': lat,
          'lng': lng,
        }),
      );

      if (response.statusCode == 200) {
        print("Task sent successfully:");
        print("Name: $title");
        print("Description: $description");
        print("Latitude: $lat");
        print("Longitude: $lng");
      } else {
        throw Exception("Failed to create task");
      }
    } catch (e) {
      print("Error creating task: $e");
      throw Exception("Failed to create task");
    }
  }
}
