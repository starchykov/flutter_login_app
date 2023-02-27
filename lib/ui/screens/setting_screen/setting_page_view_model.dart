import 'package:flutter/cupertino.dart';
import 'package:flutter_login_app/domain/services/auth_service.dart';
import 'package:flutter_login_app/domain/services/theme_service.dart';
import 'package:flutter_login_app/ui/app_navigation/app_navigation.dart';
import 'package:flutter_login_app/ui/screens/setting_screen/setting_page_state.dart';

class SettingPageViewModel extends ChangeNotifier {
  final BuildContext context;
  final ThemeService _themeService = ThemeService();
  final AuthService _authService = AuthService();

  SettingPageState _state = const SettingPageState(isDarkTheme: false, isOfflineMode: false);

  SettingPageState get state => _state;

  SettingPageViewModel({required this.context}) {
    _initialize();
  }

  void _initialize() async {
    await setTheme();
  }

  Future<void> changeTheme() async {
    await _themeService.changeThemeMode();
    _state = _state.copyWith(isDarkTheme: _themeService.isDarkMode);
    notifyListeners();
  }

  Future<void> setTheme() async {
    await _themeService.getThemeMode();
    _state = _state.copyWith(isDarkTheme: _themeService.isDarkMode);
    notifyListeners();
  }

  Future<void> onLogoutButtonClicked() async {
    await _authService.logout();
    Navigator.of(context).pushNamedAndRemoveUntil(AppNavigationRoutes.loaderWidget, (route) => false);
  }
}
