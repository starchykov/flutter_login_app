import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mvvm_architecture/domain/services/theme_service.dart';
import 'package:mvvm_architecture/ui/widgets/application/app_state.dart';

class AppViewModel extends ChangeNotifier {
  final ThemeService _themeService = ThemeService();
  AppState _state =  AppState(isDarkTheme: false, isOfflineMode: false);

  AppState get state => _state;

  late StreamSubscription _themeSubscription;

  AppViewModel() {
    _themeSubscription = _themeService.themeStream.listen((_) => setTheme());
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