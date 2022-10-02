import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_login_app/domain/services/theme_service.dart';
import 'package:flutter_login_app/ui/app_navigation/app_navigation.dart';
import 'package:flutter_login_app/ui/screens/application/app_state.dart';

class AppViewModel extends ChangeNotifier {
  final ThemeService _themeService = ThemeService();
  final AppNavigation _appNavigation = AppNavigation();

  AppState _state = const AppState(isDarkTheme: false, isOfflineMode: false);

  AppState get state => _state;

  AppNavigation get appNavigation => _appNavigation;

  late StreamSubscription _themeSubscription;

  AppViewModel() {
    _themeSubscription = _themeService.themeStream.listen((_) => setTheme());
    setTheme();
  }

  Future<void> setTheme() async {
    await _themeService.getThemeMode();
    _state = _state.copyWith(isDarkTheme: _themeService.isDarkMode);
    notifyListeners();
  }

  @override
  void dispose() {
    _themeSubscription.cancel();
    super.dispose();
  }
}
