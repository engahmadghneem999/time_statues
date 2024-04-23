import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_status/core/constant/routes.dart';
import 'package:time_status/core/service/service.dart';
import 'package:time_status/core/utils/language/lang_translation.dart';
import 'package:time_status/core/utils/language/language_controller.dart';
import 'package:time_status/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  MyServices();
  runApp(
    MyApp(),
  );
}
class MyApp extends StatelessWidget {
  MyApp({super.key});
  final LanguageController _languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: LangTranslation(),
      locale:  _languageController.selectedLanguage ==
          'en_US'
          ? const Locale("en_US"):const Locale("ar_SA"),
      debugShowCheckedModeBanner: false,
      title: 'Time Status',
      initialBinding: BindingsBuilder(() {
      }),

      initialRoute: AppRoute.splash,
      getPages: routes,

    );
  }
}
