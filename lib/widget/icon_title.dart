import 'package:flutter/material.dart';
import '../../../../widget/custom_text.dart';

class IconTitle extends StatelessWidget {
  const IconTitle({
    Key? key,
    required this.title,
    this.colorTitle = Colors.white,
  }) : super(key: key);
  final String title;
  final Color colorTitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
        ),
        CustomText(
          text: title,
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: colorTitle,
          alignment: Alignment.center,
        )
      ],
    );
  }
}
