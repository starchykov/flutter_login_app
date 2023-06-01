
import 'package:flutter/cupertino.dart';

@immutable
class AppState {
  final bool isDarkTheme;
  final bool isOfflineMode;
  final String locale;

  const AppState({
    required this.isDarkTheme,
    required this.isOfflineMode,
    required this.locale,
  });

  AppState copyWith({
    bool? isDarkTheme,
    bool? isOfflineMode,
    String? locale,
  }) {
    return AppState(
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      isOfflineMode: isOfflineMode ?? this.isOfflineMode,
      locale: locale ?? this.locale,
    );
  }
}