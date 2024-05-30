import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_status/core/constant/color.dart';
import 'package:time_status/view/chatting/one_to_one_chat/views/one_to_one_chatting_screen/controller/one_to_one_main_screen_controller.dart';
import 'package:time_status/view/chatting/one_to_one_chat/views/one_to_one_chatting_screen/widgets/in_one_to_one_chat_page.dart';

class OneToOneChatItem extends StatelessWidget {
  const OneToOneChatItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OneToOneChatMainScreenController>(
        init: OneToOneChatMainScreenController(),
        builder: (controller) {
          if (controller.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColor.appColor,
              ),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.ChatsList.length,
              itemBuilder: (context, index) {
                var chat = controller.ChatsList[index];
                return GestureDetector(
                  onTap: () {
                    String userId = chat.userId ?? "";
                    String userName = chat.userName ?? "";
                    Get.to(
                        () => InChatScreen(userId: userId, userName: userName));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColor.appBlueColor.withOpacity(0.5),
                        style: BorderStyle.solid,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListTile(
                      title: Text(
                        chat.userName ?? "User",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor.appBlueColor,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            chat.message ?? "Message",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: AppColor.appBlueColor),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
