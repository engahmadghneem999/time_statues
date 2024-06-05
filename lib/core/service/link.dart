import '../constant/constant_data.dart';

class AppLink {
  // Root
  static String appRoot = "http://algor.somee.com";
  static String serverApiRoot = "$appRoot/api";
  // Auth Links
  static String login = "$serverApiRoot/User/Login";
  static String register = "$serverApiRoot/User/register";
  static String logout = "$serverApiRoot/logout";
  // Home screen
  static String graphData = "$serverApiRoot/GraphData/";
  // User Profile
  static String getUserData = "$serverApiRoot/User/me";
  static String getAllFollowings = "$serverApiRoot/User/GetAllFollowings";
  static String followUser(String id) => "$serverApiRoot/User/FollowUser/$id";
  static String unFollowUser(String id) =>
      "$serverApiRoot/User/UnFollowUser/$id";
  static String getAllFollowers = "$serverApiRoot/User/GetAllFollowers";
  // One to One Chats
  static String getOneToOneChats = "$serverApiRoot/Chat/ChatPage";
  static String getInOneToOneChats(String id) =>
      "$serverApiRoot/Chat/ChatWithUser/$id";
  static String pinMessage(int id) => "$serverApiRoot/Chat/PinMessage/$id";
  static String favMessage(int id) =>
      "$serverApiRoot/Chat/FavouriteMessage/$id";
  static String getfavMessage(int id) =>
      "$serverApiRoot/Chat/GetFavouriteMessages/$id";
  static String getpinedMessage(String id) =>
      "$serverApiRoot/Chat/GetPinMessages/$id";
  // Groups
  static String getGroupsChats = "$serverApiRoot/ChatGroup";
  static String joinToGroup(int id) =>
      "$serverApiRoot/ChatGroup/JoinToGroup/$id";
  // Tasks
  static String getMainTask = "$serverApiRoot/MainTask";
  static String getSubTask = "$serverApiRoot/Task";
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
