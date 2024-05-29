import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/constant/color.dart';
import '../../in_one_to_one_chat/view/in_one_to_one_chat_page.dart';
import '../controller/one_to_one_main_screen_controller.dart';

class OneToOneChatItem extends StatelessWidget {
  const OneToOneChatItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OneToOneChatMainScreenController>(
      init: OneToOneChatMainScreenController(),
      builder: (controller) {
        return controller.isLoading == true
            ? Center(
                child: CircularProgressIndicator(
                  color: AppColor.appColor,
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.ChatsList.length,
                itemBuilder: (context, index) {
                  var chat = controller.ChatsList[index];
                  return GestureDetector(
                    onTap: () {
                      String userId = controller.ChatsList[index].userId;
                       String userName = controller.ChatsList[index].userName;
                      Get.to(InChatScreen(userId: userId, userName: userName));
                    },
                    child: ListTile(
                      title: Text(chat.userName ?? "User"),
                      subtitle: Text(chat.message ?? "Message"),
                      trailing: Text(chat.messageTime ?? ""),
                    ),
                  );
                },
              );
      },
    );
  }
}
