import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/change_password_repository.dart';
import 'change_password_event.dart';
import 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ChangePasswordRepository repository;

  ChangePasswordBloc({required this.repository})
      : super(ChangePasswordInitial()) {
    on<ChangePasswordSubmitEvent>(_onChangePasswordSubmit);
  }

  Future<void> _onChangePasswordSubmit(
    ChangePasswordSubmitEvent event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(ChangePasswordLoading());

    final response = await repository.changePassword(event.request);

    response.fold(
      (failure) => emit(ChangePasswordError(message: failure)),
      (success) => emit(ChangePasswordSuccess(changePasswordModel: success)),
    );
  }
}
