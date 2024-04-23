import 'package:flutter/material.dart';

import 'package:time_status/core/constant/color.dart';

import '../view/splash/screen/widgets/custom_text.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    this.buttonColor = AppColor.black,
    this.textColor = Colors.white,
    required this.text,
    required this.isChildRow,
    required this.onPressed,
    this.iconData,
    this.padding = 10,
    this.borderColor = AppColor.black,

  }) : super(key: key);
  final Color buttonColor;
  final Color textColor;
  final String text;
  final bool isChildRow;
  final void Function() onPressed;
  final IconData? iconData;
  final double padding;
  final Color borderColor;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: onPressed,

        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: buttonColor,
          padding: EdgeInsets.all(padding),
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: borderColor,
            ),
          ),
        ),
        child: isChildRow
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: text,
                    alignment: Alignment.center,
                    fontSize: 16,
                    textAlign: TextAlign.center,
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    iconData,
                    color: AppColor.black,
                  ),
                ],
              )
            : CustomText(
                text: text,
                alignment: Alignment.center,
                fontSize: 16,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w800,
                color: textColor,
                textOverflow: TextOverflow.visible,
              ),
      ),
    );
  }
}
