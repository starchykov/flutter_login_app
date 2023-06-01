import 'package:flutter/cupertino.dart';

@immutable
class SettingPageState {
  final bool isDarkTheme;
  final bool isOfflineMode;
  final int localeId;
  final String locale;

  const SettingPageState({
    this.isDarkTheme = false,
    this.isOfflineMode = false,
    this.localeId = 0,
    this.locale = '',
  });

  SettingPageState copyWith({
    bool? isDarkTheme,
    bool? isOfflineMode,
    int? localeId,
    String? locale,
  }) {
    return SettingPageState(
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      isOfflineMode: isOfflineMode ?? this.isOfflineMode,
      localeId: localeId ?? this.localeId,
      locale: locale ?? this.locale,
    );
  }
}
