import 'package:flutter_login_app/domain/entities/count.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterDateProvider {
  final sharedPreferences = SharedPreferences.getInstance();

  /// Method to get values data from storage or API
  Future<Count> loadValue() async {
    Count count = Count((await sharedPreferences).getInt('count') ?? 0);
    return count;
  }

  /// Method to save data to storage or API
  Future<void> saveValue({required Count count}) async {
    (await sharedPreferences).setInt('count', count.count);
  }
}
