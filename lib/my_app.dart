import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:time_status/core/constant/routes.dart';
import 'package:time_status/core/utils/language/lang_translation.dart';
import 'package:time_status/core/utils/language/language_controller.dart';
import 'package:time_status/routes.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final LanguageController _languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: GetMaterialApp(
        translations: LangTranslation(),
        locale: _languageController.selectedLanguage == 'en_US'
            ? const Locale("en_US")
            : const Locale("ar_SA"),
        debugShowCheckedModeBanner: false,
        title: 'Time Status',
        initialBinding: BindingsBuilder(() {}),
        initialRoute: AppRoute.splash,
        getPages: routes,
      ),
    );
  }
}
