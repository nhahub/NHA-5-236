import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/features/auth/presentation/bloc/auth_admin_bloc.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.tr('logout')),
      content: Text(context.tr('logout_confirmation')),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(context.tr('cancel')),
        ),
        TextButton(
          onPressed: () {
            context.pop();
            context.read<AuthBloc>().add(LogoutEvent());
          },
          child: Text(
            context.tr('logout'),
            style: TextStyle(color: context.colorScheme.error),
          ),
        ),
      ],
    );
  }
}
