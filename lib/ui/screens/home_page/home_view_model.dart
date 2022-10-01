import 'package:flutter/material.dart';

class HomeViewModel {
  final BuildContext context;
  final AuthRepository _authRepository = AuthRepository();

  HomeViewModel({required this.context});

  Future<void> onSettingButtonPressed() async {
    Navigator.of(context).pushNamed(AppNavigationRoutes.settingWidget);
  }

  Future<void> onLogoutButtonPressed() async {
    await _authRepository.logout();
    Navigator.of(context).pushNamedAndRemoveUntil(AppNavigationRoutes.loaderWidget, (route) => false);
  }
}
