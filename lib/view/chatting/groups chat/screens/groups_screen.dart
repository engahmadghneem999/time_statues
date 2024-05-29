import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:time_status/core/app_export.dart';
import '../controller/groups_controller.dart';
import '../widgets/group_chats_items.dart';

class GroupChatsScreen extends StatelessWidget {
  const GroupChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GroupChatController controller = Get.put(GroupChatController());

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              AppColor.fromHex('#EDE7FF'),
              AppColor.fromHex('#E5EBFF'),
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const SizedBox(height: 20),
            SizedBox(
              height: getVerticalSize(40),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Search by chats',
                  hintStyle: TextStyle(
                    fontSize: getFontSize(16.0),
                    color: AppColor.bluegray400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(getHorizontalSize(8)),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getHorizontalSize(13),
                    ),
                    child: SizedBox(
                      height: getSize(20),
                      width: getSize(20),
                      child: SvgPicture.asset(
                        ImageConstant.imgIconSearch,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints(
                    minWidth: getSize(20),
                    minHeight: getSize(20),
                  ),
                  filled: true,
                  fillColor: AppColor.whiteA700,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: getVerticalSize(11.375),
                  ),
                ),
                style: TextStyle(
                  color: AppColor.bluegray400,
                  fontSize: getFontSize(16.0),
                  fontFamily: 'General Sans',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Gap(15),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: AppColor.oranegapp,
                borderRadius: BorderRadius.circular(getHorizontalSize(12)),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.deepPurpleA20066,
                    spreadRadius: getHorizontalSize(1),
                    blurRadius: getHorizontalSize(1),
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: getVerticalSize(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bust your room",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColor.whiteA700,
                            fontSize: getFontSize(24),
                            fontFamily: 'General Sans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Up to 75% more profit",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColor.whiteA700,
                            fontSize: getFontSize(14),
                            fontFamily: 'General Sans',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 13),
                        Container(
                          alignment: Alignment.center,
                          width: getHorizontalSize(185),
                          padding: EdgeInsets.symmetric(
                            horizontal: getHorizontalSize(30),
                            vertical: getVerticalSize(7.5),
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.whiteA700,
                            borderRadius: BorderRadius.circular(
                              getHorizontalSize(50),
                            ),
                          ),
                          child: Text(
                            'Try now',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColor.oranegapp,
                              fontSize: getFontSize(14),
                              fontFamily: 'SF Pro Text',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CircularPercentIndicator(
                    radius: 50.0,
                    lineWidth: getSize(10),
                    animation: true,
                    percent: 0.75,
                    backgroundColor: AppColor.fromHex('BAA1FD'),
                    center: RichText(
                      text: TextSpan(
                        children: <InlineSpan>[
                          TextSpan(
                            text: '75',
                            style: TextStyle(
                              color: AppColor.whiteA700,
                              fontSize: getFontSize(20),
                              fontFamily: 'General Sans',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: '%',
                            style: TextStyle(
                              color: AppColor.whiteA700,
                              fontSize: getFontSize(15),
                              fontFamily: 'General Sans',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: AppColor.whiteA700,
                  ),
                ],
              ),
            ),
            Obx(() {
              if (controller.chatMessages.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.chatMessages.length,
                  itemBuilder: (context, index) {
                    final item = controller.chatMessages[index];
                    return GroupChatsItemWidget(item: item);
                  },
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
