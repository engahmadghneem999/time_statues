import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/shared_preferences_keys.dart';

class MyServices extends GetxService {
  late SharedPreferences sharedPreferences;

  Future<MyServices> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }

  Future<void> storeToken(String token) async {
    await sharedPreferences.setString(SharedPreferencesKeys.tokenKey, token);
  }

  String? getToken() {
    return sharedPreferences.getString(SharedPreferencesKeys.tokenKey);
  }
}

initialServices() async {
  await Get.putAsync(() => MyServices().init());
}
