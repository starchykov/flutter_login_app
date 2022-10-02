import 'package:flutter/material.dart';
import 'package:flutter_login_app/domain/services/auth_service.dart';
import 'package:flutter_login_app/ui/app_navigation/app_navigation.dart';

class HomeViewModel {
  final BuildContext context;
  final AuthRepository _authRepository = AuthRepository();
  final AppNavigation _appNavigation = AppNavigation();

  HomeViewModel({required this.context});

  Future<void> onSettingButtonPressed() async {
    Navigator.of(context).pushNamed(AppNavigationRoutes.settingWidget);
  }

  Future<void> onLogoutButtonPressed() async {
    await _authRepository.logout();
    Navigator.of(context).pushNamedAndRemoveUntil(AppNavigationRoutes.loaderWidget, (route) => false);
  }

  Widget renderScreen({required int screenIndex}) {
    return _appNavigation.bottomNavigationScreens[screenIndex];
  }
}
