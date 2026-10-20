import 'package:flutter/material.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';

String? validatePassword(String? value, BuildContext context) {
  if (value == null || value.isEmpty) {
    return context.tr('val_password_required');
  }
  if (value.length < 8) {
    return context.tr('val_password_min_length');
  }
  if (value.length > 32) {
    return context.tr('val_password_max_length');
  }
  final passwordRegex = RegExp(
    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z\d!@#$%^&*(),.?":{}|<>]{8,32}$',
  );
  if (!passwordRegex.hasMatch(value)) {
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return context.tr('val_password_uppercase');
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return context.tr('val_password_lowercase');
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return context.tr('val_password_number');
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return context.tr('val_password_special');
    }
    return context.tr('val_password_format');
  }
  return null;
}
