import '../constant/constant_data.dart';

class AppLink {
  //root
  static String appRoot = "http://algor.somee.com";
  static String serverApiRoot = "$appRoot/api";
  //Home screen graph
  static String graphData = "$serverApiRoot/GraphData/";
  //User Info GETS
  static String getUserData = "$serverApiRoot/User/me";
  //One to One Chats

  //Messages pin and fav POSTS
  static String pinMessage(int id) => "$serverApiRoot/Chat/PinMessage/$id";
  static String favMessage(int id) =>
      "$serverApiRoot/Chat/FavouriteMessage/$id";
  // fav and pinned GET
  static String getfavMessage(int id) =>
      "$serverApiRoot/Chat/GetFavouriteMessages/$id";
  static String getpinedMessage(int id) =>
      "$serverApiRoot/Chat/GetPinMessages/$id";
  //AUTH LINKS
  static String login = "$serverApiRoot/User/Login";
  static String register = "$serverApiRoot/User/register";
  static String logout = "$serverApiRoot/logout";
  //Groups
  //GET chats
  static String getGroupsChats = "$serverApiRoot/ChatGroup";
  static String joinToGroup(int id) =>
      "$serverApiRoot/ChatGroup/JoinToGroup/$id";
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
    'Authorization': 'Bearer ${ConstData.token}',
  };
  return mainHeader;
}
