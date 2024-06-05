import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:time_status/view/mytasks/model/my_tasks_model.dart';

class TaskCard extends StatelessWidget {
  final TasksModel task;

  TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title ?? 'No Title',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(task.description ?? 'No Description'),
            const SizedBox(height: 8),
            FutureBuilder(
              future: getAddress(double.parse(task.lat ?? '0.0'),
                  double.parse(task.lng ?? '0.0')),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasData) {
                  return Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.redAccent),
                      const SizedBox(width: 4),
                      Text('Location: ${snapshot.data}'),
                    ],
                  );
                }
                return const Text('Location: Unknown');
              },
            ),
            const SizedBox(height: 8),
            const Divider(),
            const Text(
              'Sub-tasks:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Column(
              children: task.tasks
                      ?.map((subTask) => SubTaskCard(subTask: subTask))
                      .toList() ??
                  [],
            ),
          ],
        ),
      ),
    );
  }

  Future<String> getAddress(double? lat, double? lng) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(lat ?? 0.0, lng ?? 0.0);
      String cityName = placemarks.first.locality ?? 'Unknown City';
      return cityName;
    } catch (e) {
      print('Error fetching address: $e');
      return 'Unknown';
    }
  }
}

class SubTaskCard extends StatelessWidget {
  final Tasks subTask;

  SubTaskCard({required this.subTask});

  @override
  Widget build(BuildContext context) {
    Color _getColorFromHex(String hexColor) {
      hexColor = hexColor.replaceAll("#", "");
      try {
        return Color(int.parse("FF$hexColor", radix: 16));
      } catch (e) {
        print('Error parsing hex color: $e');
        return Colors.grey; // Return a default color in case of error
      }
    }

    Color subTaskColor = subTask.color != null && subTask.color!.isNotEmpty
        ? _getColorFromHex(subTask.color!)
        : Colors
            .white; // Display white color if the API color is not valid or null
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 2.0,
      color: subTaskColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   children: [
            //     Icon(Icons.label, color: Colors.blueAccent),
            //     SizedBox(width: 4),
            //     Text('Icon: ${subTask.icon ?? 'N/A'}'),
            //   ],
            // ),
            Row(
              children: [
                Icon(Icons.timer, color: Colors.orangeAccent),
                SizedBox(width: 4),
                Text('Timer: ${subTask.timer ?? 'N/A'}'),
              ],
            ),
            // Row(
            //   children: [
            //     Icon(Icons.color_lens, color: Colors.purpleAccent),
            //     SizedBox(width: 4),
            //     Text('Color: ${subTask.color ?? 'N/A'}'),
            //   ],
            // ),
            // Row(
            //   children: [
            //     Icon(Icons.check_circle, color: Colors.greenAccent),
            //     SizedBox(width: 4),
            //     Text('Status: ${subTask.status ?? 'N/A'}'),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
