import 'package:flutter/cupertino.dart';
import 'package:flutter_login_app/domain/network_client/network_exceptions.dart';
import 'package:flutter_login_app/domain/services/auth_repository.dart';
import 'package:flutter_login_app/ui/navigation/app_navigation.dart';
import 'package:flutter_login_app/ui/screens/login_page/login_page_state.dart';


class LoginPageViewModel extends ChangeNotifier {
  LoginPageState _state = const LoginPageState();

  final AuthRepository _authRepository = AuthRepository();

  LoginPageState get state => _state;

  void login({required String value}) {
    if (_state.login == value) return;
    _state = _state.copyWith(login: value);
    notifyListeners();
  }

  void password({required String value}) {
    if (_state.password == value) return;
    _state = _state.copyWith(password: value);
    notifyListeners();
  }

  Future<void> onLoginButtonPress({required BuildContext context}) async {
    final String login = _state.login;
    final String password = _state.password;

    if (login.isEmpty || password.isEmpty) return;

    _state = _state.copyWith(authInProcess: true, authErrorTitle: '');
    notifyListeners();

    try {
      await _authRepository.login(login: login, password: password);
      _state = _state.copyWith(authInProcess: false, authErrorTitle: '');
      /// Unsafe to use context in async functions because widget can be unmounted and context will be unavailable
      Navigator.of(context).pushNamedAndRemoveUntil(AppNavigationRoutes.homeWidget, (route) => false);
    } on ApiClientException catch (error) {
      _state = _state.copyWith(authInProcess: false, authErrorTitle: error.message);
    } on Exception {
      _state = _state.copyWith(authInProcess: false, authErrorTitle: 'Some error occurred');
    } finally {
      notifyListeners();
    }
  }
}
