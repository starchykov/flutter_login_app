import 'package:flutter/cupertino.dart';
import 'package:flutter_login_app/ui/screens/home_page/home_page.dart';
import 'package:flutter_login_app/ui/screens/loader_page/loader_page.dart';
import 'package:flutter_login_app/ui/screens/login_page/login_page.dart';
import 'package:flutter_login_app/ui/screens/setting_page/setting_page.dart';



abstract class AppNavigationRoutes {
  static const loaderWidget = '/';
  static const loginWidget = '/login';
  static const homeWidget = '/home';
  static const settingWidget = '/setting';
}

class AppNavigation {
  final Map<String, Widget Function(BuildContext)> routes = <String, Widget Function(BuildContext)>{
    AppNavigationRoutes.loaderWidget: (context) => LoaderPage.render(),
    AppNavigationRoutes.loginWidget: (context) => LoginPage.render(),
    AppNavigationRoutes.homeWidget: (context) => HomePage.render(),
    AppNavigationRoutes.settingWidget: (context) => SettingPage.render(),
  };
}
