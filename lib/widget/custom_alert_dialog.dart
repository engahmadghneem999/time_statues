// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_status/core/constant/color.dart';

import '../view/splash/screen/widgets/custom_text.dart';
import 'custom_button.dart';



class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    Key? key,
    required this.image,
    required this.isRow,
    this.textButton = '',
    required this.onPressedButton,
    required this.titleText,
    this.buttonColor = AppColor.appBlueColor,
  }) : super(key: key);

  final String image;
  final bool isRow;
  final String textButton;
  final void Function() onPressedButton;
  final String titleText;
  final Color buttonColor;
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      child: AlertDialog(
        actionsPadding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 10,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26),
        ),
        title: Image.asset(
          image,
          height: MediaQuery.of(context).size.height * .2,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FittedBox(
              child: CustomText(
                text: titleText,
                color: AppColor.grayColor,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 25),
            isRow
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomElevatedButton(
                        text: 'الغاء الامر',
                        isChildRow: false,
                        onPressed: () {
                          Get.back();
                        },
                        buttonColor: Colors.white,
                        textColor: AppColor.appBlueColor,
                      ),
                      CustomElevatedButton(
                        text: 'تسجيل الخروج',
                        isChildRow: false,
                        onPressed: () {},
                      ),
                    ],
                  )
                : CustomElevatedButton(
                    text: textButton,
                    isChildRow: false,
                    onPressed: onPressedButton,
                    buttonColor: buttonColor,
                    borderColor: buttonColor,
                  ),
          ],
        ),
      ),
    );
  }
}
