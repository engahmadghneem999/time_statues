import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:time_status/core/constant/routes.dart';
import 'package:time_status/view/chatting/screens/group_chats/group_chats_screen.dart';
import 'package:time_status/view/home/screen/home_screen.dart';
import 'package:time_status/view/login/binding/login_binding.dart';
import 'package:time_status/view/map/screen/mapscreen.dart';
import 'package:time_status/view/mytasks/screens/team_screen.dart';
import 'package:time_status/view/profile/screens/profile.dart';
import 'package:time_status/view/splash/binding/splash_binding.dart';
import 'package:time_status/view/splash/screen/splash_screen.dart';
import 'view/chatting/screens/main_chat_screen/main_chat_screen.dart';
import 'view/login/screen/login_screen.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
    name: AppRoute.splash,
    page: () => const SplashScreen(),
    binding: SplashBinding(),
  ),

  GetPage(
    name:AppRoute.logIn,
    page: () =>  LoginScreen(),
    binding: LoginBinding(),
    transition: Transition.upToDown,
  ),
  GetPage(
    name:AppRoute.home,
    page: () =>  const HomeScreen(),
    transition: Transition.upToDown,
  ),
  GetPage(
    name: AppRoute.mapscreen,
    page: () =>   MapScreen(),
    transition: Transition.upToDown,
  ),  GetPage(
    name: AppRoute.chatting,
    page: () =>  const GroupChatsScreen(),
    transition: Transition.leftToRight,
  ), GetPage(
    name: AppRoute.team,
    page: () =>  const MyTasks(),
    transition: Transition.downToUp,
  ), GetPage(
    name: "/team",
    page: () =>  const MainChat(),
    transition: Transition.downToUp,
  ),
  GetPage(
    name: AppRoute.profile,
    page: () =>   ProfileScreen(),
    transition: Transition.downToUp,
  ),



  //
  // GetPage(
  //   name: "/setting",
  //   page: () => const SettingScreen(),
  //   transition: Transition.upToDown,
  // ),
];
