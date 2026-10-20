import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/localization/locale_cubit.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';

class LanguageDialog extends StatelessWidget {
  const LanguageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.tr('language')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(context.tr('english')),
            onTap: () {
              context.read<LocaleCubit>().changeLocale('en');
              context.pop();
            },
            trailing: Localizations.localeOf(context).languageCode == 'en'
                ? Icon(Icons.check, color: context.colorScheme.primary)
                : null,
          ),
          ListTile(
            title: Text(context.tr('arabic')),
            onTap: () {
              context.read<LocaleCubit>().changeLocale('ar');
              context.pop();
            },
            trailing: Localizations.localeOf(context).languageCode == 'ar'
                ? Icon(Icons.check, color: context.colorScheme.primary)
                : null,
          ),
        ],
      ),
    );
  }
}
