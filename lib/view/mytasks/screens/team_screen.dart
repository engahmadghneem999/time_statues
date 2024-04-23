import 'package:flutter/material.dart';
import 'package:time_status/widget/custom_card.dart';
import 'package:time_status/widget/custom_text_form_filed.dart';

import '../../../core/constant/color.dart';

class MyTasks extends StatefulWidget {
  const MyTasks({Key? key}) : super(key: key);

  @override
  State<MyTasks> createState() => _MyTasksState();
}

class _MyTasksState extends State<MyTasks> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 60,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          backgroundColor: AppColor.appbargreen,
          centerTitle: true,
          title: const Text(
            "My Tasks",
            style: TextStyle(fontFamily: "Signatra", fontSize: 20),
          ),
     ),
      body:  SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 12,
              ),
              child: Column(
                children: [
                   CustomTextForm(
                    keyboardType: TextInputType.text,
                    hintText: "ابحث هنا",
                    iconPrefixData: Icons.search,
                    // iconPrefixColor: AppColor.darkCardTitle,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return CustomCard(
                          titleForm: "نص تجريبي لعنوان المهمة",
                          date: "2-2-2023",
                          dayRemaining: "3",
                          colorDivider: AppColor.appColor,
                          buttonText: "تعبئة",
                          buttonColor: AppColor.appBlueColor,
                          onPressed: () {

                          }
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
