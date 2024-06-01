import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:time_status/core/constant/shared_preferences_keys.dart';
import 'package:time_status/core/service/service.dart';
import 'package:time_status/core/constant/constant_data.dart';
import '../../../core/service/link.dart';
import '../view/register_screen.dart';
import '../../../../widget/bottom_nav_bar.dart';

class RegisterController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController username = TextEditingController();
  late TextEditingController password = TextEditingController();
  late TextEditingController email = TextEditingController();
  late TextEditingController phoneNumber = TextEditingController();
  RxBool isPasswordHidden = true.obs;
  bool isLoading = false;
  MyServices myServices = Get.find();

  @override
  void onInit() {
    username.text = '';
    password.text = '';
    super.onInit();
  }
void setLoading(bool value) {
    isLoading = value;
    update();
  }
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

  onEmailChanged(String value) {
    email.text = value; // Corrected assignment
    print("Email value= $value");
  }

  onPhoneNumberChanged(String value) {
    phoneNumber.text = value; // Corrected assignment
    print("PhoneNumber value= $value");
  }

  void signUp() async {
    try {
      String apiUrl = AppLink.register; // Specify your API endpoint here
      Map<String, dynamic> userData = {
        "username": username.text,
        "password": password.text,
        "email": email.text,
        "phoneNumber": phoneNumber.text
      };

      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer 4bc4cac033a5a44a67877c556b60159e',
        },
        body: jsonEncode(userData),
      );

      var decodeResponse = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        myServices.sharedPreferences.setString(
          SharedPreferencesKeys.username,
          username.text,
        );

        var token = decodeResponse["token"];
        ConstData.token = token;

        ConstData.isLogin = true;
        myServices.sharedPreferences.setString(
          SharedPreferencesKeys.tokenKey,
          ConstData.token,
        );

        myServices.sharedPreferences
            .setBool(SharedPreferencesKeys.isLoginKey, true);

        Get.offAll(
          () =>  CustomBottomNavigationBar(),
        );
      } else {
        Get.to(
          () => RegisterScreen(),
        );
        Get.snackbar("error".tr, "username_password_wrong".tr,
            backgroundColor: Colors.white);
      }
    } catch (e) {
      isLoading = false;
      Get.to(
        () => RegisterScreen(),
      );
      Get.snackbar("error".tr, "something_went_wrong".tr,
          backgroundColor: Colors.white);
    }
  }
}
