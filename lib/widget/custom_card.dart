import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:time_status/widget/custom_button.dart';
import 'package:time_status/widget/divider_vertical.dart';


import '../core/constant/color.dart';
import '../core/utils/styles.dart';
import '../view/splash/screen/widgets/custom_text.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.titleForm,
    required this.date,
    required this.dayRemaining,
    required this.colorDivider,
    required this.buttonText,
    required this.buttonColor,
    required this.onPressed,
  }) : super(key: key);

  final String titleForm;
  final String date;
  final String dayRemaining;
  final Color colorDivider;
  final String buttonText;
  final Color buttonColor;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 0,
      ),
      height: 130,
      decoration: Styles.cardBoxDecoration(),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomText(
                  text: titleForm,
                  color: AppColor.appColor,
                  fontSize: 16,
                  textAlign: TextAlign.start,
                ),
                Row(
                  children: [
                    CustomText(
                      text: "منذ $date",
                      color: AppColor.appColor,
                      fontSize: 15,
                      alignment: Alignment.centerLeft,
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      FontAwesomeIcons.clock,
                      color: AppColor.appgreen,
                      size: 18,
                    ),
                    const Spacer(),
                    CustomText(
                      text: "متبقي $dayRemaining ايام",
                      color: AppColor.red300,
                      fontSize: 15,
                      alignment: Alignment.centerRight,
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                  width: 72,
                  child: CustomElevatedButton(
                    buttonColor: buttonColor,
                    borderColor: buttonColor,
                    text: buttonText,
                    isChildRow: false,
                    padding: 0,
                    onPressed: onPressed,
                  ),
                ),
              ],
            ),
          ),
          DividerVertical(
            color: colorDivider,
          ),
        ],
      ),
    );
  }
}
