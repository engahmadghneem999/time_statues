import 'package:get/get.dart';
import 'dart:convert';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:time_status/core/constant/color.dart';
import 'package:time_status/core/constant/shared_preferences_keys.dart';
import 'package:time_status/core/service/link.dart';
import 'package:time_status/core/service/service.dart';
import 'package:time_status/view/creating_tasks/screens/widgets/picking_pos.dart';
import 'package:geocoding/geocoding.dart';

class CreatingTasksController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  LatLng? pickedLocation;
  final TextEditingController subTaskIconController = TextEditingController();
  final TextEditingController subTaskTimerController = TextEditingController();
  final TextEditingController subTaskMainTaskIdController =
      TextEditingController();
  Color selectedColor = AppColor.backgroundbutton;
  List<Widget> subTaskWidgets = [];
  MyServices myServices = Get.put(MyServices());
  void pickLocation() async {
    final result = await Navigator.of(Get.context!).push(
      MaterialPageRoute(builder: (context) => PickingPosMap()),
    );

    if (result != null && result is LatLng) {
      pickedLocation = result;
      update();
    }
  }

  Future<void> createMainTask() async {
    if (pickedLocation == null) return;
    var token =
        myServices.sharedPreferences.getString(SharedPreferencesKeys.tokenKey);
    final response = await http.post(
      Uri.parse(AppLink.getMainTask),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        "title": titleController.text,
        "description": descriptionController.text,
        "lat": pickedLocation!.latitude.toString(),
        "lng": pickedLocation!.longitude.toString(),
      }),
    );

    if (response.statusCode == 200) {
      // Fetch the city name from the coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
          pickedLocation!.latitude, pickedLocation!.longitude);
      String cityName = placemarks.first.locality ?? 'Unknown City';

      print('City: $cityName');

      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('Main task created successfully.')),
      );
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('Failed to create main task.')),
      );
    }
  }

  Future<void> createSubTask() async {
    if (pickedLocation == null) return;
    var token =
        myServices.sharedPreferences.getString(SharedPreferencesKeys.tokenKey);
    final response = await http.post(
      Uri.parse(AppLink.getSubTask),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        "icon": "string",
        "timer": subTaskTimerController.text,
        "color": '#${selectedColor.value.toRadixString(16).substring(2)}',
        "mainTaskId": int.parse(subTaskMainTaskIdController.text),
        "lat": pickedLocation!.latitude.toString(),
        "lng": pickedLocation!.longitude.toString(),
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('Sub-task created successfully.')),
      );
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('Failed to create sub-task.')),
      );
    }
  }

  void pickColor(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              color: selectedColor,
              onColorChanged: (color) {
                selectedColor = color;
                update();
              },
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Select'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void pickTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      subTaskTimerController.text = pickedTime.format(context);
      update();
    }
  }

  void addSubTaskWidget() {
    subTaskWidgets.add(_buildSubTaskWidget());
    update();
  }

  Widget _buildSubTaskWidget() {
    return Column(
      children: [
        _buildTextField(subTaskIconController, 'Sub Task Title'),
        SizedBox(height: 20),
        _buildTextField(subTaskTimerController, 'Sub Task Timer'),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildElevatedButton(
              onPressed: () => pickTime(Get.context!),
              text: 'Pick Time',
            ),
            SizedBox(width: 16),
            _buildElevatedButton(
              onPressed: () => pickColor(Get.context!),
              text: 'Pick Color',
            ),
          ],
        ),
        SizedBox(height: 20),
        _buildTextField(
          subTaskMainTaskIdController,
          'Main Task ID',
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 16),
        _buildElevatedButton(
          onPressed: createSubTask,
          text: 'Create Sub Task',
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
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
