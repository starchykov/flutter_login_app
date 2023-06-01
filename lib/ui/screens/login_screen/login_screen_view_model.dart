import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_app/domain/network_client/network_exceptions.dart';
import 'package:flutter_login_app/domain/services/auth_service.dart';
import 'package:flutter_login_app/ui/app_navigation/app_navigation.dart';
import 'package:flutter_login_app/ui/screens/login_screen/login_screen_state.dart';


class LoginPageViewModel extends ChangeNotifier {
  final BuildContext context;

  final AuthService _authRepository = AuthService();
  LoginPageState _state = const LoginPageState();

  LoginPageState get state => _state;

  LoginPageViewModel({required this.context});

  ///
  void login({required String value}) {
    if (_state.login == value) return;
    _state = _state.copyWith(login: value);
    notifyListeners();
  }

  /// 
  void password({required String value}) {
    if (_state.password == value) return;
    _state = _state.copyWith(password: value);
    notifyListeners();
  }

  /// This Flutter method is used to show or hide input text in an application.
  /// It utilizes HapticFeedback to create a selection click sound,
  /// and then uses the copyWith() method to update the state of the input text to show or hide it.
  /// After the state has been updated, it calls the notifyListeners() method to notify any listeners of the change.
  void showPassword() {
    HapticFeedback.selectionClick();
    _state = _state.copyWith(hidePassword: !_state.hidePassword);
    notifyListeners();
  }

  Future<void> onLoginButtonPress() async {
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

  void registration() {
    Navigator.of(context).pushNamed(AppNavigationRoutes.registrationWidget);
  }
}
