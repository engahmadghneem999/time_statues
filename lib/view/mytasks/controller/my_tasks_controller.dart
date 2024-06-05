import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:time_status/core/constant/shared_preferences_keys.dart';
import 'package:time_status/core/service/link.dart';
import 'package:time_status/core/service/service.dart';
import 'package:time_status/view/mytasks/model/my_tasks_model.dart';

class TasksController extends GetxController {
  var isLoading = true.obs;
  MyServices myServices = Get.find();
  var tasksList = <TasksModel>[].obs;
  @override
  void onInit() {
    fetchTasks();
    super.onInit();
  }

  void fetchTasks() async {
    try {
      isLoading(true);
      var token = myServices.sharedPreferences
          .getString(SharedPreferencesKeys.tokenKey);
      var response = await http.get(
        Uri.parse(AppLink.getMainTask),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        List<TasksModel> tempList = [];
        for (var taskJson in jsonData) {
          tempList.add(TasksModel.fromJson(taskJson));
        }
        tasksList.value = tempList;
      } else {
        print('Failed to load tasks');
      }
    } finally {
      isLoading(false);
    }
  }
}
