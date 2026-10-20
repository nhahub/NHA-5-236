import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/features/auth/data/model/auth_admin_reset_password_request_model.dart';
import 'package:lms_admin_instructor/features/auth/domain/repositories/auth_admin_repository.dart';
import 'package:lms_admin_instructor/features/auth/presentation/bloc/auth_admin_form_controller_mixin.dart';

part 'auth_admin_event.dart';
part 'auth_admin_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>
    with AuthAdminFromControllersMixin {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<ForgotPasswordEvent>(_onForgotPassword);
    on<ResetPasswordEvent>(_onResetPassword);
    on<ResendOtpEvent>(_onResendOtp);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await authRepository.logout();
    result.fold(
      (error) => emit(AuthError(message: error)),
      (success) => emit(LogoutSuccess()),
    );
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    if (!validateLoginForm()) {
      emit(AuthError(message: 'Please fill all fields correctly'));
      return;
    }

    emit(AuthLoading());

    final request = getLoginRequest();
    final result = await authRepository.login(request);

    result.fold(
      (errorMessage) {
        emit(AuthError(message: errorMessage));
      },
      (successResponse) {
        clearLoginControllers();
        emit(AuthSuccess(data: successResponse));
      },
    );
  }

  Future<void> _onForgotPassword(
    ForgotPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await authRepository.forgotPassword(event.email);

    result.fold(
      (error) => emit(AuthError(message: error)),
      (successMessage) => emit(ForgotPasswordSuccess(successMessage)),
    );
  }

  Future<void> _onResetPassword(
    ResetPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await authRepository.resetPassword(event.requestModel);

    result.fold(
      (error) => emit(AuthError(message: error)),
      (successMessage) => emit(AuthSuccess(data: successMessage)),
    );
  }

  Future<void> _onResendOtp(
    ResendOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await authRepository.resendOtp(event.email);

    result.fold(
      (error) => emit(AuthError(message: error)),
      (successMessage) => emit(ResendSuccess(successMessage)),
    );
  }
}
