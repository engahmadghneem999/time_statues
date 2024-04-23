import 'package:flutter/material.dart';

import '../../../splash/screen/widgets/custom_text.dart';


class LanguageButtonChoice extends StatelessWidget {
  const LanguageButtonChoice({
    Key? key,
    required this.text,
    required this.buttonColor,
    required this.onPressed,
    required this.langText,
    required this.colorLangText,
  }) : super(key: key);
  final String text;
  final Color buttonColor;
  final void Function() onPressed;
  final String langText;
  final Color colorLangText;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: buttonColor,
            ),
            child: Center(
              child: CustomText(
                text: langText,
                color: colorLangText,
                alignment: Alignment.center,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 10),
          CustomText(
              text: text,
              fontSize: 17,
              textAlign: TextAlign.center,
            ),

        ],
      ),
    );
  }
}
