import 'package:get/get.dart';
import 'package:time_status/view/splash/controller/splash_controller.dart';


class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(
      SplashController(),
    );
  }
}
