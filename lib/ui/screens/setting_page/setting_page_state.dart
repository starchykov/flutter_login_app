import 'package:flutter/cupertino.dart';

@immutable
class SettingPageState {
  final bool isDarkTheme;
  final bool isOfflineMode;

  const SettingPageState({
    this.isDarkTheme = false,
    this.isOfflineMode = false,
  });

  SettingPageState copyWith({
    bool? isDarkTheme,
    bool? isOfflineMode,
  }) {
    return SettingPageState(
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      isOfflineMode: isOfflineMode ?? this.isOfflineMode,
    );
  }
}
