import 'package:flutter/material.dart';
import 'package:lms_admin_instructor/core/theme/app_theme.dart';

extension ThemeContext on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => theme.colorScheme;

  TextTheme get textTheme => theme.textTheme;

  CustomColors get extraColors => theme.extension<CustomColors>()!;
}