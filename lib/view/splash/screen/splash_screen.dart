import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:time_status/view/splash/controller/splash_controller.dart';
import 'package:time_status/view/splash/screen/widgets/logo_title.dart';
import '../../../core/constant/color.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget buildIndicator({required int activeIndex}) =>
      AnimatedSmoothIndicator(
        count: 5,
        activeIndex: activeIndex,
        effect:  SlideEffect(
          spacing: 8.0,
          radius: 50,
          dotWidth: 20.0,
          dotHeight: 20.0,
          paintStyle: PaintingStyle.fill,
          strokeWidth: 1.5,
          activeDotColor: AppColor.appgreen,
          dotColor: AppColor.appColor,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.white,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const LogoAndTitle(),
              const SizedBox(height: 40),
              Obx(() {
                return buildIndicator(
                    activeIndex: controller.activeIndex.value);
              }),
            ],
          )),
    );
  }
}
