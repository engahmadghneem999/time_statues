import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_status/core/app_export.dart';

import 'package:time_status/view/creating_tasks/controller/creating_task_controller.dart';

class CreatingTasks extends StatelessWidget {
  final CreatingTasksController controller = Get.put(CreatingTasksController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task'),
        centerTitle: true,
        backgroundColor: AppColor.appbargreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<CreatingTasksController>(
          builder: (_) => ListView(
            children: [
              _buildTextField(controller.titleController, 'Title'),
              SizedBox(height: 15),
              _buildTextField(controller.descriptionController, 'Description'),
              SizedBox(height: 15),
              TextButton.icon(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(AppColor.appColor)),
                  onPressed: controller.pickLocation,
                  icon: controller.pickedLocation == null
                      ? Icon(
                          Icons.location_off,
                          color: AppColor.black,
                        )
                      : Icon(
                          Icons.location_on,
                          color: AppColor.appbargreen,
                        ),
                  label: Text(
                    'Pick A location',
                    style: TextStyle(color: AppColor.black),
                  )),
              SizedBox(height: 20),
              TextButton.icon(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(AppColor.appColor)),
                  onPressed: controller.createMainTask,
                  icon: Icon(
                    Icons.list_alt,
                    color: AppColor.black,
                  ),
                  label: Text(
                    'Create Main Task',
                    style: TextStyle(color: AppColor.black),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      keyboardType: keyboardType,
    );
  }

  Widget _buildElevatedButton(
      {required VoidCallback onPressed, required String text}) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
