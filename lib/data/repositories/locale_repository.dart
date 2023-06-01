import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleRepository {
  LocaleRepository._internal();

  static final LocaleRepository _instance = LocaleRepository._internal();

  factory LocaleRepository() {
    return _instance;
  }

  final StreamController<String> _localeStreamController = StreamController<String>.broadcast();

  Stream<String> get localeStream => _localeStreamController.stream.asBroadcastStream();

  Future<String> getApplicationLocale() async {
    String locale = (await SharedPreferences.getInstance()).getString('app_locale') ?? 'en';
    return locale;
  }

  Future<void> setApplicationLocale({required String locale}) async {
    (await SharedPreferences.getInstance()).setString('app_locale', locale);
    _localeStreamController.add(locale);
  }
}
