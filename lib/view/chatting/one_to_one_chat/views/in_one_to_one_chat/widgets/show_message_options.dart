// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:time_status/core/constant/color.dart';
// import 'package:time_status/data/model/Message.dart';
// import 'package:time_status/view/chatting/one_to_one_chat/views/in_one_to_one_chat/controller/favorite_message_controller.dart';
// import 'package:time_status/view/chatting/one_to_one_chat/views/in_one_to_one_chat/controller/pin_message_controller.dart';

// import '../../../../../splash/screen/widgets/custom_text.dart';

// void showMessageOptions(
//     Message message, BuildContext context, Offset tapPosition) async {
//   final PinMessageController pinMessageController =
//       Get.put(PinMessageController());
//   final FavMessageController favMessageController =
//       Get.put(FavMessageController());
//   final RenderBox overlay =
//       Overlay.of(context).context.findRenderObject() as RenderBox;
//   final RelativeRect position = RelativeRect.fromRect(
//     Rect.fromPoints(
//       tapPosition,
//       tapPosition,
//     ),
//     Offset.zero & overlay.size,
//   );

//   await showMenu(
//     color: AppColor.black55,
//     context: context,
//     position: position,
//     items: [
//       //! pinneed butttonnnn
//       PopupMenuItem(
//         child: Row(
//           children: [
//             const CustomText(text: 'Pin', color: AppColor.white),
//             const Spacer(),
//             IconButton(
//               onPressed: () {
//                 pinMessageController.pinMessage(message.id!);
//               },
//               icon: const Icon(Icons.forward_5_outlined),
//               color: AppColor.oranegapp,
//             )
//           ],
//         ),
//       ),
//       PopupMenuItem(
//         child: Row(
//           children: [
//             const CustomText(text: 'Favorites', color: AppColor.white),
//             const Spacer(),
//             IconButton(
//               onPressed: () {
//                 // _addToCategory(context, message);
//                 favMessageController.favMessage(message.id!);
//               },
//               icon: const Icon(Icons.favorite),
//               color: AppColor.oranegapp,
//             )
//           ],
//         ),
//         onTap: () {
//           // print('Added to Favorites: ${message.text}');
//         },
//       ),
//       PopupMenuItem(
//         child: Row(
//           children: [
//             const CustomText(text: 'Forward', color: AppColor.white),
//             const Spacer(),
//             IconButton(
//               onPressed: () {},
//               icon: const Icon(Icons.forward_5_outlined),
//               color: AppColor.oranegapp,
//             )
//           ],
//         ),
//         onTap: () {
//           // Implement logic to add the message to favorites
//           // print('Added to Favorites: ${message.text}');
//         },
//       ),
//       // Add more options as needed
//     ],
//     elevation: 8.0,
//   );
// }
