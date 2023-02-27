import 'package:flutter/cupertino.dart';

enum LoginButtonState { canSubmit, disabled }

@immutable
class LoginPageState {
  final String authErrorTitle;
  final String login;
  final String password;
  final bool authInProcess;
  final bool hidePassword;

  LoginButtonState get loginButtonState {
    if (authInProcess) return LoginButtonState.disabled;
    if (login.isEmpty || password.isEmpty) return LoginButtonState.disabled;
    return LoginButtonState.canSubmit;
  }

  const LoginPageState({
    this.authErrorTitle = '',
    this.login = '',
    this.password = '',
    this.authInProcess = false,
    this.hidePassword = true,
  });

  LoginPageState copyWith({
    String? authErrorTitle,
    String? login,
    String? password,
    bool? authInProcess,
    bool? hidePassword,
  }) {
    return LoginPageState(
      authErrorTitle: authErrorTitle ?? this.authErrorTitle,
      login: login ?? this.login,
      password: password ?? this.password,
      authInProcess: authInProcess ?? this.authInProcess,
      hidePassword: hidePassword ?? this.hidePassword,
    );
  }
}
