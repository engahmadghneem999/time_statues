
import '../constant/constant_data.dart';

class AppLink {
  static String appRoot = "http://algor.somee.com";
  // static String appRoot="http://195.35.52.10:5000";
  static String serverApiRoot = "$appRoot/api";

  static String graphData= "$serverApiRoot/GraphData/";

  // static String imageWithRootUrl = ('$appRoot/storage/');
  // static String imageWithoutRootUrl = (appRoot);

//
  //static String test = "$serverApiRoot/";
  // static String register = "$serverApiRoot/auth/register";
  static String login = "$serverApiRoot/User/Login";
  static String logout = "$serverApiRoot/logout";

  //getSections
}

Map<String, String> getHeader() {
  Map<String, String> mainHeader = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'X-Requested-With': 'XMLHttpRequest',
  };
  return mainHeader;
}

Map<String, String> getHeaderToken() {
  Map<String, String> mainHeader = {
    // 'Content-Type': 'application/json',
    // 'Accept': 'application/json',
    // 'X-Requested-With': 'XMLHttpRequest',
    'Authorization': 'Bearer ${ConstData.token}',
  };
  return mainHeader;
}
//if (ConstData.isLogin) {
//     return {
//       ...mainHeader,
//       'Authorization': 'Bearer ${ConstData.token}',
//     };
