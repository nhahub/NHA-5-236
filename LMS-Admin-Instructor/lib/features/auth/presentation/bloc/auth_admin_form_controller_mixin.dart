import 'package:flutter/material.dart';
import 'package:lms_admin_instructor/features/auth/data/model/auth_admin_login_request_model.dart';
import 'package:lms_admin_instructor/features/auth/data/model/auth_admin_reset_password_request_model.dart';

mixin AuthAdminFromControllersMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final List<TextEditingController> otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  final otpController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();
  bool validateResetPasswordForm() {
    return resetPasswordFormKey.currentState?.validate() ?? false;
  }

  ResetPasswordRequestModel getResetPasswordRequest() {
    return ResetPasswordRequestModel(
      otp: otpController.text.trim(),
      newPassword: newPasswordController.text.trim(),
    );
  }

  void clearResetPasswordControllers() {
    otpController.clear();
    newPasswordController.clear();
    confirmNewPasswordController.clear();
  }

  final registerFormKey = GlobalKey<FormState>();
  final loginFormKey = GlobalKey<FormState>();
  final forgetPasswordFormKey = GlobalKey<FormState>();
  final otpFormKey = GlobalKey<FormState>();
  final resetPasswordFormKey = GlobalKey<FormState>();

  void clearRegisterControllers() {
    emailController.clear();
    passwordController.clear();
  }

  bool validateLoginForm() {
    return loginFormKey.currentState?.validate() ?? false;
  }

  LoginRequestModel getLoginRequest() {
    return LoginRequestModel(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  void clearLoginControllers() {
    emailController.clear();
    passwordController.clear();
  }

  //verify email
  String getOtpCode() {
    return otpControllers.map((c) => c.text).join();
  }

  bool validateOtpForm() {
    return otpFormKey.currentState?.validate() ?? false;
  }

  void clearOtpControllers() {
    for (var controller in otpControllers) {
      controller.clear();
    }
  }

  // Dispose all
  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    otpController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
  }
}
