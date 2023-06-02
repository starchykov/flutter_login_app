import 'package:flutter/cupertino.dart';
import 'package:flutter_login_app/ui/screens/contacts_screen/contacts_screen.dart';
import 'package:flutter_login_app/ui/screens/counter_screen/counter_page.dart';
import 'package:flutter_login_app/ui/screens/home_screen/home_page.dart';
import 'package:flutter_login_app/ui/screens/loader_screen/loader_page.dart';
import 'package:flutter_login_app/ui/screens/login_screen/login_screen.dart';
import 'package:flutter_login_app/ui/screens/registration_screen/registration_screen.dart';
import 'package:flutter_login_app/ui/screens/setting_screen/setting_page.dart';

abstract class AppNavigationRoutes {
  static const loaderWidget = '/';
  static const loginWidget = '/login';
  static const registrationWidget = '/registration';
  static const homeWidget = '/home';
  static const contactsWidget = '/contacts';
  static const settingWidget = '/setting';
}

class AppNavigation {
  final Map<String, Widget Function(BuildContext)> routes = <String, Widget Function(BuildContext)>{
    AppNavigationRoutes.loaderWidget: (context) => LoaderPage.render(),
    AppNavigationRoutes.loginWidget: (context) => LoginScreen.render(),
    AppNavigationRoutes.registrationWidget: (context) => RegistrationScreen.render(),
    AppNavigationRoutes.homeWidget: (context) => HomeScreen.render(),
    AppNavigationRoutes.contactsWidget: (context) => ContactsScreen.render(),
    AppNavigationRoutes.settingWidget: (context) => SettingPage.render(),
  };

  final List<Widget> bottomNavigationScreens = <Widget>[
    ContactsScreen.render(),
    CounterPage.render(),
    SettingPage.render(),
  ];
}
