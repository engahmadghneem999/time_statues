import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constant/color.dart';
import '../../../../core/constant/image_assets.dart';
import '../../../../core/utils/language/language_controller.dart';
import '../../../../widget/custom_text.dart';
import 'language_button.dart';

class ChangeLanguageBottomSheet extends StatelessWidget {
  final LanguageController _languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(
          mainAxisAlignment: _languageController.selectedLanguage == "en_US"
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Image.asset(
                AppImageAsset.arrowBackIcon,
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.3),
            Row(children: [
              CustomText(
                text: "change_language".tr,
                fontSize: 18,
                color: AppColor.grayColor,
              ),
              SizedBox(width: 10),
              Icon(
                Icons.language,
                color: AppColor.grayColor,
              ),
            ]),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.065),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            LanguageButtonChoice(
              text: 'english'.tr,
              buttonColor: _languageController.selectedLanguage == 'en_US'
                  ? AppColor.oranegapp
                  : AppColor.fillTextFormGray,
              onPressed: () {
                _languageController.changeLanguage("en_US");
                Get.back();
                print(
                    "language press 222 = ${_languageController.selectedLanguage}");
              },
              colorLangText: _languageController.selectedLanguage == 'en_US'
                  ? Colors.white
                  : AppColor.grayColor,
              langText: 'E',
            ),
            LanguageButtonChoice(
              text: 'arabic'.tr,
              buttonColor: _languageController.selectedLanguage == 'ar_SA'
                  ? AppColor.oranegapp
                  : AppColor.fillTextFormGray,
              langText: 'AR',
              colorLangText: _languageController.selectedLanguage == 'ar_SA'
                  ? Colors.white
                  : AppColor.grayColor,
              onPressed: () {
                _languageController.changeLanguage('ar_SA');
                Get.back();
                print(
                    "language press 111= ${_languageController.selectedLanguage}");
              },
            ),
          ],
        )
      ]),
    );
  }
}
