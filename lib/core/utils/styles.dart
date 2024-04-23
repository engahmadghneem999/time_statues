import 'package:flutter/material.dart';

import '../constant/color.dart';

class Styles {
  static RoundedRectangleBorder roundedBorderShap() {
    return const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    );
  }

  static BoxDecoration cardBoxDecoration() {
    return BoxDecoration(
      color: AppColor.appbargreen,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: AppColor.grayColor,
          blurRadius: 1,
        ),
      ],
    );
  }

  static BoxDecoration mainBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
      ),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: AppColor.white,
          blurRadius: 8,
        ),
      ],
    );
  }
}
