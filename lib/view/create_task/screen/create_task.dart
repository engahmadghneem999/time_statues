import 'package:flutter/material.dart';
import 'package:time_status/core/app_export.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import '../../../core/constant/image_assets.dart';
import '../../../widget/custom_alert_dialog.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_text_form_filed.dart';

class CreateTask extends StatefulWidget {
  CreateTask({
    required this.titletask,
    Key? key,
  }) : super(key: key);

  final titletask;

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  late Color screenPickerColor;
  final CountdownController _controller = CountdownController(autoStart: true);
  List<TextEditingController> filed = [];

  @override
  void initState() {
    super.initState();
    screenPickerColor = Colors.blue; // Material blue.
  }

  void _addTasks(int numberOfTasks) {
    setState(() {
      filed = List.generate(numberOfTasks, (index) => TextEditingController());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 60,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          backgroundColor: AppColor.appbargreen,
          centerTitle: true,
          title: Text(
            "${widget.titletask.toString()==''?'عنوان المهمة':'${widget.titletask.toString()}'}",
            style: TextStyle(fontFamily: "Signatra", fontSize: 20),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height * 0.99,
          decoration: BoxDecoration(
            color: screenPickerColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                ColorPicker(
                  color: screenPickerColor,
                  onColorChanged: (Color color) =>
                      setState(() => screenPickerColor = color),
                  width: 44,
                  height: 44,
                  borderRadius: 22,
                  heading: Text(
                    'Select color task',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  subheading: Text(
                    'Select color shade',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _showAddTasksDialog();
                  },
                  child: const Text('إضافة مهام'),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: AppColor.appgreen,
                  ),
                  padding: const EdgeInsets.all(12),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: filed.length,
                          itemBuilder: (context, index) {
                            return CustomTextForm(
                              controller: filed[index],
                              keyboardType: TextInputType.text,
                              hintText: 'نص',
                            );
                          },
                        ),
                        CustomElevatedButton(
                          text: "حفظ والبدء بالمهمة",
                          isChildRow: false,
                          onPressed: () {
                            _controller.start();
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setter) {
                                    return CustomAlertDialog(
                                      image: AppImageAsset.avatar,
                                      titleText:
                                      "شكرا لك , لقد تم انشاء المهمة بنجاح",
                                      onPressedButton: () {
                                        Navigator.of(context).pop();
                                      },
                                      isRow: false,
                                      textButton: "مهامي",
                                    );
                                  },
                                );
                              },
                            );
                          },
                          buttonColor: AppColor.appBlueColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAddTasksDialog() {
    TextEditingController _numberOfTasksController =
    TextEditingController(text: '1');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter the number of tasks"),
          content: TextFormField(
            controller: _numberOfTasksController,
            keyboardType: TextInputType.number,
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                int numberOfTasks = int.tryParse(_numberOfTasksController.text) ?? 1;
                _addTasks(numberOfTasks);
                Navigator.of(context).pop();
              },
              child: Text('Add Tasks'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}



// import 'package:flex_color_picker/flex_color_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:time_status/core/app_export.dart';
// import 'package:timer_count_down/timer_controller.dart';
// import 'package:timer_count_down/timer_count_down.dart';
// import '../../../core/constant/image_assets.dart';
// import '../../../widget/custom_alert_dialog.dart';
// import '../../../widget/custom_button.dart';
// import '../../../widget/custom_text_form_filed.dart';
// import '../../../widget/icon_title.dart';
//
// class CreateTask extends StatefulWidget {
//   CreateTask({
//     required this.titletask,
//     super.key,
//   });
//
//   final titletask;
//
//   @override
//   State<CreateTask> createState() => _CreateTaskState();
// }
//
// class _CreateTaskState extends State<CreateTask> {
//   late Color screenPickerColor;
//   late Color dialogPickerColor;
//   late Color dialogSelectColor;
//   final CountdownController _controller =
//       new CountdownController(autoStart: true);
//
//   late int timesec;
//
//   @override
//   void initState() {
//     super.initState();
//     screenPickerColor = Colors.blue; // Material blue.
//     dialogPickerColor = Colors.red; // Material red.
//     dialogSelectColor = const Color(0xFFA239CA); // A purple color.
//   }
//
//   List<TextEditingController> filed = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           toolbarHeight: 60,
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(
//               bottom: Radius.circular(20),
//             ),
//           ),
//           backgroundColor: AppColor.appbargreen,
//           centerTitle: true,
//           title: Text(
//             "${widget.titletask.toString()}",
//             style: TextStyle(fontFamily: "Signatra", fontSize: 20),
//           ),
//         ),
//         body: Container(
//             height: MediaQuery.of(context).size.height * 0.99,
//             decoration: BoxDecoration(
//               color: screenPickerColor,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20),
//                 topRight: Radius.circular(20),
//               ),
//             ),
//             padding: const EdgeInsets.all(16),
//             child: SingleChildScrollView(
//               child: Column(children: [
//                 const SizedBox(height: 20),
//                 ColorPicker(
//                   // Use the screenPickerColor as start color.
//                   color: screenPickerColor,
//                   // Update the screenPickerColor using the callback.
//                   onColorChanged: (Color color) =>
//                       setState(() => screenPickerColor = color),
//                   width: 44,
//                   height: 44,
//                   borderRadius: 22,
//                   heading: Text(
//                     'Select color task',
//                     style: Theme.of(context).textTheme.headlineSmall,
//                   ),
//                   subheading: Text(
//                     'Select color shade',
//                     style: Theme.of(context).textTheme.titleSmall,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       filed.add(TextEditingController());
//                     });
//                   },
//                   child: const Text('إضافة مهام'),
//                 ),
//                 const SizedBox(height: 20),
//                 Container(
//                     decoration: const BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(20),
//                         topRight: Radius.circular(20),
//                       ),
//                       color: AppColor.appgreen,
//                     ),
//                     padding: const EdgeInsets.all(12),
//                     child: SingleChildScrollView(
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           ListView.builder(
//                             shrinkWrap: true,
//                             itemCount: filed.length,
//                             itemBuilder: (context, index) {
//                               return CustomTextForm(
//
//                                 controller: filed[index],
//                                 keyboardType: TextInputType.text,
//                                 hintText: 'نص',
//                               );
//                             },
//                           ),
//                           CustomElevatedButton(
//                             text: "حفظ والبدء بالمهمة",
//                             isChildRow: false,
//                             onPressed: () {
//                               _controller.start();
//                               showDialog(
//                                   context: context,
//                                   builder: (BuildContext context) {
//                                     return StatefulBuilder(builder:
//                                         (BuildContext context,
//                                             StateSetter setter) {
//                                       return CustomAlertDialog(
//                                         image: AppImageAsset.avatar,
//                                         titleText:
//                                             "شكرا لك , لقد تم انشاء المهمة بنجاح",
//                                         onPressedButton: () {
//                                           Navigator.of(context).pop();
//                                         },
//                                         isRow: false,
//                                         textButton: "مهامي",
//                                       );
//                                     });
//                                   });
//                             },
//                             buttonColor: AppColor.appBlueColor,
//                           ),
//                         ],
//                       ),
//                     ))
//               ]),
//             )),
//       ),
//     );
//   }
// }
