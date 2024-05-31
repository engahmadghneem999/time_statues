// ignore_for_file: avoid_print

import 'dart:async';

import 'package:get/get.dart';

import '../../../core/constant/routes.dart';
import '../../../core/constant/shared_preferences_keys.dart';
import '../../../core/service/service.dart';
import '../../../widget/bottom_nav_bar.dart';

class SplashController extends GetxController {
  MyServices myServices = Get.find();
  // var user;
  late Timer _timer;
  RxInt activeIndex = 0.obs;
  bool forward = true;
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (forward) {
        activeIndex++;
      } else {
        activeIndex--;
      }
      if (activeIndex == 5) {
        forward = false;
        if (myServices.sharedPreferences
                .getBool(SharedPreferencesKeys.isLoginKey) ==
            true) {
          Get.to( CustomBottomNavigationBar());
        } else {
          Get.toNamed(AppRoute.logIn);
        }
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    startTimer();


  }

  @override
  void onReady() async {

  }
  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
