import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_login_app/domain/services/locale_service.dart';
import 'package:flutter_login_app/domain/services/theme_service.dart';
import 'package:flutter_login_app/ui/app_navigation/app_navigation.dart';
import 'package:flutter_login_app/ui/screens/application/app_state.dart';

class AppViewModel extends ChangeNotifier {
  final ThemeService _themeService = ThemeService();
  final AppNavigation _appNavigation = AppNavigation();
  final LocaleService _localeService = LocaleService();

  AppState _state = const AppState(isDarkTheme: false, isOfflineMode: false, locale: 'en');

  AppState get state => _state;

  AppNavigation get appNavigation => _appNavigation;

  late StreamSubscription _themeSubscription;
  late StreamSubscription<String> _localeSubscription;

  AppViewModel() {
    _themeSubscription = _themeService.themeStream.listen((_) => setTheme());
    _localeSubscription = _localeService.localeStream.listen((_) async => await _setCurrentLocale());
    setTheme();
  }

  Future<void> setTheme() async {
    await _themeService.getThemeMode();
    _state = _state.copyWith(isDarkTheme: _themeService.isDarkMode);
    notifyListeners();
  }

  Future<void> _setCurrentLocale() async {
    await _localeService.getlocaleMode();
    _state = _state.copyWith(locale: _localeService.locale);
    notifyListeners();
  }

  @override
  void dispose() {
    _themeSubscription.cancel();
    _localeSubscription.cancel();
    super.dispose();
  }

}
