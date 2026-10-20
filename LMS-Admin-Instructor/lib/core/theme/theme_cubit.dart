import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/core/di/service_locator.dart';
import 'package:lms_admin_instructor/core/services/local/cache_helper.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light) {
    _loadSavedTheme();
  }

  static const String _themeKey = 'app_theme_mode';

  void _loadSavedTheme() {
    final dynamic isDarkMode = sl<CacheHelper>().getData(key: _themeKey);
    if (isDarkMode != null && isDarkMode is bool) {
      emit(isDarkMode ? ThemeMode.dark : ThemeMode.light);
    }
  }

  void toggleTheme() {
    final bool isDarkMode = state == ThemeMode.dark;
    sl<CacheHelper>().saveData(key: _themeKey, value: !isDarkMode);
    emit(isDarkMode ? ThemeMode.light : ThemeMode.dark);
  }
}
