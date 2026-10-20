import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lms_admin_instructor/core/localization/app_localizations.dart';
import 'package:lms_admin_instructor/core/routing/app_routes.dart';
import 'package:lms_admin_instructor/core/extensions/context_extensions.dart';
import 'package:lms_admin_instructor/features/auth/data/model/auth_admin_reset_password_request_model.dart';
import 'package:lms_admin_instructor/features/auth/presentation/bloc/auth_admin_bloc.dart';
import 'package:lms_admin_instructor/features/widgets/custom_button.dart';
import 'package:lms_admin_instructor/features/widgets/custon_text_form_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.tr('password_reset_success')),
              backgroundColor: context.colorScheme.secondary,
            ),
          );
          context.go(AppRoutes.loginScreen);
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
              key: authBloc.resetPasswordFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    context.tr('reset_password_title'),
                    style: context.textTheme.headlineMedium!.copyWith(
                      color: context.colorScheme.onSurface,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    context.tr('reset_password_subtitle'),
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 48.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, (index) {
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: TextFormField(
                              controller: authBloc.otpControllers[index],
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              style: context.textTheme.headlineSmall?.copyWith(
                                color: context.colorScheme.onSecondary,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                              ),
                              decoration: InputDecoration(
                                counterText: '',
                                contentPadding: EdgeInsets.zero,
                                filled: true,
                                fillColor: context.colorScheme.secondary
                                    .withValues(alpha: 0.03),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                  borderSide: BorderSide(
                                    color: context.colorScheme.secondary
                                        .withValues(alpha: 0.15),
                                    width: 1.5.w,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                  borderSide: BorderSide(
                                    color: context.colorScheme.secondary,
                                    width: 2.5.w,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                if (value.isNotEmpty && index < 5) {
                                  FocusScope.of(context).nextFocus();
                                } else if (value.isEmpty && index > 0) {
                                  FocusScope.of(context).previousFocus();
                                }
                              },
                            ),
                          ),
                        ),
                      );
                    }),
                  ),

                  SizedBox(height: 32.h),

                  CustomTextFormField(
                    controller: authBloc.newPasswordController,
                    txt: context.tr('new_password'),
                    hint: context.tr('new_password_hint'),
                    prefixIcon: Icons.lock_outline_rounded,
                    isPassword: true,
                    w: 400.w,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 16.h),

                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      final isLoading = state is AuthLoading;
                      return CustomTextFormField(
                        controller: authBloc.confirmNewPasswordController,
                        txt: context.tr('confirm_password'),
                        hint: context.tr('confirm_password_hint'),
                        prefixIcon: Icons.lock_outline_rounded,
                        isPassword: true,
                        w: 400.w,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (value) {
                          if (!isLoading) {
                            final otpCode = authBloc.getOtpCode();
                            if (otpCode.length < 6) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    context.tr('please_enter_full_otp'),
                                  ),
                                  backgroundColor: context.colorScheme.error,
                                ),
                              );
                              return;
                            }
                            authBloc.otpController.text = otpCode;
                            if (authBloc.resetPasswordFormKey.currentState
                                    ?.validate() ??
                                false) {
                              FocusScope.of(context).unfocus();
                              authBloc.add(
                                ResetPasswordEvent(
                                  requestModel: ResetPasswordRequestModel(
                                    otp: authBloc.otpController.text.trim(),
                                    newPassword: authBloc
                                        .newPasswordController
                                        .text
                                        .trim(),
                                  ),
                                ),
                              );
                            }
                          }
                        },
                      );
                    },
                  ),

                  SizedBox(height: 30.h),

                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      final isLoading = state is AuthLoading;
                      return CustomPrimaryButton(
                        text: isLoading
                            ? context.tr('saving')
                            : context.tr('save_password'),
                        onTap: isLoading
                            ? null
                            : () {
                                final otpCode = authBloc.getOtpCode();
                                if (otpCode.length < 6) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        context.tr('please_enter_full_otp'),
                                      ),
                                      backgroundColor:
                                          context.colorScheme.error,
                                    ),
                                  );
                                  return;
                                }
                                authBloc.otpController.text = otpCode;
                                if (authBloc.resetPasswordFormKey.currentState
                                        ?.validate() ??
                                    false) {
                                  FocusScope.of(context).unfocus();
                                  authBloc.add(
                                    ResetPasswordEvent(
                                      requestModel: ResetPasswordRequestModel(
                                        otp: authBloc.otpController.text.trim(),
                                        newPassword: authBloc
                                            .newPasswordController
                                            .text
                                            .trim(),
                                      ),
                                    ),
                                  );
                                }
                              },
                        width: 400.w,
                      );
                    },
                  ),

                  SizedBox(height: 32.h),

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
