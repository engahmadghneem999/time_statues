import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
          child: Column(
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.push_pin,
                    size: 20.h,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Pinned messages:'.tr,
                    style: TextStyle(fontSize: 15),
                  ),
                  Container(
                    height: 30.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: getPinMessageController.pinnedMessages.length,
                      itemBuilder: (context, index) {
                        final pinnedMessage =
                            getPinMessageController.pinnedMessages[index];
                        return Row(
                          children: [
                            SizedBox(width: 10.w),
                            Text(
                              pinnedMessage.text,
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
              // Divider(color: AppColor.appbargreen),
            ],
          ),
        );
      }
    });
  }
}
