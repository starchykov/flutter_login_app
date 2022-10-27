import 'package:flutter/material.dart';
import 'package:flutter_login_app/domain/services/auth_service.dart';
import 'package:flutter_login_app/ui/app_navigation/app_navigation.dart';

class LoaderViewModel {
  final BuildContext context;
  final AuthRepository _authRepository = AuthRepository();

  LoaderViewModel({required this.context}) {
    _initialize();
  }

  void _initialize() async {
    bool isAuthorize = await _authRepository.checkAuth();
    String nextRoute = isAuthorize ? AppNavigationRoutes.homeWidget : AppNavigationRoutes.loginWidget;
    Navigator.of(context).pushNamedAndRemoveUntil(nextRoute, (route) => false);
  }
}
