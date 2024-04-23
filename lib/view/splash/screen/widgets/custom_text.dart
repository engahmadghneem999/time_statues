import 'package:flutter/material.dart';
import 'package:time_status/core/constant/image_assets.dart';


class CustomText extends StatelessWidget {
  final String text;

  final double fontSize;

  final FontWeight fontWeight;

  // final LanguageController _languageController = Get.put(
  //   LanguageController(),
  // );
  final Color? color;
  final TextDecoration? decoration;
  final TextAlign? textAlign;
  final String fontFamily;
  final Alignment? alignment;
  final TextOverflow textOverflow;
  const CustomText({
    super.key,
    this.text = '',
    this.fontSize = 18,
    this.color,
    this.fontWeight = FontWeight.w500,
    this.decoration,
    this.textAlign,
    this.fontFamily = AppImageAsset.fontNeoSansArabic,
    this.alignment ,
    // _languageController.selectedLanguage ==
    //     'en_US'
    //     ? Alignment.centerLeft:Alignment.centerRight,
    this.textOverflow = TextOverflow.ellipsis,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: textOverflow,
      style: TextStyle(

        decoration: decoration,
        height: 1.3,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        color: color,
      ),
    );
  }
}
