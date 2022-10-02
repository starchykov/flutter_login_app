import 'package:flutter_login_app/data/data_providers/session_auth_provider.dart';
import 'package:flutter_login_app/data/data_providers/session_data_provider.dart';


class AuthRepository {
  final SessionAuthProvider _sessionAuthProvider = SessionAuthProvider();
  final SessionDataProvider _sessionDataProvider = SessionDataProvider();

  Future<bool> checkAuth() async {
    return await _sessionDataProvider.getApiKey() != null;
  }

  Future<void> login({required String login, required String password}) async {
    final String token = await _sessionAuthProvider.login(login: login, password: password);
    _sessionDataProvider.saveApiKey(token: token);
  }

  Future<void> logout() async {
    _sessionDataProvider.clearApiKey();
  }
}
