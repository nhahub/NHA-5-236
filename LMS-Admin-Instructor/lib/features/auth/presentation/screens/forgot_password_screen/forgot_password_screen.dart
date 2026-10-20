import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/routing/app_routes.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/features/auth/presentation/bloc/auth_admin_bloc.dart';
import 'package:lms_admin_instructor/features/auth/utils/auth_validator.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';
import 'package:lms_admin_instructor/features/widgets/custon_text_form_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ForgotPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: context.colorScheme.secondary,
            ),
          );

          context.go(AppRoutes.resetPasswordScreen);
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: context.colorScheme.error,
            ),
          );
        }
      },
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400.w),
            child: Form(
              key: authBloc.forgetPasswordFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    context.tr('forgot_password_title'),
                    style: context.textTheme.headlineMedium!.copyWith(
                      color: context.colorScheme.onSurface,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 8.h),

                  Text(
                    context.tr('forgot_password_desc'),
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 48.h),

                  CustomTextFormField(
                    controller: authBloc.emailController,
                    txt: context.tr('email_address'),
                    hint: context.tr('email_hint'),
                    prefixIcon: Icons.email_outlined,
                    w: 400.w,
                    validator: validateEmail,
                  ),
                  SizedBox(height: 36.h),

                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      final isLoading = state is AuthLoading;
                      return CustomPrimaryButton(
                        text: isLoading
                            ? context.tr('sending')
                            : context.tr('send_an_email'),
                        onTap: isLoading
                            ? null
                            : () {
                                if (authBloc.forgetPasswordFormKey.currentState
                                        ?.validate() ??
                                    false) {
                                  FocusScope.of(context).unfocus();
                                  authBloc.add(
                                    ForgotPasswordEvent(
                                      email: authBloc.emailController.text
                                          .trim(),
                                    ),
                                  );
                                }
                              },
                        width: 400.w,
                      );
                    },
                  ),

                  SizedBox(height: 60.h),

                  Center(
                    child: TextButton.icon(
                      onPressed: () {
                        context.go(AppRoutes.loginScreen);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 10.sp,
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                      label: Text(
                        context.tr('go_back_to_login'),
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: context.colorScheme.onSurfaceVariant,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        splashFactory: NoSplash.splashFactory,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
