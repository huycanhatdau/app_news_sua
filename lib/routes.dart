import 'package:auth_fire/pages/account/home/page.dart';
import 'package:auth_fire/pages/account/information/page.dart';
import 'package:auth_fire/pages/account/login/page.dart';
import 'package:auth_fire/pages/home/page.dart';
import 'package:auth_fire/pages/start/start.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'pages/account/register/page.dart';

List<GetPage<dynamic>> routes = [
  GetPage(
    name: '/initStart',
    page: () => const StartPage(),
  ),
  GetPage(
    name: '/login',
    page: () => const AccountLoginPage(),
  ),
  GetPage(
    name: '/home',
    page: () => const HomePage(),
  ),
  GetPage(
    name: '/register',
    page: () => const AccountRegisterPage(),
  ),
  GetPage(
    name: '/account_home',
    page: () => const AccountHomePage(),
  ),
  GetPage(
    name: '/account_information',
    page: () => const AccountInformationPage(),
  ),
];