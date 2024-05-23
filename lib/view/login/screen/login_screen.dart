import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:time_status/core/constant/color.dart';
import 'package:time_status/core/constant/image_assets.dart';
import 'package:time_status/view/login/screen/widget/change_lang_bottom_sheet.dart';
import 'package:time_status/widget/bottom_nav_bar.dart';
import 'package:time_status/widget/custom_button.dart';
import 'package:time_status/widget/custom_text_form_filed.dart';
import 'package:time_status/widget/loading.dart';
import '../../../core/utils/language/language_controller.dart';
import '../../../core/utils/styles.dart';
import '../../splash/screen/widgets/custom_text.dart';
import '../controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: Styles.roundedBorderShap(),
      builder: (BuildContext context) {
        return ChangeLanguageBottomSheet();
      },
    );
  }

  final LanguageController _languageController = Get.put(
    LanguageController(),
  );
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 50),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Lottie.asset(
                AppImageAsset.login,
                width: 200,
                height: 200,
              ),
              const SizedBox(
                height: 50,
              ),
              const CustomText(
                text: 'App Name',
                color: AppColor.oranegapp,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.6,
                margin: const EdgeInsets.only(top: 50),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: AppColor.oranegapp,
                ),
                padding: const EdgeInsets.all(18),
                child: GetBuilder<LoginController>(
                    init: LoginController(),
                    builder: (controller) {
                      return LoadingManager(
                        isLoading: controller.isLoading,
                        child: Form(
                          key: formKey,
                          child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment:
                                    _languageController.selectedLanguage ==
                                            'en_US'
                                        ? CrossAxisAlignment.start
                                        : CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    _languageController.selectedLanguage ==
                                            'en_US'
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: "login".tr,
                                    color: AppColor.white,
                                    fontSize: 19,
                                  ),
                                  const SizedBox(height: 5),
                                  CustomText(
                                    text: "please_login".tr,
                                    color: AppColor.white,
                                    fontSize: 14,
                                  ),
                                  const SizedBox(height: 15),
                                  CustomText(
                                    text: "username".tr,
                                    color: AppColor.white,
                                    fontSize: 14,
                                  ),
                                  CustomTextForm(
                                    hintText: "example".tr,
                                    keyboardType: TextInputType.text,
                                    iconSuffixData: Icons.person_3_outlined,
                                    iconSuffixColor: AppColor.white,
                                    controller: controller.username,
                                    valid: (value) {
                                      if (value!.isEmpty) {
                                        return 'please_enter_username'.tr;
                                      } else if (value.length < 3) {
                                        return "Name less than 3 letters";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 15),
                                  CustomText(
                                    text: "password".tr,
                                    color: AppColor.white,
                                    fontSize: 14,
                                  ),
                                  Obx(() {
                                    return CustomTextForm(
                                      obscuretext: false,
                                         // controller.isPasswordHidden.value,
                                      hintText: 'password'.tr,
                                      keyboardType: TextInputType.text,
                                      iconSuffixData: Icons.lock_outline,
                                      iconPrefixData:
                                          controller.isPasswordHidden.value
                                              ? Icons.visibility_off_outlined
                                              : Icons.visibility_outlined,
                                      iconPrefixColor: AppColor.white,
                                      iconSuffixColor: AppColor.white,
                                      controller: controller.password,
                                      onTapPrefixIcon: () =>
                                          controller.togglePasswordVisibility(),
                                      valid: (value) {
                                        if (value!.isEmpty) {
                                          return 'please_enter_password'.tr;
                                        } else if (value.length < 5) {
                                          return "Name less than 5 letters";
                                        }
                                        return null;
                                      },
                                    );
                                  }),
                                  CustomText(
                                    text: "forget_password".tr,
                                    color: AppColor.white,
                                    fontSize: 11,
                                    //    alignment: Alignment.centerLeft,
                                  ),
                                  const SizedBox(height: 15),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: CustomElevatedButton(
                                      buttonColor: AppColor.buttongreen,
                                      borderColor: AppColor.appgreen,
                                      isChildRow: false,
                                      text: 'Signup'.tr,
                                      onPressed: () async {
                                        if (formKey.currentState!.validate()) {
                                          controller.setLoading(true);
                                          print(
                                              "username.text=${controller.username.text}");
                                          print(
                                              "password.text=${controller.password.text}");
                                          // controller.setLoading(true);
                                          controller.login();
                                          print('success from login screen');
                                          // Get.offAll(
                                          //   () => CustomBottomNavigationBar(),
                                          // );
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  CustomElevatedButton(
                                    isChildRow: true,
                                    text: 'change_language'.tr,
                                    onPressed: () {
                                      _showBottomSheet(context);
                                    },
                                    buttonColor: AppColor.white,
                                    textColor: AppColor.black,
                                    iconData: Icons.language,
                                    borderColor: AppColor.white,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/icons/iphonlogin.png',
                                          height: 40, width: 40),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                        child: Image.asset(
                                            'assets/icons/facebook.png',
                                            height: 40,
                                            width: 40),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                        child: Image.asset(
                                            'assets/icons/googleicon.png',
                                            height: 40,
                                            width: 40),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        text: 'Already have account?',
                                        color: AppColor.appgreen,
                                      ),
                                      CustomText(
                                        text: 'Register',
                                        color: AppColor.white,
                                      ),
                                    ],
                                  )
                                ]),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
