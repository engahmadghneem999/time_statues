import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:time_status/core/constant/color.dart';
import 'package:time_status/view/chatting/screens/chat_inner_screen/chat_inner_screen.dart';
import 'package:time_status/data/model/chat_model.dart';
import 'package:time_status/view/chatting/screens/chats_screen/widgets/stacked_widgets.dart';
import 'package:time_status/view/chatting/screens/details/page.dart';
import '../../../../../core/utils/math_utils.dart';


class ChatsItemWidget extends StatelessWidget {
  final ChatModel item;
  const ChatsItemWidget(this.item, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => const DetailsPage())),
      child: Container(
        margin: EdgeInsets.only(
          top: getVerticalSize(6.0),
          bottom: getVerticalSize(6.0),
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
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible( // Wrap the content with Flexible
                  child: StackedWidgets(
                    direction: TextDirection.rtl,
                    items: item.groupMembers,
                  ),
                ),
                const Gap(8),
                Text(
                  "+ ${item.membersCount}",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: AppColor.bluegray400,
                    fontSize: getFontSize(12),
                    fontFamily: 'General Sans',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>  ChatInnerScreen())),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                      left: getHorizontalSize(16),
                      top: getVerticalSize(8),
                      right: getHorizontalSize(16),
                      bottom: getVerticalSize(8),
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.deepPurpleA200,
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(50),
                      ),
                    ),
                    child: Text(
                      'Join',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.whiteA700,
                        fontSize: getFontSize(14),
                        fontFamily: 'SF Pro Text',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const Gap(16),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                StackedWidgets(
                  direction: TextDirection.rtl,
                  items: item.groupMembers,
                ),
                const Gap(8),
                Text(
                  "+ ${item.membersCount}",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: AppColor.bluegray400,
                    fontSize: getFontSize(
                      12,
                    ),
                    fontFamily: 'General Sans',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>  ChatInnerScreen())),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                      left: getHorizontalSize(
                        16,
                      ),
                      top: getVerticalSize(
                        8,
                      ),
                      right: getHorizontalSize(
                        16,
                      ),
                      bottom: getVerticalSize(
                        8,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.deepPurpleA200,
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(
                          50,
                        ),
                      ),
                    ),
                    child: Text(
                      'Join',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.whiteA700,
                        fontSize: getFontSize(
                          14,
                        ),
                        fontFamily: 'SF Pro Text',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
