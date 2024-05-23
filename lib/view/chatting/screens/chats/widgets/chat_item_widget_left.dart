import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:time_status/core/constant/color.dart';
import 'package:time_status/data/model/model_chat.dart';
import 'package:time_status/view/chatting/screens/chat_inner_screen/chat_inner_screen.dart';
import 'package:time_status/data/model/chat_model.dart';
import 'package:time_status/view/chatting/screens/details/page.dart';
import '../../../../../core/utils/math_utils.dart';

class ItemWidgetLeft extends StatelessWidget {
  final ModelChat modelChat;

  const ItemWidgetLeft(this.modelChat, {super.key});



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => const DetailsPage())),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Container(
          margin: EdgeInsets.only(
            top: getVerticalSize(2.0),
            bottom: getVerticalSize(2.0),
          ),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColor.red300,
            borderRadius: BorderRadius.circular(
              getHorizontalSize(
                12,
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Gap(16),
              ListTile(
                leading: CircleAvatar(
                  child: Image.asset('assets/images/user.png'),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {

                    return ChatInnerScreen(userId: modelChat.userId,);
                  }));
                  print(" modelChat.userId,${ modelChat.userId}");
                },
                title: Text(
                  modelChat.userName ?? "user",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: AppColor.black,
                    fontSize: 15,
                    fontFamily: 'General Sans',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  modelChat.message ?? "message",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: AppColor.grayColor,
                    fontSize: 15,
                    fontFamily: 'General Sans',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: Text(
                  //  "ببب",
                  DateFormat.yMMMd()
                      .format(modelChat.messageTime ?? DateTime.now())
                      .toString(),
                  // "${modelChat.messageTime.toString()} PM",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: AppColor.grayColor,
                    fontSize: 15,
                    fontFamily: 'General Sans',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
