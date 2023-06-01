import 'package:flutter_login_app/data/repositories/locale_repository.dart';

class LocaleService {
  final LocaleRepository _localeRepository = LocaleRepository();
  late String _locale;

  String get locale => _locale;

  Stream<String> get localeStream => _localeRepository.localeStream;

  Future<void> getlocaleMode() async {
    _locale = await _localeRepository.getApplicationLocale();
  }

  Future<void> changeLocale({required String locale}) async {
    await getlocaleMode();
    await _localeRepository.setApplicationLocale(locale: locale);
  }
}
