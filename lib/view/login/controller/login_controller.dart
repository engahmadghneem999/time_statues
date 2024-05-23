import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_status/core/constant/constant_data.dart';
import 'package:time_status/core/constant/shared_preferences_keys.dart';
import 'package:time_status/view/home/screen/home_screen.dart';
import '../../../core/class/status_request.dart';
import '../../../core/service/link.dart';
import '../../../core/service/service.dart';
import 'package:http/http.dart' as http;
import '../../../widget/bottom_nav_bar.dart';
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
    print("enter login");
    try {
      print("try");
      String url= "${AppLink.login}?username=${username.text}&password=${password.text}";
      print("url=$url");
      var response = await http.post(
        // Uri.parse("https://center.lavetro-agency.com/api/login"),
       // Uri.parse("http://195.35.52.10:5000/api/User/Login?username=${username.text}&password=${password.text}"),
       Uri.parse(url),
        headers: {
          // 'Authorization': 'Bearer ${ConstData.token}',

          'Authorization': 'Bearer 4bc4cac033a5a44a67877c556b60159e',
        },
          // 4bc4cac033a5a44a67877c556b60159e
        // body: {
        //   "username": username.text,
        //   "password": password.text,
        // },
      );
      print("jsonDecode = ${response.body}");
      print("statuscode=${response.statusCode}");
      var decodeResponse = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode==201) {


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

        Get.offAll(
              () => const CustomBottomNavigationBar(),
        );
        isLoading = false;
        update();
        // ConstData.token = decodeResponse["token"];
        return true;
      }
      else {
        isLoading = false;
        Get.to(
              () => LoginScreen(),
        );
        Get.snackbar("error".tr, "username_password_wrong".tr,
            backgroundColor: Colors.white);

        return null;
      }
    } catch (e) {
      print('error catch=$e');
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
