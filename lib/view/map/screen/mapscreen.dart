import 'dart:async';
import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:time_status/core/app_export.dart';
import 'package:time_status/view/map/controller/mapcontroller.dart';
import 'package:time_status/view/mytasks/screens/team_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key); // Fix the key parameter

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final TaskController taskController = Get.put(TaskController());

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(21.5303919, 39.1608216),
    zoom: 14.999,
  );

  List<Marker> markers = [];
  Set<Circle> circles = {};

  TextEditingController titletaskController = TextEditingController();
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
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    try {
      await taskController.fetchMainTasks();
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
    for (var task in taskController.mainTasks) {
      if (task.lat != null && task.lng != null) {
        try {
          final double lat = double.parse(task.lat!);
          final double lng = double.parse(task.lng!);

          final markerId = MarkerId(task.id.toString());
          markers.add(Marker(
            markerId: markerId,
            position: LatLng(lat, lng),
            infoWindow: InfoWindow(
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
          ));
        } catch (e) {
          print("Error parsing latitude or longitude: $e");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double widtht = MediaQuery.of(context).size.width;
    double heightt = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: widtht,
        height: heightt,
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

    _onCircleTapped(tappedCircle);
  }

  void _onCircleTapped(Circle tappedCircle) {
    double newRadius = tappedCircle.radius;

    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.info,
      body: Column(
        children: [
          const Text('Update Circle Diameter'),
          const SizedBox(height: 10),
          SleekCircularSlider(
            min: 0,
            max: 1000,
            initialValue: tappedCircle.radius * 2,
            onChange: (double value) {
              setState(() {
                newRadius = value / 2;
              });
            },
            innerWidget: (double value) {
              return Center(
                child: Text(
                  '${NumberFormat.decimalPattern().format(value)} متر',
                  style: TextStyle(fontSize: 16.0),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              setState(() {
                circles.removeWhere(
                    (circle) => circle.circleId == tappedCircle.circleId);
                circles.add(
                  Circle(
                    circleId: tappedCircle.circleId,
                    center: tappedCircle.center,
                    radius: newRadius,
                    fillColor: Colors.blue.withOpacity(0.3),
                    strokeColor: Colors.blue,
                    strokeWidth: 2,
                  ),
                );
              });
              Navigator.of(context).pop();
            },
            child: const Text('Update Diameter'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Add your functionality here
            },
            child: const Text('Show Task'),
          ),
          const SizedBox(height: 10),
        ],
      ),
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

  _showMarkerInfoDialog(LatLng latLng) {
    return AwesomeDialog(
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
            controller: titletaskController,
            decoration: const InputDecoration(labelText: 'Place Name'),
          ),
          TextFormField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              _createTaskAndAddMarker(
                  latLng); // Call method to create task and add marker
              Navigator.of(context).pop();
            },
            child: const Text('Add Marker'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const MyTasks()),
              );
            },
            child: const Text('Show My Tasks'),
          ),
        ],
      ),
    )..show();
  }

  Future<void> _createTaskAndAddMarker(LatLng latLng) async {
    try {
      showLoadingDialog(); // Show loading dialog
      await taskController.createTask(
        // Create task using TaskController
        titletaskController.text,
        descriptionController.text,
        latLng.latitude.toString(),
        latLng.longitude.toString(),
      );

      // Add marker and circle for the newly created task
      setState(() {
        final MarkerId markerId = MarkerId(markers.length.toString());
        markers.add(Marker(
          markerId: markerId,
          position: latLng,
          infoWindow: InfoWindow(
            title: titletaskController.text,
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

      Navigator.of(context).pop(); // Close loading dialog
    } catch (e) {
      // Show error dialog if task creation fails
      Navigator.of(context).pop();
      showErrorDialog('Failed to create task');
    }
  }

  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void showErrorDialog(String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      body: Text(message),
    )..show();
  }
}
