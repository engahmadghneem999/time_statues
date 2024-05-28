import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_status/view/chatting/one%20to%20one%20chat/controller/chat_controller.dart';
import 'package:time_status/view/chatting/one%20to%20one%20chat/views/chats/widgets/chats_item_widget.dart';
import '../../../../../core/constant/color.dart';

class Chats extends StatelessWidget {
  Chats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.fromHex('#EDE7FF'),
      body: GetBuilder<ChatController>(
          init: ChatController(),
          builder: (controller) {
            return controller.isLoading == true
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColor.appColor,
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.modelChatList.length,
                    itemBuilder: (context, index) {
                      final item = controller.modelChatList[index];
                      return ItemWidget(
                        item,
                      );
                    },
                  );
          }),
    );
  }
}
