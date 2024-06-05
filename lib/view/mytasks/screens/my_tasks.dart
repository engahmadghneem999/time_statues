import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_status/core/app_export.dart';
import 'package:time_status/view/mytasks/controller/my_tasks_controller.dart';
import 'package:time_status/view/mytasks/screens/widgets/task_card.dart';

// ignore: use_key_in_widget_constructors
class MyTasksPage extends StatelessWidget {
  final TasksController controller = Get.put(TasksController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColor.appbargreen, AppColor.backgroundbutton],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Implement your refresh logic here
          controller
              .fetchTasks(); // Assuming you have a method to fetch tasks in your controller
        },
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: controller.tasksList.length,
              itemBuilder: (context, index) {
                return TaskCard(task: controller.tasksList[index]);
              },
            );
          }
        }),
      ),
    );
  }
}
