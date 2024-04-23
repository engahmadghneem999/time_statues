import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_status/core/constant/constant_data.dart';
import 'package:time_status/core/constant/shared_preferences_keys.dart';
import 'package:time_status/view/home/screen/home_screen.dart';
import '../../../core/class/status_request.dart';
import '../../../core/service/service.dart';
import 'package:http/http.dart' as http;
import '../screen/login_screen.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController username = TextEditingController();
  late TextEditingController password = TextEditingController();
  RxBool isPasswordHidden = true.obs;

  @override
  void onInit() {
    username.text = '';
    password.text = '';
    super.onInit();
  }

  //RegisterData registerData = RegisterData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  onUsernameChanged(String value) {
    username.text = value;
    print("username value= $value");
  }

  onPasswordChanged(String value) {
    password.text = value;
    print("password value= $value");
  }

  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  login() async {
    try {
      var response = await http.post(
        Uri.parse("https://center.lavetro-agency.com/api/login"),
        //Uri.parse(AppLink.login),
        headers: {
          'Authorization': 'Bearer ${ConstData.token}',
        },
        body: {
          "username": username.text,
          "password": password.text,
        },
      );
      print("jsonDecode = ${response.body}");
      var decodeResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        print("20000000000");
        myServices.sharedPreferences.setString(
          SharedPreferencesKeys.username,
          username.text,
        );

        var token = decodeResponse["token"];
        ConstData.token = token;
        print('ConstData=  ${ConstData.token}');

        ConstData.isLogin = true;
        // ConstData.token = token;
        myServices.sharedPreferences.setString(
          SharedPreferencesKeys.tokenKey,
          ConstData.token,
        );
        print("ConstData.token= ${ConstData.token}");

        myServices.sharedPreferences
            .setBool(SharedPreferencesKeys.isLoginKey, true);
        print(response.statusCode);

        Get.to(
              () => HomeScreen(),
        );
        isLoading = false;
        update();
        // ConstData.token = decodeResponse["token"];
        return true;
      } else {
        isLoading = false;
        Get.to(
              () => LoginScreen(),
        );
        Get.snackbar("error".tr, "username_password_wrong".tr,
            backgroundColor: Colors.white);

        return null;
      }
    } catch (e) {
      isLoading = false;
      Get.to(
            () => LoginScreen(),
      );
      print('e in catchlogin=$e');
      Get.snackbar(
        "error".tr,
        "something_went_wrong".tr,
        backgroundColor: Colors.white,
      );
    }
  }
}
