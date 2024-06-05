import 'dart:async';
import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:time_status/core/app_export.dart';
import 'package:time_status/view/map/controller/mapcontroller.dart';
import 'package:time_status/view/map/model/get_main_task.dart';
import 'package:time_status/view/splash/screen/widgets/custom_text.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final MainTaskController mainTaskController = Get.put(MainTaskController());

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(21.5303919, 39.1608216),
    zoom: 14.999,
  );

  List<Marker> markers = [];
  Set<Circle> circles = {};

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final List<MapType> _mapTypes = [
    MapType.normal,
    MapType.satellite,
    MapType.hybrid,
    MapType.terrain,
  ];
  MapType _currentMapType = MapType.normal;

  @override
  void initState() {
    super.initState();
    _fetchMainTasks();
  }

  Future<void> _fetchMainTasks() async {
    try {
      await mainTaskController.fetchMainTasks();
      setState(() {
        _addTaskMarkersAndCircles();
      });
    } catch (e) {
      print("Error fetching tasks: $e");
    }
  }

  void _addTaskMarkersAndCircles() {
    markers.clear();
    circles.clear();
    for (var task in mainTaskController.mainTasks) {
      if (task.lat != null && task.lng != null) {
        try {
          final double lat = double.parse(task.lat!);
          final double lng = double.parse(task.lng!);

          final markerId = MarkerId(task.id.toString());
          markers.add(Marker(
            markerId: markerId,
            position: LatLng(lat, lng),
            infoWindow: InfoWindow(
              onTap: () => _onCircleTapped(task),
              title: task.title,
              snippet: task.description,
            ),
          ));

          circles.add(Circle(
            circleId: CircleId(markerId.value),
            center: LatLng(lat, lng),
            radius: 100.0,
            fillColor: Colors.blue.withOpacity(0.3),
            strokeColor: Colors.blue,
            strokeWidth: 2,
            onTap: () {
              _onCircleTapped(task);
            },
          ));
        } catch (e) {
          print("Error parsing latitude or longitude: $e");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: const Color(0XFFfafafe),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            GoogleMap(
              mapType: _currentMapType,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: markers.toSet(),
              circles: circles,
              onTap: (LatLng latLng) {
                _showMarkerInfoDialog(latLng);
              },
              onLongPress: (LatLng latLng) {
                _onMapTapped(latLng);
              },
            ),
            Positioned(
              top: 56.0,
              right: 16.0,
              child: DropdownButton<MapType>(
                value: _currentMapType,
                items: _mapTypes.map((MapType mapType) {
                  return DropdownMenuItem<MapType>(
                    value: mapType,
                    child: Text(mapType.toString().split('.')[1],
                        style: const TextStyle(
                            color: AppColor.appColor,
                            fontWeight: FontWeight.bold)),
                  );
                }).toList(),
                onChanged: (MapType? newMapType) {
                  if (newMapType != null) {
                    setState(() {
                      _currentMapType = newMapType;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onMapTapped(LatLng tappedPoint) {
    const double tapCircleRadius = 20.0;

    try {
      final tappedCircle = circles.firstWhere(
        (circle) {
          final double distance = calculateDistance(
            tappedPoint.latitude,
            tappedPoint.longitude,
            circle.center.latitude,
            circle.center.longitude,
          );
          return distance <= circle.radius + tapCircleRadius;
        },
      );

      // Use _onCircleTapped if a circle is found
      final taskId = int.parse(tappedCircle.circleId.value);
      final tappedTask =
          mainTaskController.mainTasks.firstWhere((task) => task.id == taskId);
      _onCircleTapped(tappedTask);
    } catch (e) {
      // No circle found or error occurred
      print("No circle found or error: $e");
    }
  }

  void _onCircleTapped(MainTask tappedTask) {
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.info,
      body: Column(
        children: [
          const Text('Task Details'),
          const SizedBox(height: 10),
          Text('Title: ${tappedTask.title ?? 'No Title'}'),
          Text('Description: ${tappedTask.description ?? 'No Description'}'),
          const SizedBox(height: 10),
          const Text('Sub-Tasks:'),
          ListView.builder(
            shrinkWrap: true,
            itemCount: tappedTask.tasks?.length ?? 0,
            itemBuilder: (context, index) {
              final subTask = tappedTask.tasks![index];
              final title = subTask['icon'] ?? 'No Title';
              final description = subTask['timer'] ?? 'No Description';
              return ListTile(
                title: Text(title),
                subtitle: Text(description),
              );
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              _showAddSubTaskDialog(
                  tappedTask.id!, tappedTask.lat!, tappedTask.lng!);
            },
            child: const Text('Add Sub-Task'),
          ),
        ],
      ),
      btnOkOnPress: () {},
    ).show();
  }

  void _showAddSubTaskDialog(int mainTaskId, String lat, String lng) {
    TextEditingController subTaskIconController = TextEditingController();
    TextEditingController subTaskHourController = TextEditingController();
    TextEditingController subTaskMinuteController = TextEditingController();
    Rx<Color> selectedColor = AppColor.backgroundbutton.obs; // Using Rx<Color>
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.info,
      body: Column(
        children: [
          const Text('Add Sub-Task'),
          const SizedBox(height: 10),
          TextFormField(
            controller: subTaskIconController,
            decoration: const InputDecoration(labelText: 'Sub task title'),
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: subTaskHourController,
                  decoration: InputDecoration(
                    labelText: 'Hour',
                    suffix: Text(':'),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: subTaskMinuteController,
                  decoration: const InputDecoration(labelText: 'Minute'),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          CustomText(
            text: "Pick a color for the sub task :",
          ),
          Obx(() => ColorPicker(
                color: selectedColor.value,
                onColorChanged: (Color color) {
                  selectedColor.value = color;
                },
                width: 34,
                height: 34,
                borderRadius: 15,
                spacing: 10,
                runSpacing: 8,
                elevation: 1,
                hasBorder: true,
                onColorChangeEnd: (Color color) {
                  selectedColor.value = color;
                },
              )),
        ],
      ),
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        // Pad hour and minute with leading zeros if necessary
        String hour = subTaskHourController.text.padLeft(2, '0');
        String minute = subTaskMinuteController.text.padLeft(2, '0');
        String formattedTimer = '$hour:$minute:00';
        mainTaskController.createSubTask(
          mainTaskId: mainTaskId,
          icon: subTaskIconController.text,
          timer: formattedTimer,
          color:
              '#${selectedColor.value.value.toRadixString(16).padLeft(8, '0')}',
          lat: double.parse(lat),
          lng: double.parse(lng),
        );
      },
    ).show();
  }

  double calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const R = 6371.0;

    final latDistance = radians(lat2 - lat1);
    final lonDistance = radians(lon2 - lon1);

    final a = sin(latDistance / 2) * sin(latDistance / 2) +
        cos(radians(lat1)) *
            cos(radians(lat2)) *
            sin(lonDistance / 2) *
            sin(lonDistance / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    final distance = R * c * 1000;
    return distance;
  }

  double radians(double degree) {
    return degree * (pi / 180);
  }

  void _showMarkerInfoDialog(LatLng latLng) {
    AwesomeDialog(
      btnOkText: 'Create New Task',
      btnCancelOnPress: () {},
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.question,
      body: Column(
        children: [
          const Text('Create Task'),
          const SizedBox(height: 10),
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Place Name'),
          ),
          TextFormField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
        ],
      ),
      btnOkOnPress: () {
        setState(() {
          final MarkerId markerId = MarkerId(markers.length.toString());
          markers.add(Marker(
            markerId: markerId,
            position: latLng,
            infoWindow: InfoWindow(
              title: titleController.text,
              snippet: descriptionController.text,
            ),
          ));

          circles.add(
            Circle(
              circleId: CircleId(markerId.value),
              center: latLng,
              radius: 100.0,
              fillColor: Colors.blue.withOpacity(0.3),
              strokeColor: Colors.blue,
              strokeWidth: 2,
            ),
          );
        });
      },
    ).show();
  }
}
