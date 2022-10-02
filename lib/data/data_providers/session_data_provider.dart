import 'package:shared_preferences/shared_preferences.dart';

class SessionDataProvider {
  final sharedPreferences = SharedPreferences.getInstance();

  Future<String?> getApiKey() async {
    return (await sharedPreferences).getString('token');
  }

  Future<void> saveApiKey({required String token}) async {
    (await sharedPreferences).setString('token', token);
  }

  Future<void> clearApiKey() async {
    (await sharedPreferences).remove('token');
  }
}
