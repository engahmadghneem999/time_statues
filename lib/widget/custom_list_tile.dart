import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constant/color.dart';
import '../core/constant/image_assets.dart';
import '../core/utils/language/language_controller.dart';
import 'custom_text.dart';

class CustomListTile extends StatelessWidget {
  CustomListTile({
    Key? key,
    required this.imageIcon,
    required this.text,
    required this.isLeading,
    this.onPressed,
    required this.textLanguage,
  }) : super(key: key);

  final String imageIcon;
  final String text;
  final bool isLeading;
  final void Function()? onPressed;
  final String textLanguage;
  final LanguageController _languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 5,
        ),
        margin: const EdgeInsets.symmetric(vertical: 10),
        color: AppColor.appgreen,
        child: Row(
          mainAxisAlignment: _languageController.selectedLanguage == 'en_US'
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
          children: [
            isLeading
                ? Row(
                    mainAxisAlignment:
                        _languageController.selectedLanguage == 'en_US'
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                    children: [
                      Image.asset(AppImageAsset.logo),
                      const SizedBox(width: 5),
                      CustomText(
                        text: textLanguage,
                      ),
                    ],
                  )
                : Container(),
            const Spacer(),
            CustomText(
              text: text,
            ),
            const SizedBox(width: 10),
            Image.asset(imageIcon),
          ],
        ),
      ),
    );
  }
}
