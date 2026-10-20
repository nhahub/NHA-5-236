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

class LoginRightSide extends StatelessWidget {
  const LoginRightSide({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                context.tr('login_success'),
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.colorScheme.surface,
                ),
              ),
              backgroundColor: context.colorScheme.secondary,
            ),
          );
          context.go(AppRoutes.navBar, extra: {"role": state.data.user.role});
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.colorScheme.surface,
                ),
              ),
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
              key: authBloc.loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    context.tr('welcome_back'),
                    style: context.textTheme.headlineMedium!.copyWith(
                      color: context.colorScheme.onSurface,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    context.tr('good_to_see_you_again'),
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: 48.h),

                  CustomTextFormField(
                    controller: authBloc.emailController,
                    txt: context.tr('email_address'),
                    hint: context.tr('email_hint'),
                    prefixIcon: Icons.alternate_email_rounded,
                    validator: validateEmail,
                    w: 400.w,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 16.h),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      final isLoading = state is AuthLoading;
                      return CustomTextFormField(
                        controller: authBloc.passwordController,
                        txt: context.tr('password'),
                        hint: context.tr('password_hint'),
                        prefixIcon: Icons.lock_outline_rounded,
                        isPassword: true,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (value) {
                          if (!isLoading) {
                            FocusScope.of(context).unfocus();
                            context.read<AuthBloc>().add(LoginEvent());
                          }
                        },

                        ///TODO: Add password validation
                        // validator: validatePassword,
                        w: 400.w,
                      );
                    },
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () =>
                          context.pushNamed(AppRoutes.forgotPasswordScreen),
                      child: Text(
                        context.tr('forgot_password'),
                        style: context.textTheme.labelSmall!.copyWith(
                          color: context.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),

                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      final isLoading = state is AuthLoading;
                      return CustomPrimaryButton(
                        text: "Sign In",
                        onTap: isLoading
                            ? null
                            : () {
                                FocusScope.of(context).unfocus();
                                context.read<AuthBloc>().add(LoginEvent());
                              },
                        width: 400.w,
                      );
                    },
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
