import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:time_status/core/constant/color.dart';
import 'package:time_status/view/chatting/screens/chat_inner_screen/chat_inner_screen.dart';
import 'package:time_status/data/model/chat_model.dart';
import 'package:time_status/view/chatting/screens/chats_screen/widgets/stacked_widgets.dart';
import 'package:time_status/view/chatting/screens/details/page.dart';
import '../../../../../core/utils/math_utils.dart';

class ItemWidget extends StatelessWidget {
  final ChatModel item;

  const ItemWidget(this.item, {Key? key}) : super(key: key);

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
            color: AppColor.whiteA700,
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>  ChatInnerScreen()));
                },
                title: Text(
                  "user1",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: AppColor.black,
                    fontSize: 15,
                    fontFamily: 'General Sans',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  "how are you",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: AppColor.grayColor,
                    fontSize: 15,
                    fontFamily: 'General Sans',
                    fontWeight: FontWeight.w500,
                  ),
                ),

                trailing:Text(
                  "2:32 PM",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: AppColor.grayColor,
                    fontSize: 15,
                    fontFamily: 'General Sans',
                    fontWeight: FontWeight.w500,
                  ),
                ) ,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
