import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_admin_instructor/core/common/user_role_enum.dart';
import 'package:lms_admin_instructor/features/splash/domain/splash_repository.dart';
import 'package:lms_admin_instructor/features/splash/presentation/bloc/splash_event.dart';
import 'package:lms_admin_instructor/features/splash/presentation/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final SplashRepository splashRepository;

  SplashBloc({required this.splashRepository}) : super(SplashInitial()) {
    on<SplashStarted>(_onSplashStarted);
  }

  Future<void> _onSplashStarted(
    SplashStarted event,
    Emitter<SplashState> emit,
  ) async {
    emit(SplashLoading());
    final result = await splashRepository.checkLogin();
    result.fold((error) => emit(SplashError(message: error)), (
      checkAuthDataModel,
    ) {
      if (checkAuthDataModel.isActive != null &&
          checkAuthDataModel.isVerified != null &&
          checkAuthDataModel.isActive! &&
          checkAuthDataModel.isVerified!) {
        if (checkAuthDataModel.role != null &&
            checkAuthDataModel.role != UserRole.student) {
          emit(SplashLoaded(role: checkAuthDataModel.role!));
        } else {
          emit(const SplashError(message: "You are not authorized to login"));
        }
      } else {
        emit(
          SplashError(
            isActive: checkAuthDataModel.isActive,
            isVerified: checkAuthDataModel.isVerified,
          ),
        );
      }
    });
  }
}
