import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:time_status/widget/custom_text.dart';

import '../../../../core/constant/color.dart';
import '../../../../core/constant/image_assets.dart';

class LogoAndTitle extends StatelessWidget {
  const LogoAndTitle({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
         AppImageAsset.logo,
          width: 300,
          height: 200,
        ),
        const CustomText(
          text: "AppName",
          alignment: Alignment.center,
          fontWeight: FontWeight.bold,
          color: AppColor.appColor,
          fontSize: 22,
        ),
        const CustomText(
          text: "Manegmant Time",
          alignment: Alignment.center,
        ),
        const CustomText(
          text: "Your Day",
          alignment: Alignment.center,
        ),
      ],
    );
  }
}
