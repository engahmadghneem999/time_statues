import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:time_status/core/constant/color.dart';
import 'package:time_status/view/chatting/one_to_one_chat/views/in_one_to_one_chat/controller/get_pin_controller.dart';

class PinnedMessagesSection extends StatelessWidget {
  const PinnedMessagesSection({
    super.key,
    required this.getPinMessageController,
  });

  final GetPinMessageController getPinMessageController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (getPinMessageController.pinnedMessages.isEmpty) {
        return Container();
      } else {
        return Container(
          color: Colors.grey[200],
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Container(
                height: 40.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: getPinMessageController.pinnedMessages.length,
                  itemBuilder: (context, index) {
                    final pinnedMessage =
                        getPinMessageController.pinnedMessages[index];
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        color: AppColor.appbargreen,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          pinnedMessage.text,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }
    });
  }
}
