import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_status/core/app_export.dart';
import 'package:time_status/view/chatting/one_to_one_chat/views/in_one_to_one_chat/controller/get_fav_controler.dart';
import 'package:intl/intl.dart';

class FavoriteMessageScreen extends StatelessWidget {
  final String userId;
  final FavoriteMessageController favoriteMessageController =
      Get.put(FavoriteMessageController());

  FavoriteMessageScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    favoriteMessageController.fetchFavoriteMessages(userId);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorite Messages",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColor.appColor,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.grey[100],
        child: Obx(() {
          if (favoriteMessageController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else if (favoriteMessageController.favoriteMessages.isEmpty) {
            return Center(
              child: Text(
                'No favorite messages',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: favoriteMessageController.favoriteMessages.length,
              itemBuilder: (context, index) {
                final message =
                    favoriteMessageController.favoriteMessages[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.0),
                    leading: CircleAvatar(
                      backgroundColor: AppColor.appbargreen,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    title: Text(
                      message.text ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        Text(
                          'From: ${message.sender}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 4),
                      ],
                    ),
                    trailing: Icon(Icons.favorite, color: Colors.red),
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}
