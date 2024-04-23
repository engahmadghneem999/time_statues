import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  String selectedLanguage = 'ar_SA';
  TextDirection txtDirection = TextDirection.rtl;

  void changeLanguage(String languageCode) {
    selectedLanguage = languageCode;
    Get.updateLocale(Locale(languageCode));
    if (languageCode == 'en_US') {
      txtDirection = TextDirection.ltr;
    } else {
      txtDirection = TextDirection.rtl;
    }
    update();
  }
}
