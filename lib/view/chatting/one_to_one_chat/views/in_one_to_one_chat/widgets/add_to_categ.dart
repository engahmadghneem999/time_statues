// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// import '../../../../../../data/model/Message.dart';

// void addToCategory(BuildContext context, Message message) {
//     TextEditingController categoryController = TextEditingController();

//     List<String> categories = categoryMessages.keys.toList();
//     List<bool> categoryCheckBoxes =
//         List.generate(categories.length, (index) => false);

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Add to Category'),
//           content: StatefulBuilder(
//             builder: (BuildContext context, StateSetter setState) {
//               return Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   TextField(
//                     controller: categoryController,
//                     decoration:
//                         const InputDecoration(labelText: 'New Category Name'),
//                   ),
//                   const SizedBox(height: 10),
//                   for (int i = 0; i < categories.length; i++)
//                     Row(
//                       children: [
//                         Checkbox(
//                           value: categoryCheckBoxes[i],
//                           onChanged: (value) {
//                             setState(() {
//                               categoryCheckBoxes[i] = value!;
//                             });
//                           },
//                         ),
//                         Text(categories[i]),
//                       ],
//                     ),
//                 ],
//               );
//             },
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 String newCategory = categoryController.text;
//                 if (newCategory.isNotEmpty) {
//                   _addMessageToCategory(newCategory, message, context);
//                 }
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Create a New Category'),
//             ),
//             TextButton(
//               onPressed: () {
//                 for (int i = 0; i < categories.length; i++) {
//                   if (categoryCheckBoxes[i]) {
//                     _addMessageToCategory(categories[i], message, context);
//                   }
//                 }

//                 Navigator.of(context).pop();
//               },
//               child: const Text('Add to Selected Categories'),
//             ),
//           ],
//         );
//       },
//     );
//   }
